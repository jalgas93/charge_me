import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../core/styles/app_colors_dark.dart';

class SmsAutoForm extends StatelessWidget {
  const SmsAutoForm(
      {super.key,
      required this.optController,
      this.onCodeSubmitted,
      this.onCodeChanged,
      required this.code});

  final TextEditingController optController;
  final Function(String)? onCodeSubmitted;
  final Function(String?)? onCodeChanged;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: PinFieldAutoFill(
        autoFocus: true,
        controller: optController,
        keyboardType: TextInputType.number,
        codeLength: 4,
        decoration: BoxLooseDecoration(
          textStyle: context.textTheme.titleSmall,
          strokeColorBuilder: const FixedColorBuilder(Colors.grey),
        ),
        currentCode: code,
        onCodeSubmitted: onCodeSubmitted,
        cursor: Cursor(
          width: 2,
          height: 25,
          color: AppColorsDark.primary,
          radius: const Radius.circular(1),
          enabled: true,
        ),
        onCodeChanged: onCodeChanged,
      ),
    );
  }
}
