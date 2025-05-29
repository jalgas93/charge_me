import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

class CvvContainer extends StatelessWidget {
  const CvvContainer(
      {super.key,
      required this.controller,
      required this.formKey,
      this.suffixIcon,
      this.hintText,
      this.cvvFocus});

  final FocusNode? cvvFocus;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final Widget? suffixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.width / 4.5,
      width: context.screenSize.width / 2.5,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
      decoration: BoxDecoration(
          color: AppColorsDark.secondaryColorW,
          borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
          autofocus: false,
          controller: controller,
          autovalidateMode: AutovalidateMode.disabled,
          focusNode: cvvFocus,
          keyboardType: TextInputType.number,
          cursorColor: AppColorsDark.darkStyleText,
          style: context.textTheme.bodyLarge?.copyWith(color: AppColorsDark.darkStyleText),
          validator: (String? value) {
            if (value == null || value == '') {
              return 'Поле обязательное';
            }
            if (value.length < 3) {
              return 'Не меньше 3 не цифры';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              top: 16, // HERE THE IMPORTANT PART
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
            errorMaxLines: 2,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: context.textTheme.bodyLarge,
          ),
          onChanged: (value) {
            //formKey.currentState?.validate();
          },
          onEditingComplete: (){
            formKey.currentState?.validate();
          },
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          inputFormatters: const [
            //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
          ]),
    );
  }
}
