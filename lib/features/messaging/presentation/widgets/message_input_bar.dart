import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';

class MessageInputBar extends StatefulWidget {
  final ValueChanged<String> onSend;
  final ValueChanged<bool> onTyping;

  const MessageInputBar({
    super.key,
    required this.onSend,
    required this.onTyping,
  });

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _typingDebounce;
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    _typingDebounce?.cancel();
    super.dispose();
  }

  void _onTextChanged(String text) {
    final hasText = text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }

    if (hasText) {
      widget.onTyping(true);
      _typingDebounce?.cancel();
      _typingDebounce = Timer(const Duration(seconds: 2), () {
        widget.onTyping(false);
      });
    } else {
      widget.onTyping(false);
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
      widget.onTyping(false);
      _typingDebounce?.cancel();
      setState(() => _hasText = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: ColoursDark.surface,
        border: Border(
          top: BorderSide(color: ColoursDark.divider.withOpacity(0.5)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColoursDark.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: _onTextChanged,
                  onSubmitted: (_) => _handleSend(),
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(
                    color: ColoursDark.onBackground,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: ColoursDark.onSurfaceMuted,
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                onPressed: _hasText ? _handleSend : null,
                icon: const Icon(Icons.send_rounded),
                color: ColoursDark.primary,
                disabledColor: ColoursDark.onSurfaceMuted.withOpacity(0.4),
                style: IconButton.styleFrom(
                  backgroundColor: _hasText
                      ? ColoursDark.primary.withOpacity(0.15)
                      : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
