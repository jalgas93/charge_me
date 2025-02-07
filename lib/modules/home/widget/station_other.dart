import 'package:charge_me/modules/app_common/extensions/context_extensions.dart';
import 'package:charge_me/modules/dashboard/utils/utils_dashboard.dart';
import 'package:flutter/material.dart';

import '../../app_common/widget/custom_button.dart';

class StationOther extends StatelessWidget {
  const StationOther({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Станция 1',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Улица Мирзо Улугбекаб Ташкент',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: const Color(0xff8E8E93)),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/speedometr.png'),
                        const SizedBox(width: 5),
                        Text('18.50 KBt',
                            style: Theme.of(context).textTheme.labelLarge)
                      ],
                    ),
                    Text('Скорость',
                        style: Theme.of(context).textTheme.labelSmall)
                  ],
                ),
                Container(
                    width: 1,
                    height: 32,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    color: const Color(0xffC9CBD9),
                    child: const VerticalDivider()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/battery_charging.png',
                          color: const Color(0xffF2C626),
                        ),
                        const SizedBox(width: 5),
                        Text('3107.00 КВт',
                            style: Theme.of(context).textTheme.labelLarge)
                      ],
                    ),
                    Text('Потраченные',
                        style: Theme.of(context).textTheme.labelSmall)
                  ],
                ),
                Container(
                    width: 1,
                    height: 32,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    color: const Color(0xffC9CBD9),
                    child: const VerticalDivider()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/bank_note.png',
                          color: const Color(0xff2AC24C),
                        ),
                        const SizedBox(width: 5),
                        Text('6 524 700 сум',
                            style: Theme.of(context).textTheme.labelLarge)
                      ],
                    ),
                    Text('Стоимость',
                        style: Theme.of(context).textTheme.labelSmall)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Text('10 мин время зарядки',
                style: Theme.of(context).textTheme.labelLarge),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: context.screenSize.width / 2,
                    width: context.screenSize.width / 3,
                    decoration: const BoxDecoration(
                      color: Color(0xffF1F1F1),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xffB7FCEB),
                            Color(0xffB0C7EE),
                            Color(0xff9A22F9),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                        child: Text('53%',
                            style: Theme.of(context).textTheme.headlineLarge)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
              color: const Color(0xffF44236),
              onTap: () {
                UtilsDashboard.setChange = false;
              },
              radius: 12,
              text: 'Прекратить зарядку'),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: context.screenSize.width / 3,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
/*    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 1,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0);*/
    path.moveTo(0, 40);
    path.quadraticBezierTo(size.width / 4, 10, size.width / 2.5, 40);
    path.quadraticBezierTo(
        size.width / 1.7, size.height / 2.8, size.width, size.height / 2 - 80);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
/*    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 1,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0);*/
    path.moveTo(0, 40);
    path.quadraticBezierTo(size.width / 4, 10, size.width / 2.5, 40);
    path.quadraticBezierTo(
        size.width / 1.7, size.height / 2.8, size.width, size.height / 2 - 80);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
