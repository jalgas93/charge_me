import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../utils/payment_utils.dart';


class PanContainer extends StatelessWidget {
  const PanContainer({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.hintText,
    this.panFocus,
    required this.formKey,
  });

  final FocusNode? panFocus;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final Widget? suffixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.width / 5,
      width: context.screenSize.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
      decoration: BoxDecoration(
          color: AppColorsDark.secondaryColorW,
          borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
          focusNode: panFocus,
          autofocus: false,
          controller: controller,
          cursorColor: AppColorsDark.darkStyleText,
          autovalidateMode: AutovalidateMode.disabled,
          keyboardType: TextInputType.number,
          style:
              context.textTheme.bodyLarge?.copyWith(color: AppColorsDark.darkStyleText),
          validator: (String? value) {
            if (value == null || value == '') {
              return 'Поле обязательное';
            }
            if (value.isEmpty || value.length < 13 || value.length > 19) {
              return 'Не меньше 16 не цифры';
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: AppColorsDark.secondaryColorW,
            //  labelText: 'Номер карты',
            //labelStyle: context.textTheme.bodyLarge,
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
            errorMaxLines: 2,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: context.textTheme.bodyLarge,
          ),
    /*      onEditingComplete: (){
            formKey.currentState?.validate();
          },*/
          onChanged: (text) {
            if (text.isNotEmpty) {
              var beginStartNumber = text.split(' ')[0];
              switch (beginStartNumber) {
                case '8600' || '5614' || '6262' || '5440':
                  PaymentUtils.setPaymentMethod = 'uzcard';
                  break;
                case '9860':
                  PaymentUtils.setPaymentMethod = 'humo';
                  break;
                case '4':
                  PaymentUtils.setPaymentMethod = 'visa';
                  break;
                case '2200'||'2201'||'2202'||'2203'||'2204':
                  PaymentUtils.setPaymentMethod = 'mir';
                  break;
                case '51' ||
                      '55' ||
                      '2221' ||
                      '2229' ||
                      '223' ||
                      '229' ||
                      '23' ||
                      '26' ||
                      '270' ||
                      '271' ||
                      '2720':
                  PaymentUtils.setPaymentMethod = 'mastercard';
                  break;
                default:
                  //PaymentUtils.setPaymentMethod = '';
              }
            }else{
              PaymentUtils.setPaymentMethod = '';
            }
          },
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          inputFormatters: const [
            //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
          ]),
    );
  }
}
