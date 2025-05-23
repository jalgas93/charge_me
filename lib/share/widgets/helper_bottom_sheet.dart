import 'dart:typed_data';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/styles/app_colors_dark.dart';
import 'bottom_sheet_widget_1.dart';
import 'get_image_owner.dart';

class HelperBottomSheet {
  static Future<Uint8List?> getImage({
    required BuildContext context,
  }) async {
    Uint8List? result;
    await draggableScrollableSheet(
      context: context,
      children: [
        SizedBox(
          height: context.screenSize.height / 6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomSheetWidgetOne(
                        onTap: () async {
                          result = await GetImageOwner().getUint8List(
                              imageSource: ImageSource.camera,
                              context: context);
                          if (!context.mounted) return;
                          context.router.popForced();
                        },
                        icon: Icons.camera_alt,
                        text: 'Camera'),
                    BottomSheetWidgetOne(
                        onTap: () async {
                          result = await GetImageOwner().getUint8List(
                              imageSource: ImageSource.gallery,
                              context: context);
                          if (!context.mounted) return;
                          context.router.popForced();
                        },
                        icon: Icons.image,
                        text: "Gallery"),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
    return result;
  }

  static Future<void> draggableScrollableSheet({
    required BuildContext context,
    required List<Widget> children,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      barrierColor: AppColorsDark.primary.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            // You can wrap this Column with Padding of 8.0 for better design
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Container(
                    height: 5,
                    width: context.screenSize.width / 6,
                    decoration: BoxDecoration(
                        color: AppColorsDark.secondary,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      children: children),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
