import 'package:flutter/material.dart';
import 'package:contact_management_app/services/api.dart';
import 'package:contact_management_app/models/contact.dart';

class EditContact extends StatefulWidget {
  final Contact contact;

  const EditContact({super.key, required this.contact});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();

    print("Edit Contact: ${widget.contact.pid}");
    _nameController.text = widget.contact.pname;
    _phoneController.text = widget.contact.pphone;
  }

//updating the contacts function
  Future<void> _updateContact() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        print("Updating contact with PID: ${widget.contact.pid}");
        print("Name: ${_nameController.text}");
        print("Phone: ${_phoneController.text}");

        String result = await ApiService.updateContact(
          widget.contact.pid!,
          _nameController.text,
          _phoneController.text,
        );

        print("Update result: $result");

        if (result == "success") {
          print("Contact updated successfully. Refreshing contacts...");
          setState(() {});
        } else {
          print("Failed to update contact: $result");
        }
      } catch (e) {
        print("Error updating contact: $e");
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

//main application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Contact',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade400,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Contact Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              // Input field for full name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a full name' : null,
              ),
              const SizedBox(height: 16),
              // Input field for phone number
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: const Icon(Icons.phone, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a phone number';
                  }
                  // Regex to validate phone numbers (at least 10 digits, allowing spaces, dashes, or parentheses)
                  final RegExp phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Enter a valid phone number (at least 10 digits)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Updating the contact button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _updateContact, // Calling update function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white, // Showing the loading spinner
                        )
                      : const Text(
                          'Update Contact',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
