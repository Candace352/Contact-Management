import 'package:flutter/material.dart';
import 'package:contact_management_app/models/contact.dart';
import 'package:contact_management_app/pages/edit_contact.dart';
import 'package:contact_management_app/pages/add_contact.dart';
import 'package:contact_management_app/services/api.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  late Future<List<Contact>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  void _fetchContacts() {
    setState(() {
      _contactsFuture = ApiService.getAllContacts();
    });
  }

  Future<void> _refreshContacts() async {
    _fetchContacts();
  }

  Future<void> _deleteContact(int pid) async {
    try {
      bool success = await ApiService.deleteContact(pid);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete contact')),
        );
        _fetchContacts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully deleted contact')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _navigateToAddContact() async {
    bool? result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const AddContact()),
    );

    if (result == true) {
      _fetchContacts();
    }
  }

  Future<void> _navigateToEditContact(Contact contact) async {
    bool? result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => EditContact(contact: contact)),
    );

    if (result == true) {
      _fetchContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.brown.shade400,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshContacts,
        child: FutureBuilder<List<Contact>>(
          future: _contactsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No contacts available',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            final contacts = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                        child: const Icon(Icons.person, color: Colors.black54),
                      ),
                      title: Text(
                        contact.pname,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        contact.pphone,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _navigateToEditContact(contact),
                            tooltip: 'Edit Contact',
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
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.black54)),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text('Delete',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  ) ??
                                  false;

                              if (confirmDelete == true &&
                                  contact.pid != null) {
                                await _deleteContact(contact.pid!);
                                _refreshContacts();
                              }
                            },
                            tooltip: 'Delete Contact',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _navigateToAddContact,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: const Icon(Icons.add, color: Colors.white),
      //   tooltip: 'Add Contact',
      // ),
    );
  }
}
