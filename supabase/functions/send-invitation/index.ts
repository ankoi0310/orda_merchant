// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import '@supabase/functions-js/edge-runtime.d.ts'

interface Invitation {
    id: string
    shopId: string
    email: string
    role: string
    invitedBy: string
    status: string
    createdAt: Date
}

interface WebhookPayload {
    type: 'INSERT'
    table: string
    record: Invitation
    schema: 'public'
    old_record: null | Invitation
}

const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')

const handler = async (request: Request): Promise<Response> => {
    const payload: WebhookPayload = await request.json()

    if (!payload?.record?.email) {
        return new Response(JSON.stringify({ error: 'Missing email' }), { status: 400 })
    }

    const res = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${RESEND_API_KEY}`,
        },
        body: JSON.stringify({
            from: 'onboarding@resend.dev',
            to: [payload.record.email],
            subject: 'Bạn được mời vào cửa hàng',
            html: `<p>Click để tham gia</p>`,
        }),
    })

    const data = await res.json()
    console.log(data)

    return new Response(JSON.stringify(data), {
        status: 200,
        headers: {
            'Content-Type': 'application/json',
        },
    })
}

Deno.serve(handler)
