import 'package:contact_management_app/models/contacts_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Save the contact to the database
  void _saveContact() async {
    if (_formKey.currentState!.validate()) {
      /*
      Provider is being used to save contacts to the ContactsDatabase so the _saveContact is
      triggered upon saving then adds the information by calling addContact() from the ContactsDatabase
      */
      final db = Provider.of<ContactsDatabase>(context, listen: false);
      await db.addContact(
        _firstNameController.text,
        _lastNameController.text,
        _phoneNumberController.text,
      );

      Navigator.pop(context); // Go back to the contact list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //this is just designing and styling the add contact frontend page
      appBar: AppBar(
      title: const Text(
          'Add Contact',
          style: TextStyle(color: Colors.white),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.5,
        backgroundColor: Colors.brown[400],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter first name' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value!.isEmpty ? 'Enter last name' : null,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter phone number';
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Invalid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveContact,
                child: const Text('Save Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}