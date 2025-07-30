import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        return Container(
          width: constraints.maxWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColorsDark.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
             autofocus: false,
              controller: controller,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              style: context.textTheme.titleSmall,
              validator: (String? value) {
                if (value == null || value == '') {
                  return '';
                }
                return null;
              },
              cursorColor: context.theme.focusColor,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColorsDark.transparent),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColorsDark.green2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                errorMaxLines: 2,
                counterText: '',
                prefixIcon: const Icon(Icons.search, color: AppColorsDark.white),
                suffixIcon: SizedBox(
                  width: context.screenSize.width / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: context.screenSize.width / 12,
                          child: const VerticalDivider()),
                      IconButton(
                        icon: Image.asset('assets/filter.png',
                            color: AppColorsDark.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                hintText: 'Искать станцию',
                hintStyle: context.textTheme.bodyLarge,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.search,
              inputFormatters: const [
                //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
              ]),
        );
      },
    );
  }
}
