import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "SupportServicePage")
class SupportServicePage extends StatefulWidget {
  const SupportServicePage({super.key});

  @override
  State<SupportServicePage> createState() => _SupportServicePageState();
}

class _SupportServicePageState extends State<SupportServicePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
