import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../utils/payment_utils.dart';
import 'item_filter.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenSize.width / 8,
      width: context.screenSize.width/2,
      child: ValueListenableBuilder(
        valueListenable: PaymentUtils.paymentMethod,
        builder: (context, value, child) {
          return value !='' ? ItemFilter(
            image: 'assets/vendors/$value.png',
            title: value,
            isSelected: false,
          ):const SizedBox.shrink();
        },
      ),
    );
  }
}
