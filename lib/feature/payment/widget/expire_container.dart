import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

class ExpireContainer extends StatelessWidget {
  const ExpireContainer(
      {super.key,
      this.expireFocus,
      required this.controller,
      required this.formKey,
      this.suffixIcon,
      this.hintText});

  final FocusNode? expireFocus;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final Widget? suffixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.width / 5,
      width: context.screenSize.width / 2.4,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
      decoration: BoxDecoration(
          color: AppColorsDark.secondaryColorW,
          borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
          autofocus: false,
          controller: controller,
          autovalidateMode: AutovalidateMode.disabled,
          focusNode: expireFocus,
          keyboardType: TextInputType.number,
          cursorColor: AppColorsDark.darkStyleText,
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColorsDark.darkStyleText,
          ),
          validator: (String? value) {
            if (value == null || value == '') {
              return 'Поле обязательное';
            }
            if (value.length < 7) {
              return 'Не меньше 4 не цифры';
            }
            return null;
          },
          decoration: InputDecoration(
            // labelText: 'MM/ГГ',
            // labelStyle: context.textTheme.bodyLarge,
            contentPadding: const EdgeInsets.only(
              top: 8, // HERE THE IMPORTANT PART
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorMaxLines: 1,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: context.textTheme.bodyLarge,
          ),
          onChanged: (value) {},
     /*     onEditingComplete: () {
            formKey.currentState?.validate();
          },*/
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          inputFormatters: const [
            //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
          ]),
    );
  }
}
