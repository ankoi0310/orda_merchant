import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/bloc/user_setup/user_setup_cubit.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/invitation/presentation/bloc/invitation_bloc.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvitationBloc, InvitationState>(
      listener: (context, state) {
        print(state);
        if (state is RejectInvitationSuccess) {
          context.go(AppRouter.welcome);
        }
        if (state is AcceptInvitationSuccess) {
          context.go(AppRouter.dashboard);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<UserSetupCubit, UserSetupState>(
            buildWhen: (prev, curr) => curr is UserSetupHasInvitation,
            builder: (context, state) {
              final invitation =
                  (state as UserSetupHasInvitation).invitation;
              return Center(
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Container(
                      margin: .symmetric(
                        vertical: context.height * .05,
                      ),
                      child: Column(
                        spacing: 8,
                        children: [
                          Text(
                            'Orda Merchant',
                            style: context.textTheme.displayMedium!
                                .copyWith(
                                  fontWeight: .bold,
                                  foreground: Paint()
                                    ..shader =
                                        LinearGradient(
                                          colors: [
                                            context.colors.primary,
                                            context.colors.primary
                                                .withValues(
                                                  alpha: 0.7,
                                                ),
                                          ],
                                        ).createShader(
                                          const .fromLTWH(
                                            0,
                                            0,
                                            80,
                                            70,
                                          ),
                                        ),
                                ),
                          ),
                          Text(
                            'Bạn có lời mời',
                            style: context.textTheme.headlineLarge,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const .all(16),
                      margin: const .all(16),
                      decoration: BoxDecoration(
                        color: context.colors.outline,
                        borderRadius: .circular(16),
                      ),
                      child: Column(
                        spacing: 16,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text:
                                      'Đồng ý tham gia với vai trò là ',
                                ),
                                TextSpan(
                                  text: invitation.role.label,
                                  style: const TextStyle(
                                    fontWeight: .bold,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: .center,
                            style: context.textTheme.titleMedium,
                          ),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            spacing: 16,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  context.read<InvitationBloc>().add(
                                    RejectInvitation(invitation.id),
                                  );
                                },
                                child: const Text('Từ chối'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<InvitationBloc>().add(
                                    AcceptInvitation(invitation.id),
                                  );
                                },
                                child: const Text('Đồng ý'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
