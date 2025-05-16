import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "AboutAppRoutePage")
class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
