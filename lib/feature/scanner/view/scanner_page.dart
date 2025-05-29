import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "ScannerRoutePage")
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text('SCANNER'
          )),
    );
  }
}
