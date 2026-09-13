import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../../../../injection.dart';
import '../../../people/domain/entities/connection_entity.dart';
import '../../../people/domain/repository/people_repository.dart';
import '../bloc/conversations_bloc.dart';
import '../bloc/conversations_event.dart';
import 'selectable_contact_tile.dart';

class NewChatSheet extends StatefulWidget {
  const NewChatSheet({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = BlocProvider.of<ConversationsBloc>(context);
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
        child: const NewChatSheet(),
      ),
    );
  }

  @override
  State<NewChatSheet> createState() => _NewChatSheetState();
}

class _NewChatSheetState extends State<NewChatSheet> {
  bool _isGroupMode = false;
  final TextEditingController _groupNameController = TextEditingController();
  final Set<String> _selectedContactUids = {};
  List<ConnectionEntity> _contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    try {
      final repo = getIt<PeopleRepository>();
      final list = await repo.watchAcceptedConnections().first;
      if (mounted) {
        setState(() {
          _contacts = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _createGroup() {
    final name = _groupNameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a group name'),
          backgroundColor: ColoursDark.error,
        ),
      );
      return;
    }
    if (_selectedContactUids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one contact'),
          backgroundColor: ColoursDark.error,
        ),
      );
      return;
    }

    context.read<ConversationsBloc>().add(
          CreateGroupChatEvent(
            name: name,
            participantUids: _selectedContactUids.toList(),
          ),
        );
    Navigator.pop(context);
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
          Row(
            children: [
              Text(
                _isGroupMode ? 'Create New Group' : 'New Conversation',
                style: const TextStyle(
                  color: ColoursDark.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isGroupMode = !_isGroupMode;
                    _selectedContactUids.clear();
                  });
                },
                child: Text(
                  _isGroupMode ? '1:1 Chat' : 'New Group',
                  style: const TextStyle(
                    color: ColoursDark.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (_isGroupMode) ...[
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _groupNameController,
              style: const TextStyle(color: ColoursDark.onBackground),
              decoration: InputDecoration(
                hintText: 'Group Name...',
                hintStyle: const TextStyle(color: ColoursDark.onSurfaceMuted),
                filled: true,
                fillColor: ColoursDark.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.input),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Select contacts to add (${_selectedContactUids.length} selected):',
              style: const TextStyle(
                color: ColoursDark.onSurfaceMuted,
                fontSize: 13,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          // Contacts list
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Center(
                child: CircularProgressIndicator(color: ColoursDark.primary),
              ),
            )
          else if (_contacts.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(
                child: Text(
                  'No accepted contacts found.\nConnect with people in the People tab first.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColoursDark.onSurfaceMuted),
                ),
              ),
            )
          else
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 280),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  final isSelected =
                      _selectedContactUids.contains(contact.otherUid);

                  return SelectableContactTile(
                    contact: contact,
                    isSelected: isSelected,
                    isGroupMode: _isGroupMode,
                    onTap: () {
                      if (_isGroupMode) {
                        setState(() {
                          if (isSelected) {
                            _selectedContactUids.remove(contact.otherUid);
                          } else {
                            _selectedContactUids.add(contact.otherUid);
                          }
                        });
                      } else {
                        // 1:1 chat start
                        context.read<ConversationsBloc>().add(
                              CreateDirectChatEvent(contact.otherUid),
                            );
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),
            ),
          if (_isGroupMode) ...[
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
              onPressed: _createGroup,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColoursDark.primary,
                foregroundColor: ColoursDark.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
              ),
              child: const Text(
                'Create Group',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
