import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../bloc/people_bloc.dart';
import '../bloc/people_event.dart';
import '../bloc/people_state.dart';

class SearchUserSheet extends StatefulWidget {
  const SearchUserSheet({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = BlocProvider.of<PeopleBloc>(context);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColoursDark.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.sheet),
        ),
      ),
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: const SearchUserSheet(),
      ),
    );
  }

  @override
  State<SearchUserSheet> createState() => _SearchUserSheetState();
}

class _SearchUserSheetState extends State<SearchUserSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<PeopleBloc>().add(SearchUserEvent(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: ColoursDark.onSurfaceMuted.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Connect via Email',
            style: TextStyle(
              color: ColoursDark.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Search for another Fortress user to establish a secure connection handshake.',
            style: TextStyle(
              color: ColoursDark.onSurfaceMuted,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Search input field
          TextField(
            controller: _searchController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _performSearch(),
            style: const TextStyle(color: ColoursDark.onBackground),
            decoration: InputDecoration(
              hintText: 'Enter user email...',
              hintStyle: const TextStyle(color: ColoursDark.onSurfaceMuted),
              prefixIcon: const Icon(Icons.search, color: ColoursDark.primary),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward, color: ColoursDark.primary),
                onPressed: _performSearch,
              ),
              filled: true,
              fillColor: ColoursDark.surfaceVariant,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.input),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Search results
          BlocBuilder<PeopleBloc, PeopleState>(
            builder: (context, state) {
              if (state.isSearching) {
                return const Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Center(
                    child: CircularProgressIndicator(color: ColoursDark.primary),
                  ),
                );
              }

              if (state.searchResults.isEmpty &&
                  _searchController.text.isNotEmpty &&
                  !state.isSearching) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Center(
                    child: Text(
                      'No Fortress users found with this email.',
                      style: TextStyle(color: ColoursDark.onSurfaceMuted),
                    ),
                  ),
                );
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 260),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = state.searchResults[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: ColoursDark.surfaceVariant.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(AppRadii.card),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: ColoursDark.primary.withOpacity(0.2),
                            child: Text(
                              user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                              style: const TextStyle(
                                color: ColoursDark.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    color: ColoursDark.onBackground,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  user.email,
                                  style: const TextStyle(
                                    color: ColoursDark.onSurfaceMuted,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<PeopleBloc>()
                                  .add(SendRequestEvent(user.uid));
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.person_add, size: 16),
                            label: const Text('Connect'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColoursDark.primary,
                              foregroundColor: ColoursDark.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppRadii.button),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm + 4,
                                vertical: AppSpacing.xs,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
