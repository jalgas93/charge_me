import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';

class SearchInfo extends StatelessWidget {
  const SearchInfo({super.key, required this.controller, this.onChanged, this.onEditingComplete});


  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            color: AppColorsDark.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 5))
            ]),
        child: TextFormField(
          autofocus: false,
          controller: controller,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          style: context.textTheme.titleSmall
              ?.copyWith(color: AppColorsDark.darkStyleText),
          validator: (String? value) {
            if (value == null || value == '') {
              return '';
            }
            return null;
          },
          cursorColor: context.theme.focusColor,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorsDark.transparent),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColorsDark.transparent),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            errorMaxLines: 2,
            counterText: '',
            prefixIcon:
                const Icon(Icons.search, color: AppColorsDark.darkStyleText),
            hintText: 'Искать станцию',
            hintStyle: context.textTheme.bodyLarge,
          ),
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.search,
        ));
  }
}
