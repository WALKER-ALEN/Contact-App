import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/contactformscreen.dart';

void showContactForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    shape: BeveledRectangleBorder(),
    scrollControlDisabledMaxHeightRatio: .8,
    backgroundColor: Colors.blueGrey,
    // Allows the modal to take full height if needed
    builder: (BuildContext context) {
      return ContactFormScreen();
    },
  );
}
