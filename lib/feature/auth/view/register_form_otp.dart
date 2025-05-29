import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/count_down.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../../share/widgets/sms_auto_field.dart';
import '../widget/title_text.dart';

@RoutePage(name: "RegisterFormOtpRoutePage")
class RegisterFormOtp extends StatefulWidget {
  const RegisterFormOtp({super.key});

  @override
  State<RegisterFormOtp> createState() => _RegisterFormOtpState();
}

class _RegisterFormOtpState extends State<RegisterFormOtp>
    with SingleTickerProviderStateMixin {
  final TextEditingController _optController = TextEditingController();
  AnimationController? _animationController;
  int levelClock = 1 * 60;
  String _code = "";

  @override
  void initState() {
    _listenSmsCode();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _optController.dispose();
    _animationController!.dispose();
    super.dispose();
  }

  void askCodeAgain() {
    _animationController!.reset();
    _animationController!.forward();
    _optController.clear();
    SmsAutoFill().unregisterListener();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
    //?  use this code to get sms signature for your app
    final String signature = await SmsAutoFill().getAppSignature;
    print("Signature: $signature");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: ItemAppBar(
            icon: 'assets/back.png',
            colorIcon: AppColorsDark.white,
            onPressed: () {
              context.router.popForced();
            },
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const TitleText(
            title: 'Enter the',
            supplementary: 'code',
            description:
                'Enter the 4 digit code that we just sent to jonathan@email.com',
          ),
          SmsAutoForm(
            onCodeChanged: (code) {
              _code = code!;
            },
            onCodeSubmitted: (code) {
              _code = code;
              if (code.length == 4) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            optController: _optController,
            code: _code,
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: context.screenSize.width / 4,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                 // color: AppColorsDark.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/timer.png',color: AppColorsDark.white),
                    const SizedBox(width: 8),
                    Countdown(
                      animation: StepTween(
                        begin: levelClock,
                        // THIS IS A USER ENTERED NUMBER
                        end: 0,
                      ).animate(_animationController!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                // Controls visual overflow
                overflow: TextOverflow.clip,
                // Controls how the text should be aligned horizontally
                textAlign: TextAlign.end,
                // Control the text direction
                textDirection: TextDirection.rtl,
                // Whether the text should break at soft line breaks
                softWrap: true,
                // Maximum number of lines for the text to span
                textScaler: const TextScaler.linear(1),
                maxLines: 1,
                text: TextSpan(
                  text: 'Didn’t receive the OTP? ',
                  style: context.textTheme.bodySmall,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Resend OTP',
                        style: context.textTheme.titleSmall
                            ?.copyWith(fontSize: 15),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            askCodeAgain();
                          }),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
