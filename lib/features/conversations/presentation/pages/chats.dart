import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../../../../injection.dart';
import '../bloc/conversations_bloc.dart';
import '../bloc/conversations_event.dart';
import '../bloc/conversations_state.dart';
import '../widgets/chat_tile.dart';
import '../widgets/new_chat_sheet.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ConversationsBloc>()..add(const LoadChatRooms()),
      child: const _ChatsView(),
    );
  }
}

class _ChatsView extends StatefulWidget {
  const _ChatsView();

  @override
  State<_ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<_ChatsView> {
  final TextEditingController _searchController = TextEditingController();
  String _filterQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConversationsBloc, ConversationsState>(
      listener: (context, state) {
        if (state.createdChatRoom != null) {
          final room = state.createdChatRoom!;
          context.push('/home/chat/${room.id}', extra: room.displayName);
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
      },
      builder: (context, state) {
        final filteredRooms = state.chatRooms.where((room) {
          if (_filterQuery.isEmpty) return true;
          final title = room.displayName.toLowerCase();
          final lastMsg = (room.lastMessageBody ?? '').toLowerCase();
          return title.contains(_filterQuery) || lastMsg.contains(_filterQuery);
        }).toList();

        return Scaffold(
          backgroundColor: ColoursDark.background,
          appBar: AppBar(
            backgroundColor: ColoursDark.background,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColoursDark.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shield_rounded,
                    color: ColoursDark.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Text(
                  'Fortress',
                  style: TextStyle(
                    color: ColoursDark.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: SearchBar(
                  controller: _searchController,
                  leading: const Icon(Icons.search, color: ColoursDark.onSurfaceMuted),
                  hintText: 'Search chats...',
                  hintStyle: const WidgetStatePropertyAll(
                    TextStyle(color: ColoursDark.onSurfaceMuted),
                  ),
                  textStyle: const WidgetStatePropertyAll(
                    TextStyle(color: ColoursDark.onBackground),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(ColoursDark.surface),
                  elevation: const WidgetStatePropertyAll(0),
                  onChanged: (val) {
                    setState(() {
                      _filterQuery = val.trim().toLowerCase();
                    });
                  },
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => NewChatSheet.show(context),
            backgroundColor: ColoursDark.primary,
            foregroundColor: ColoursDark.onPrimary,
            icon: const Icon(Icons.chat_bubble_outline_rounded),
            label: const Text('New Chat', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: RefreshIndicator(
            color: ColoursDark.primary,
            onRefresh: () async {
              context.read<ConversationsBloc>().add(const RefreshChatRooms());
            },
            child: filteredRooms.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              color: ColoursDark.surfaceVariant.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.chat_outlined,
                              size: 48,
                              color: ColoursDark.onSurfaceMuted,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            _filterQuery.isNotEmpty
                                ? 'No chats matching "$_filterQuery"'
                                : 'No conversations yet',
                            style: const TextStyle(
                              color: ColoursDark.onBackground,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            _filterQuery.isNotEmpty
                                ? 'Try searching for something else.'
                                : 'Start a conversation by tapping "New Chat" below.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: ColoursDark.onSurfaceMuted,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.sm,
                      bottom: 80,
                    ),
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      final room = filteredRooms[index];
                      return ChatTile(
                        room: room,
                        onTap: () {
                          context.push(
                            '/home/chat/${room.id}',
                            extra: room.displayName,
                          );
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
