import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';


class AddDescription extends StatelessWidget {
  const AddDescription({super.key, required this.controller});

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.screenSize.width / 3,
        width: context.screenSize.width,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
            color: AppColorsDark.white,
            borderRadius: BorderRadius.circular(25)),
        child: TextFormField(
            autofocus: false,
            controller: controller,
            cursorColor: context.textTheme.bodyLarge?.color,
            keyboardType: TextInputType.text,
            style: context.textTheme.bodyLarge
                ?.copyWith(color: AppColorsDark.darkStyleText),
            validator: (String? value) {
              if (value == null || value == '') {
                return '';
              }
              return null;
            },
            maxLines: 3,
            decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              errorMaxLines: 2,
              icon: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Image.asset('assets/message.png',
                        color: context.theme.iconTheme.color),
                  ),
                ],
              ),
              hintText: 'Write your experience in here',
              hintStyle: context.textTheme.bodyLarge
                  ?.copyWith(color: AppColorsDark.primary.withOpacity(0.5)),
            ),
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.done,
            inputFormatters: const [
              //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
            ]));
  }
}
