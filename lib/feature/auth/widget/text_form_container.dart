import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';

class TextFormContainer extends StatelessWidget {
  const TextFormContainer(
      {super.key,
      required this.prefixIcon,
      required this.hintText,
      this.keyboardType,
      required this.controller,
      this.prefixColor});

  final String prefixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final Color? prefixColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColorsDark.white4,
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            autofocus: false,
            controller: controller,
            cursorColor: context.textTheme.bodyLarge?.color,
            keyboardType: keyboardType,
            style: context.textTheme.titleSmall,
            validator: (String? value) {
              if (value == null || value == '') {
                return '';
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColorsDark.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColorsDark.green1),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              errorMaxLines: 2,
              prefixIcon: Image.asset(prefixIcon,
                  color: prefixColor ?? context.theme.iconTheme.color),
              hintText: hintText,
              hintStyle: context.textTheme.bodyLarge,
            ),
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.next,
            inputFormatters: const [
              //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
            ]),
      ),
    );
  }
}
