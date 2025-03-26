import 'package:flutter/material.dart';

class Helper extends StatelessWidget {
  const Helper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
