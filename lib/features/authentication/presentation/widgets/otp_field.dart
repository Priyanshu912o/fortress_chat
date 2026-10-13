import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_elevation.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/features/authentication/presentation/widgets/otp_formatter.dart';

class OtpField extends StatefulWidget {
  final TextEditingController _pinController;
  const OtpField({super.key, required this._pinController});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      decoration: BoxDecoration(
        boxShadow: _focusNode.hasFocus
            ? (MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? AppElevation.shadowGlowDark
                  : AppElevation.shadowGlowLight)
            : null,
        shape: BoxShape.rectangle,
        borderRadius: AppRadii.small,
      ),
      child: TextField(
        controller: widget._pinController,
        inputFormatters: [OtpFormatter(1)],
        onChanged: (value) {
          value.isEmpty ? _focusNode.previousFocus() : _focusNode.nextFocus();
        },
        maxLength: 1,
        keyboardType: TextInputType.number,
        focusNode: _focusNode,
        showCursor: false,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: AppRadii.small,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
            borderRadius: AppRadii.small,
          ),
        ),
      ),
    );
  }
}
