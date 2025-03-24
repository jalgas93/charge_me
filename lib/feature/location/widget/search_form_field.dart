import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8,bottom: 16),
      child: SizedBox(
        height: context.screenSize.width / 6.5,
        child: Align(
            alignment: Alignment.center,
            child: TextFormField(
                // autofocus: false,
                controller: controller,
                keyboardType: TextInputType.text,
                style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
                //  onChanged: (value) => runFilter(value),
                validator: (String? value) {
                  if (value == null || value == '') {
                    return '';
                  }
                  return null;
                },
                cursorColor: context.theme.focusColor,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  errorMaxLines: 2,
                  counterText: '',
                  prefixIcon:
                      Icon(Icons.search,color: context.theme.focusColor),
                  suffixIcon: SizedBox(
                    width: context.screenSize.width / 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: context.screenSize.width / 12,
                            child: VerticalDivider(
                              color: Colors.grey.shade400,
                            )),
                        IconButton(
                          icon: Image.asset('assets/filter.png',color: context.theme.focusColor),
                          onPressed: () {
                            // controller.clear();
                            //runFilter(controller.text);
                          },
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Искать станцию',
                  hintStyle: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.greyBorder.withOpacity(0.7)),
                  /*         border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),*/
                ),
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.search,
                inputFormatters: const [
                  //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                ])),
      ),
    );
  }
}
