import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_elevation.dart';
import 'package:Fortress/core/theme/app_radii.dart';

class AuthTextFormField extends StatefulWidget {
  final IconData _prefixIcon;
  final Widget? _suffixIcon;
  final IconData _focusedPrefixIcon;
  final Widget? _focusedSuffixIcon;
  final Widget? _tappedSuffixIcon;
  final String _hintText;
  final TextEditingController _controller;
  final String? Function(String?)? _validator;
  final bool _isObscure;
  final String _lable;
  final String? _helperText;
  final String? _errorText;
  final AutovalidateMode? _autovalidateMode;
  final TextInputType? _keyboardType;

  const AuthTextFormField({
    super.key,
    required this._focusedPrefixIcon,
    this._focusedSuffixIcon,
    required this._hintText,
    required this._prefixIcon,
    this._suffixIcon,
    required this._controller,
    this._validator,
    this._tappedSuffixIcon,
    this._isObscure = false,
    required this._lable,
    this._helperText,
    this._errorText,
    this._autovalidateMode,
    this._keyboardType,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  late FocusNode _focusNode;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _isVisible = widget._isObscure;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool inFocus = _focusNode.hasFocus;

    return Container(
      decoration: BoxDecoration(
        boxShadow: inFocus
            ? (MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? AppElevation.shadowGlowDark
                  : AppElevation.shadowGlowLight)
            : null,
        shape: BoxShape.rectangle,
        borderRadius: AppRadii.medium,
      ),
      child: TextFormField(
        onTapOutside: (event) {
          _focusNode.unfocus();
        },
        onEditingComplete: () {
          _focusNode.nextFocus();
        },
        validator: widget._validator,
        controller: widget._controller,
        focusNode: _focusNode,
        showCursor: inFocus,
        obscureText: (widget._isObscure && (_isVisible || !inFocus)),
        autovalidateMode: widget._autovalidateMode,
        keyboardType: widget._keyboardType,
        decoration: InputDecoration(
          errorText: widget._errorText,
          prefixIconColor: inFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onInverseSurface,
          suffixIconColor: inFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onInverseSurface,
          helperText: inFocus ? widget._helperText : null,
          helperStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          labelText: widget._lable,
          hintText: widget._hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          prefixIcon: inFocus
              ? Icon(widget._focusedPrefixIcon)
              : Icon(widget._prefixIcon),
          suffixIcon: widget._suffixIcon != null
              ? (inFocus
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        child: inFocus
                            ? (_isVisible
                                  ? widget._focusedSuffixIcon
                                  : widget._tappedSuffixIcon)
                            : widget._suffixIcon,
                      )
                    : widget._suffixIcon)
              : null,
          border: OutlineInputBorder(
            borderRadius: AppRadii.medium,
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: AppRadii.medium,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
            borderRadius: AppRadii.medium,
          ),
        ),
      ),
    );
  }
}
