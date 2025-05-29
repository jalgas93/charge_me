import 'package:flutter/material.dart';

import 'item_form_info.dart';

class ShowDialogForm {

  Future<void> showForm({
    required BuildContext context,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Container();
      },
    );
  }

  Future<void> showInfo({
    required BuildContext context,
    required String text,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return ItemFormInfo(text: text);
      },
    );
  }
}
