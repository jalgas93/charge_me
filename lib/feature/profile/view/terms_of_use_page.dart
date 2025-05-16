import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "TermsOfUsePage")
class TermsOfUsePage extends StatefulWidget {
  const TermsOfUsePage({super.key});

  @override
  State<TermsOfUsePage> createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
