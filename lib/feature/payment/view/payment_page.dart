import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../utils/payment_utils.dart';
import '../widget/custom_masked_text_controller.dart';
import '../widget/cvv_container.dart';
import '../widget/expire_container.dart';
import '../widget/pan_container.dart';
import '../widget/payment_method_container.dart';


@RoutePage(name: "PaymentPageRoute")
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final CustomMaskedTextController _panController =
      CustomMaskedTextController(mask: '[0000] [0000] [0000] [0000]');
  final CustomMaskedTextController _expireController =
      CustomMaskedTextController(mask: '[00] / [00]');
  final TextEditingController _controllerCvv = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? panFocus;
  FocusNode? expireFocus;
  FocusNode? cvvFocus;

  @override
  void initState() {
    panFocus = FocusNode();
    expireFocus = FocusNode();
    cvvFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _panController.dispose();
    _expireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          leading: ItemAppBar(
            icon: 'assets/back.png',
            colorIcon: Colors.white,
            onPressed: () {
              context.router.popForced();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment method',
                    style: context.textTheme.titleLarge,
                  ),
                  16.height,
                  PanContainer(
                    panFocus: panFocus,
                    controller: _panController,
                    hintText: 'Номер карты',
                    suffixIcon: Image.asset('assets/card.png',
                      color: AppColorsDark.darkStyleText,
                    ),
                    formKey: _formKey,
                  ),
                  16.height,
                  Row(
                    children: [
                      ExpireContainer(
                        controller: _expireController,
                        formKey: _formKey,
                        hintText: 'MM/ГГ',
                        expireFocus: expireFocus,
                        suffixIcon: Image.asset('assets/calendar.png'),
                      ),
                      const Spacer(),
                      ValueListenableBuilder(
                        valueListenable: PaymentUtils.paymentMethod,
                        builder: (context, value, child) {
                          switch (value) {
                            case 'uzcard' || 'humo':
                              return const SizedBox.shrink();
                            case 'visa' || 'mir' || 'mastercard':
                              return CvvContainer(
                                controller: _controllerCvv,
                                formKey: _formKey,
                                hintText: 'CVV',
                                cvvFocus: cvvFocus,
                                suffixIcon: Image.asset('assets/card.png',color: AppColorsDark.darkStyleText,),
                              );

                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      )
                    ],
                  ),
                  16.height,
                  const PaymentMethodWidget(),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                  width: context.screenSize.width / 1.2,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {}
                  },
                  text: 'Next'),
            )
          ],
        ),
      ),
    );
  }
}
