import 'package:flutter/material.dart';
import 'package:contact_management_app/services/api.dart';

// Stateful widget for adding a new contact
class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  // Controllers to manage text input fields
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key to validate input fields

  // Function to handle submitting the contact
  Future<void> _submitContact() async {
    if (_formKey.currentState!.validate()) {
      // Validate form fields
      try {
        // Call API service to add a new contact
        String result = await ApiService.addNewContact(
          _nameController.text.trim(),
          _phoneController.text.trim(),
        );

        // Check API response and show appropriate message
        if (result == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully added the contact')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add contact')),
          );
        }
      } catch (e) {
        // Handle any errors that occur during API call
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      // Show message if fields are not properly filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Contact',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade400,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Attach form key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Contact Details',
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
              // Save contact button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitContact, // Call submit function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Save Contact',
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
