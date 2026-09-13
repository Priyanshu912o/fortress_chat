import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';
import 'package:Fortress/injection.dart';
import 'package:Fortress/features/conversations/presentation/widgets/chat_tile.dart';
import 'package:Fortress/features/people/presentation/widgets/connection_tile.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_empty_state.dart';
import '../widgets/search_result_message_tile.dart';
import '../widgets/search_section_header.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchBloc>(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoursDark.background,
      appBar: AppBar(
        backgroundColor: ColoursDark.background,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(
            color: ColoursDark.onBackground,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
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
              leading: const Icon(Icons.search,
                  color: ColoursDark.onSurfaceMuted),
              hintText: 'Search conversations, messages, or contacts...',
              hintStyle: const WidgetStatePropertyAll(
                TextStyle(color: ColoursDark.onSurfaceMuted),
              ),
              textStyle: const WidgetStatePropertyAll(
                TextStyle(color: ColoursDark.onBackground),
              ),
              backgroundColor:
                  const WidgetStatePropertyAll(ColoursDark.surface),
              elevation: const WidgetStatePropertyAll(0),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear,
                        color: ColoursDark.onSurfaceMuted),
                    onPressed: () {
                      _searchController.clear();
                      context
                          .read<SearchBloc>()
                          .add(const ClearSearchQueryEvent());
                    },
                  ),
              ],
              onChanged: (query) {
                context.read<SearchBloc>().add(PerformSearchEvent(query));
              },
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColoursDark.primary),
            );
          }

          if (state.query.isEmpty) {
            return const SearchEmptyState();
          }

          if (state.isEmpty) {
            return SearchEmptyState(query: state.query);
          }

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            children: [
              // 1. Conversations
              if (state.rooms.isNotEmpty) ...[
                SearchSectionHeader(
                    title: 'CONVERSATIONS (${state.rooms.length})'),
                ...state.rooms.map(
                  (room) => ChatTile(
                    room: room,
                    onTap: () => context.push(
                      '/home/chat/${room.id}',
                      extra: room.displayName,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],

              // 2. Contacts
              if (state.contacts.isNotEmpty) ...[
                SearchSectionHeader(
                    title: 'CONTACTS (${state.contacts.length})'),
                ...state.contacts.map(
                  (contact) => ConnectionTile(
                    connection: contact,
                    onTap: () => context.push(
                      '/home/chat/direct_${contact.otherUid}',
                      extra: contact.otherName,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],

              // 3. Messages
              if (state.messages.isNotEmpty) ...[
                SearchSectionHeader(
                    title: 'MESSAGES (${state.messages.length})'),
                ...state.messages.map(
                  (msg) => SearchResultMessageTile(
                    message: msg,
                    onTap: () => context.push(
                      '/home/chat/${msg.chatRoomId}',
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}