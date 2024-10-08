import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/contact_controller.dart';
import 'package:flutter_application_1/controller/themeController.dart';
import 'package:flutter_application_1/view/contactcard.dart';
import 'package:flutter_application_1/view/contactformscreen.dart';
import 'package:flutter_application_1/view/widgets/show_bottom_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
        leading: IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).switcher();
            },
            icon: ref.watch(themeProvider)
                ? const Icon(Icons.sunny)
                : const Icon(Icons.dark_mode)),
        actions: [
          // IconButton(
          // onPressed: () {
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('Settings')),
              PopupMenuItem(child: Text('Help')),
              PopupMenuItem(child: Text('About')),
            ],
          )
          // },
          // icon: Icon(Icons.more_vert))
        ],
      ),
      body: contacts.isEmpty
          ? Center(
              child: Text('No contacts available'),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactCard(contact: contact, index: index);
              },
            ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blueAccent,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => showContactForm(context),
          //   ),
          // );
          showContactForm(context);
        },
      ),
    );
  }
}
