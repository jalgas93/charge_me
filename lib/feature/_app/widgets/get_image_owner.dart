import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/l10n.dart';

class GetImageOwner {
  XFile? _pickedFile;
  XFile? _croppedFile;

/*  void _clear() {
    _pickedFile = null;
    _croppedFile = null;
  }*/
  Future<Uint8List?> getUint8List({
    required ImageSource imageSource,
    required BuildContext context,
  }) async {
    var result = await getImage(imageSource: imageSource, context: context);
    final Uint8List? bytes = await result?.readAsBytes();
    return bytes;
  }

  Future<XFile?> getImage({
    required ImageSource imageSource,
    required BuildContext context,
  }) async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus == PermissionStatus.granted) {
      final ImagePicker picker = ImagePicker();
      _pickedFile = await picker.pickImage(source: imageSource);
      if (_pickedFile != null) {
        if (!context.mounted) return null;
       // _croppedFile =
       // await _cropImage(pickedFile: _pickedFile!, context: context);
        return _pickedFile;
      }
    } else {
      openAppSettings();
    }
    return null;
  }
}

/*Future<XFile> _cropImage(
    {required XFile pickedFile, required BuildContext context}) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: pickedFile.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'corp',
          toolbarColor: Theme
              .of(context)
              .hoverColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'corp',
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPresetCustom(),
        ],
      ),
      WebUiSettings(
        context: context,
        presentStyle: WebPresentStyle.dialog,
        size: const CropperSize(
          width: 520,
          height: 520,
        ),
      ),
    ],
  );
  return croppedFile?.path == null
      ? XFile(pickedFile.path)
      : XFile(croppedFile!.path);
}*/

/*class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}*/
