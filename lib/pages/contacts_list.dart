import 'package:contact_management_app/models/contacts_database.dart';
import 'package:contact_management_app/pages/edit_contact.dart';
import 'package:contact_management_app/pages/add_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  void initState() {
    super.initState();
    // Fetching the contacts when the widget is initialized
    Provider.of<ContactsDatabase>(context, listen: false).fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<ContactsDatabase>(context);
    final contacts = db.currentContacts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Contacts',
          style: TextStyle(color: Colors.white),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.5,
        backgroundColor: Colors.brown[400],
      ),
      body: contacts.isEmpty
          ? const Center(child: Text('No contacts available'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text('${contact.firstName} ${contact.lastName}'),
                  subtitle: Text(contact.contactNumber),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.brown),
                        onPressed: () async {
                          // Navigate to the EditContact screen
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditContact(
                                contact:
                                    contact, // Pass the contact to be edited
                              ),
                            ),
                          );

                          // Refreshing the contact list after returning from the edit screen
                          final db = Provider.of<ContactsDatabase>(context,
                              listen: false);
                          await db.fetchContacts();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          bool confirmDelete = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Contact'),
                              content: const Text(
                                  'Are you sure you want to delete this contact?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirmDelete == true) {
                            await db.deleteContact(contact.id);
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditContact(
                          contact: contact,
                        ),
                      ),
                    );
                    await db.fetchContacts(); // Refreshing the contact list
                  },
                );
              },
            ),
    );
  }
}
