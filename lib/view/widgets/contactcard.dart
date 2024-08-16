import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/contact_controller.dart';
import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_application_1/services/url_services.dart';
import 'package:flutter_application_1/view/widgets/contactformscreen.dart';
import 'package:flutter_application_1/view/widgets/googlemap_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactCard extends ConsumerWidget {
  final ContactModel contact;
  final int index;

  const ContactCard({required this.contact, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromARGB(255, 71, 151, 180),
        child: ListTile(
          leading: contact.image != null
              ? CircleAvatar(backgroundImage: MemoryImage(contact.image!))
              : CircleAvatar(child: Icon(Icons.person)),
          title: Text(contact.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => launchPhone(contact.phoneNumber),
                child: Text(contact.phoneNumber),
              ),
              GestureDetector(
                onTap: () => launchEmail(contact.email),
                child: Text(contact.email),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContactFormScreen(
                        contact: contact,
                        index: index,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  ref.read(contactsProvider.notifier).deleteContact(index);
                },
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  onLocationPicked: (lat, long) {
                    Text('Contact location: $lat, $long');
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
