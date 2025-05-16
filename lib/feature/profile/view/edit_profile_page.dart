import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';

import 'package:flutter/material.dart';

import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../auth/widget/text_form_container.dart';

@RoutePage(name: 'EditProfilePageRoute')
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _editProfile = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  late Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          leading: ItemAppBar(
            icon: 'assets/back.png',
            colorIcon: Colors.white,
            onPressed: () {
              context.router.popForced();
            },
          ),
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: context.textTheme.titleSmall,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () async {
/*                  var result =
                      await HelperBottomSheet.getImage(context: context);
                  if (result != null) {
                    //image = result;
                  }*/
                },
                child: CircleAvatar(
                  radius: true ? 60 : 40,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                      true ? const AssetImage('assets/images/IMG_2.jpg') : null,
                  child: true ? null : Image.asset('assets/profile.png'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Form(
                  key: _editProfile,
                  child: Column(
                    children: [
                      TextFormContainer(
                        controller: _controllerName,
                        prefixIcon: 'assets/profile.png',
                        hintText: 'Full name',
                      ),
                      TextFormContainer(
                        controller: _controllerEmail,
                        prefixIcon: 'assets/email.png',
                        hintText: 'Email',
                      ),
                      TextFormContainer(
                        controller: _controllerPhone,
                        prefixIcon: 'assets/call.png',
                        hintText: 'Phone',
                      ),
                      TextFormContainer(
                        controller: _controllerPassword,
                        prefixIcon: 'assets/lock.png',
                        hintText: 'Password',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: CustomButton(onTap: () {}, text: 'Change'),
            ),
          ],
        ),
      ),
    );
  }
}
