import 'package:charge_me/modules/app_common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(600,800),
                  painter: RPSCustomPainter(),
                ),
/*                Container(
                  height: context.screenSize.width / 2,
                  width: context.screenSize.width / 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xffB7FCEB),
                      Color(0xffB0C7EE),
                      Color(0xff9A22F9),
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                Positioned(
                  left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Center(
                        child: Text('53%',
                            style: Theme.of(context).textTheme.headlineLarge))),
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: context.screenSize.width / 2,
                    width: context.screenSize.width / 3,
                    decoration: const BoxDecoration(
                      color: Color(0xffF1F1F1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),*/
              ],
            ),
          ) ??
          Center(
            child: Container(
              height: context.screenSize.height,
              decoration: const BoxDecoration(
                  color: Color(0xffF1F1F1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Stack(
                children: [
                  Center(
                      child: Text('53%',
                          style: Theme.of(context).textTheme.headlineLarge)),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.8,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          height: context.screenSize.height / 2,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xff9A22F9),
                                  Color(0xffB0C7EE),
                                  Color(0xffB7FCEB),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
        size.width/4,
        40,
        size.width / 3,
        40);
    path.quadraticBezierTo(
        size.width / 2,
        size.height / 2,
        size.width,
        size.height/2 - 40
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;


    Path path_0 = Path();
    path_0.moveTo(size.width*-0.0016667,size.height*0.5600000);
    path_0.lineTo(size.width*0.0900000,size.height*0.5100000);
    path_0.lineTo(size.width*0.1783333,size.height*0.4987500);
    path_0.lineTo(size.width*0.2533333,size.height*0.4962500);
    path_0.lineTo(size.width*0.3316667,size.height*0.4987500);
    path_0.lineTo(size.width*0.4066667,size.height*0.5087500);
    path_0.lineTo(size.width*0.4933333,size.height*0.5350000);
    path_0.lineTo(size.width*0.5883333,size.height*0.5625000);
    path_0.lineTo(size.width*0.6766667,size.height*0.5687500);
    path_0.lineTo(size.width*0.7766667,size.height*0.5650000);
    path_0.lineTo(size.width*0.8666667,size.height*0.5600000);
    path_0.lineTo(size.width*0.9433333,size.height*0.5337500);
    path_0.lineTo(size.width*0.9916667,size.height*0.5037500);
    path_0.lineTo(size.width*1.0016667,size.height*0.9937500);
    path_0.lineTo(size.width*0.0016667,size.height*0.9987500);

    canvas.drawPath(path_0, paint_fill_0);


    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;



    canvas.drawPath(path_0, paint_stroke_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
