import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/styles/app_colors_dark.dart';

class TextFormContainer extends StatelessWidget {
  const TextFormContainer({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.keyboardType,
    required this.controller,
    this.prefixColor,
    this.isObs = false,
    this.isShow = false,
    this.actionsButton,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
    this.focusNode,
  });

  final String prefixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final Color? prefixColor;
  final bool isObs;
  final bool isShow;
  final Function()? actionsButton;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

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
            obscureText: isObs,
            controller: controller,
            focusNode: focusNode,
            cursorColor: context.textTheme.bodyLarge?.color,
            keyboardType: keyboardType,
            style: context.textTheme.titleSmall,
            validator: validator ??
                (String? value) {
                  if (value == null || value == '') {
                    return 'Обязательное поле';
                  }
                  return null;
                },
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
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
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColorsDark.red1),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColorsDark.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              errorMaxLines: 2,
              prefixIcon: Image.asset(prefixIcon,
                  color: prefixColor ?? context.theme.iconTheme.color),
              suffixIcon: isShow
                  ? SizedBox(
                      width: context.screenSize.width / 10,
                      child: TextButton(
                          onPressed: actionsButton,
                          child: isObs
                              ? const Icon(
                                  Icons.visibility,
                                  color: AppColorsDark.green1,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: AppColorsDark.red1,
                                )))
                  : const SizedBox.shrink(),
              hintText: hintText,
              hintStyle: context.textTheme.bodyLarge,
            ),
            textCapitalization: TextCapitalization.none,
            textInputAction: textInputAction,
            inputFormatters: const [
              //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
            ]),
      ),
    );
  }
}
