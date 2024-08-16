import 'dart:typed_data';

import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final contactsProvider = StateNotifierProvider<ContactsNotifier, List<ContactModel>>((ref) {
  return ContactsNotifier();
});

class ContactsNotifier extends StateNotifier<List<ContactModel>> {
  ContactsNotifier() : super([]);

  void addContact(ContactModel contact) {
    state = [...state, contact];
  }

  void updateContact(int index, ContactModel contact) {
    final updatedList = [...state];
    updatedList[index] = contact;
    state = updatedList;
  }

  void deleteContact(int index) {
    final delete = state;
    delete.removeAt(index);
    state = List.from(delete);
  }
}



Future<Uint8List?> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  return image != null ? await image.readAsBytes() : null;
}

