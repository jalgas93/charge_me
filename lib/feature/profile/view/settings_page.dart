import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "SettingRoutePage")
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
