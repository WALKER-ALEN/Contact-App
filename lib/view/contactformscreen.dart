import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/contact_controller.dart';
import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_application_1/view/widgets/googlemap_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactFormScreen extends ConsumerStatefulWidget {
  final ContactModel? contact;
  final int? index;

  const ContactFormScreen({this.contact, this.index});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends ConsumerState<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _phoneNumber, _email;
  Uint8List? _image;
  double? _latitude, _longitude;

  @override
  void initState() {
    if (widget.contact != null) {
      _name = widget.contact!.name;
      _phoneNumber = widget.contact!.phoneNumber;
      _email = widget.contact!.email;
      _image = widget.contact!.image;
      _latitude = widget.contact!.latitude;
      _longitude = widget.contact!.longitude;
    } else {
      _name = '';
      _phoneNumber = '';
      _email = '';
    }
    super.initState();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final contact = ContactModel(
        name: _name,
        phoneNumber: _phoneNumber,
        email: _email,
        image: _image,
        latitude: _latitude,
        longitude: _longitude,
      );

      if (widget.index != null) {
        ref
            .read(contactsProvider.notifier)
            .updateContact(widget.index!, contact);
      } else {
        ref.read(contactsProvider.notifier).addContact(contact);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final image = await pickImage();
                    setState(() {
                      _image = image;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          _image != null ? MemoryImage(_image!) : null,
                      child: _image == null ? Icon(Icons.camera_alt) : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Name'),
                    onSaved: (value) => _name = value!,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _phoneNumber,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onSaved: (value) => _phoneNumber = value!,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a phone number' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onSaved: (value) => _email = value!,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an email' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            onLocationPicked: (lat, long) {
                              setState(() {
                                _latitude = lat;
                                _longitude = long;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Pick Location'),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.lightGreen),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                  ),
                  onPressed: _saveContact,
                  child: Text('Save Contact'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
