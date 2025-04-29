import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';


class ProfileContainer extends StatelessWidget {
  const ProfileContainer(
      {super.key,
      required this.email,
      required this.name,
      required this.avatar,
      this.onTap});

  final String email;
  final String name;
  final String avatar;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(avatar),
              ),
            ),
            Positioned(
                right: context.screenSize.width / 3.3,
                bottom: 0,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: context.screenSize.width / 11,
                    width: context.screenSize.width / 11,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColorsDark.primary,
                        image: DecorationImage(
                            image: AssetImage('assets/setting.png'))),
                  ),
                ))
          ],
        ),
        const SizedBox(height: 8),
        Text(name, style: context.textTheme.titleSmall?.copyWith(color: AppColorsDark.white)),
        Text(email, style: context.textTheme.bodyMedium),
        const SizedBox(height: 16),
      ],
    );
  }
}
