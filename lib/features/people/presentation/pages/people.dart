import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';
import 'package:Fortress/features/conversations/domain/use_cases/get_or_create_direct_chat_usecase.dart';
import 'package:Fortress/injection.dart';
import '../bloc/people_bloc.dart';
import '../bloc/people_event.dart';
import '../bloc/people_state.dart';
import '../widgets/connection_tile.dart';
import '../widgets/people_empty_state.dart';
import '../widgets/request_tile.dart';
import '../widgets/search_user_sheet.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PeopleBloc>()..add(const LoadPeople()),
      child: const _PeopleView(),
    );
  }
}

class _PeopleView extends StatelessWidget {
  const _PeopleView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PeopleBloc, PeopleState>(
      listenWhen: (previous, current) =>
          (previous.actionSuccessMessage != current.actionSuccessMessage &&
              current.actionSuccessMessage != null) ||
          (previous.errorMessage != current.errorMessage &&
              current.errorMessage != null) ||
          (previous.acceptedChatRoomId != current.acceptedChatRoomId &&
              current.acceptedChatRoomId != null),
      listener: (context, state) {
        if (state.actionSuccessMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.actionSuccessMessage!),
              backgroundColor: ColoursDark.surfaceVariant,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: ColoursDark.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        if (state.acceptedChatRoomId != null) {
          context.push('/home/chat/${state.acceptedChatRoomId}');
        }
      },
      builder: (context, state) {
        final pendingCount = state.pendingIncoming.length;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: ColoursDark.background,
            appBar: AppBar(
              backgroundColor: ColoursDark.background,
              elevation: 0,
              title: const Text(
                'People',
                style: TextStyle(
                  color: ColoursDark.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              bottom: TabBar(
                indicatorColor: ColoursDark.primary,
                indicatorWeight: 3,
                labelColor: ColoursDark.primary,
                unselectedLabelColor: ColoursDark.onSurfaceMuted,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                tabs: [
                  Tab(text: 'Contacts (${state.accepted.length})'),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Requests'),
                        if (pendingCount > 0) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: ColoursDark.tertiary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$pendingCount',
                              style: const TextStyle(
                                color: ColoursDark.onTertiary,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => SearchUserSheet.show(context),
              backgroundColor: ColoursDark.primary,
              foregroundColor: ColoursDark.onPrimary,
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Add Contact', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            body: TabBarView(
              children: [
                // 1. Contacts Tab
                RefreshIndicator(
                  color: ColoursDark.primary,
                  onRefresh: () async {
                    context.read<PeopleBloc>().add(const RefreshPeople());
                  },
                  child: state.accepted.isEmpty
                      ? const PeopleEmptyState(
                          icon: Icons.people_outline_rounded,
                          title: 'No contacts yet',
                          subtitle:
                              'Connect with other Fortress users by tapping "Add Contact" below.',
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            top: AppSpacing.sm,
                            bottom: 80,
                          ),
                          itemCount: state.accepted.length,
                          itemBuilder: (context, index) {
                            final contact = state.accepted[index];
                            return ConnectionTile(
                              connection: contact,
                              onTap: () async {
                                // Open 1:1 chat room
                                try {
                                  final getOrCreateChat =
                                      getIt<GetOrCreateDirectChatUsecase>();
                                  final result =
                                      await getOrCreateChat(contact.otherUid);
                                  if (!context.mounted) return;
                                  result.fold(
                                    (fail) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(fail.message),
                                        backgroundColor: ColoursDark.error,
                                      ),
                                    ),
                                    (room) => context.push(
                                      '/home/chat/${room.id}',
                                      extra: contact.otherName,
                                    ),
                                  );
                                } catch (_) {
                                  if (!context.mounted) return;
                                  // Fallback direct navigate
                                  context.push(
                                    '/home/chat/direct_${contact.otherUid}',
                                    extra: contact.otherName,
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),

                // 2. Requests Tab
                RefreshIndicator(
                  color: ColoursDark.primary,
                  onRefresh: () async {
                    context.read<PeopleBloc>().add(const RefreshPeople());
                  },
                  child: (state.pendingIncoming.isEmpty && state.sentOutgoing.isEmpty)
                      ? const PeopleEmptyState(
                          icon: Icons.mark_email_read_outlined,
                          title: 'No pending requests',
                          subtitle: 'Incoming and outgoing requests will show up here.',
                        )
                      : ListView(
                          padding: const EdgeInsets.only(
                            top: AppSpacing.sm,
                            bottom: 80,
                          ),
                          children: [
                            if (state.pendingIncoming.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.xs,
                                ),
                                child: Text(
                                  'INCOMING (${state.pendingIncoming.length})',
                                  style: const TextStyle(
                                    color: ColoursDark.onSurfaceMuted,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              ...state.pendingIncoming.map(
                                (req) => RequestTile(
                                  connection: req,
                                  isIncoming: true,
                                  onAccept: () => context
                                      .read<PeopleBloc>()
                                      .add(AcceptRequestEvent(req.id)),
                                  onReject: () => context
                                      .read<PeopleBloc>()
                                      .add(RejectRequestEvent(req.id)),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                            ],
                            if (state.sentOutgoing.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.xs,
                                ),
                                child: Text(
                                  'SENT (${state.sentOutgoing.length})',
                                  style: const TextStyle(
                                    color: ColoursDark.onSurfaceMuted,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              ...state.sentOutgoing.map(
                                (req) => RequestTile(
                                  connection: req,
                                  isIncoming: false,
                                ),
                              ),
                            ],
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}