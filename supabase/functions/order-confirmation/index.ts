// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import '@supabase/functions-js/edge-runtime.d.ts'
import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'

interface Order {
    id: string
    shop_id: string
    user_id: string
    order_number: bigint
    note: string
    total_price: bigint
    status: string
    created_at: Date
}

interface WebhookPayload {
    type: 'UPDATE'
    table: string
    record: Order
    schema: 'public'
    old_record: Order
}

const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? ''
const supabaseServiceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''

const supabase = createClient(
    supabaseUrl,
    supabaseServiceRoleKey,
)

Deno.serve(async (req) => {
    const payload: WebhookPayload = await req.json()
    const { data } = await supabase.from('profiles').select('fcm_token').eq('id', payload.record.user_id).single()

    const fcmToken = data!.fcm_token as string

    const { default: serviceAccount } = await import('../service-account.json', { with: { type: 'json' } })

    const accessToken = await getAccessToken({
        clientEmail: serviceAccount.client_email,
        privateKey: serviceAccount.private_key,
    })

    let title: string, body: string | null

    switch (payload.record.status) {
        case 'preparing':
            title = 'Đơn hàng đang được chuẩn bị'
            break;
        case 'completed':
            title = 'Đơn hàng của bạn đã hoàn thành'
            body = `Đơn hàng số ${payload.record.order_number} đã hoàn thành`
    }

    const res = await fetch(
        `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
        {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                Authorization: `Bearer ${accessToken}`,
            },
            body: JSON.stringify({
                message: {
                    token: fcmToken,
                    notification: {
                        title: title,
                        body: body,
                    },
                },
            }),
        },
    )

    const resData = await res.json()
    if (res.status < 200 || 299 < res.status) {
        throw resData
    }

    return new Response(
        JSON.stringify(resData),
        { headers: { 'Content-Type': 'application/json' } },
    )
})

const getAccessToken = ({ clientEmail, privateKey }): Promise<string> => {
    return new Promise((resolve, reject) => {
        const jwtClient = new JWT({
            email: clientEmail,
            key: privateKey,
            scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
        })
        jwtClient.authorize((error, tokens) => {
            if (error) {
                reject(error)
                return
            }
            resolve(tokens!.access_token!)
        })
    })
}
