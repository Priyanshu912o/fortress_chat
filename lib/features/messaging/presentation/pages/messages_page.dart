import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../../../../injection.dart';
import '../bloc/messaging_bloc.dart';
import '../bloc/messaging_event.dart';
import '../bloc/messaging_state.dart';
import '../widgets/date_separator.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input_bar.dart';
import '../widgets/typing_indicator.dart';

class MessagesPage extends StatelessWidget {
  final String chatRoomId;
  final String? chatRoomName;

  const MessagesPage({
    super.key,
    required this.chatRoomId,
    this.chatRoomName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MessagingBloc>()..add(LoadMessages(chatRoomId)),
      child: _MessagesView(chatRoomName: chatRoomName),
    );
  }
}

class _MessagesView extends StatefulWidget {
  final String? chatRoomName;

  const _MessagesView({this.chatRoomName});

  @override
  State<_MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<_MessagesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<MessagingBloc>().add(const LoadMoreMessages());
    }
  }

  bool _isDifferentDay(DateTime a, DateTime b) {
    return a.year != b.year || a.month != b.month || a.day != b.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingBloc, MessagingState>(
      builder: (context, state) {
        final title = widget.chatRoomName ?? 'Chat';

        return Scaffold(
          backgroundColor: ColoursDark.background,
          appBar: AppBar(
            backgroundColor: ColoursDark.surface,
            elevation: 1,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor: ColoursDark.primary.withOpacity(0.2),
                  child: Text(
                    title.isNotEmpty ? title[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: ColoursDark.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: ColoursDark.onBackground,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        state.isOtherTyping ? 'typing...' : 'Secured',
                        style: TextStyle(
                          color: state.isOtherTyping
                              ? ColoursDark.secondary
                              : ColoursDark.onSurfaceMuted,
                          fontSize: 12,
                          fontWeight: state.isOtherTyping
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              // Security banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 6,
                ),
                decoration: const BoxDecoration(
                  gradient: AppGradients.securityBanner,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 13,
                      color: ColoursDark.secondary.withOpacity(0.9),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'End-to-end verified trust handshake',
                      style: TextStyle(
                        color: ColoursDark.secondary.withOpacity(0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Messages list
              Expanded(
                child: state.isLoading && state.messages.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: ColoursDark.primary,
                        ),
                      )
                    : state.messages.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.xl),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(AppSpacing.lg),
                                    decoration: BoxDecoration(
                                      color: ColoursDark.surfaceVariant
                                          .withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.lock_clock_outlined,
                                      size: 40,
                                      color: ColoursDark.onSurfaceMuted,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  const Text(
                                    'No messages yet',
                                    style: TextStyle(
                                      color: ColoursDark.onBackground,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Send a message to start this conversation.',
                                    style: TextStyle(
                                      color: ColoursDark.onSurfaceMuted,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.sm,
                            ),
                            itemCount: state.messages.length +
                                (state.isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == state.messages.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(AppSpacing.md),
                                  child: Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: ColoursDark.primary,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final message = state.messages[index];
                              final hasNext = index < state.messages.length - 1;
                              final nextMessage =
                                  hasNext ? state.messages[index + 1] : null;

                              final showDateSeparator = nextMessage == null ||
                                  _isDifferentDay(
                                    message.sentAt,
                                    nextMessage.sentAt,
                                  );

                              return Column(
                                children: [
                                  if (showDateSeparator)
                                    DateSeparator(date: message.sentAt),
                                  MessageBubble(
                                    message: message,
                                    showSenderName: !message.isMe,
                                  ),
                                ],
                              );
                            },
                          ),
              ),

              // Typing indicator
              if (state.isOtherTyping)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TypingIndicator(),
                ),

              // Input bar
              MessageInputBar(
                onSend: (text) {
                  context.read<MessagingBloc>().add(SendMessageEvent(text));
                },
                onTyping: (isTyping) {
                  context.read<MessagingBloc>().add(SendTypingEvent(isTyping));
                },
              ),
            ],
          ),
        );
      },
    );
  }f
}
