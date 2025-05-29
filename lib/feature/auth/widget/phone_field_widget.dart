import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../core/styles/app_colors_dark.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
    this.autovalidateMode,
  });

  final TextEditingController controller;
  final Function(PhoneNumber)? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final AutovalidateMode? autovalidateMode;

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
        child: IntlPhoneField(
          autovalidateMode: autovalidateMode,
          autofocus: false,
          controller: controller,
          focusNode: focusNode,
          cursorColor: context.textTheme.bodyLarge?.color,
          keyboardType: TextInputType.phone,
          style: context.textTheme.titleSmall,
          validator: (value) {
            if (value == null || value == '') {
              return 'Обязательное поле';
            }
            return null;
          },
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textAlignVertical: TextAlignVertical.center,
          languageCode: "KZ",
          initialCountryCode: 'KZ',
          onCountryChanged: (country) {
            print('Country changed to: ' + country.name);
          },
          dropdownTextStyle: context.textTheme.titleSmall,
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
            hintText: "phone",
            hintStyle: context.textTheme.bodyLarge,
            enabled: true,
            suffixIcon: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () => controller.clear(),
            ),
          ),
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          ],
        ),
      ),
    );
  }
}
