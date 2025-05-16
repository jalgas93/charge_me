import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "WalletRoutePage")
class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
