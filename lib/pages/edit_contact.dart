import 'package:contact_management_app/models/contact.dart';
import 'package:contact_management_app/models/contacts_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditContact extends StatefulWidget {
  final Contact contact;

  const EditContact({super.key, required this.contact});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.contact.firstName);
    _lastNameController = TextEditingController(text: widget.contact.lastName);
    _phoneNumberController =
        TextEditingController(text: widget.contact.contactNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Contacts',
          style: TextStyle(color: Colors.white),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.5,
        backgroundColor: Colors.brown[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final db =
                    Provider.of<ContactsDatabase>(context, listen: false);
                await db.updateContact(
                  widget.contact.id,
                  _firstNameController.text,
                  _lastNameController.text,
                  _phoneNumberController.text,
                );
                Navigator.pop(context); // Go back to the contact list
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
