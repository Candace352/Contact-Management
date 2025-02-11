import 'package:contact_management_app/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ContactsDatabase extends ChangeNotifier {
  late Isar isar; // Removed 'static' keyword

  // List of all the contacts in the database

  List<Contact> currentContacts = [];

  // Initializing the Isar database
  /*
  Using the Isar database based on a tutorial I followed by Mitch Koko, 
  it is simple and given that we haven't done much with APIs i thought it would be better to use and see if i am actually
   saving the contacts and the likes 
  */

  Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [ContactSchema],
        directory: dir.path,
      );
      await fetchContacts(); // Fetchiing the contacts after initialization
    } catch (e) {
      debugPrint('Error initializing Isar: $e');
    }
  }

  // Add a new contact to the database
  Future<void> addContact(String fname, String lname, String phone) async {
    try {
      if (!isar.isOpen) {
        await initialize(); // initiliazing again because i faced problems with 'Late Initialization when i want to test the app'
      }
      final contact = Contact.create(fname, lname, phone);
      await isar.writeTxn(() async {
        await isar.contacts.put(contact);
      });
      await fetchContacts(); // Refreshing and updating the contact list after adding a new contact
    } catch (e) {
      debugPrint('Error adding contact: $e');
    }
  }

  // Fetching all contacts from the database
  Future<void> fetchContacts() async {
    try {
      if (!isar.isOpen) {
        await initialize(); // Ensure isar is initialized, because of the earlier problem i encountered
      }
      List<Contact> contacts = await isar.contacts.where().findAll();
      currentContacts.clear();
      currentContacts.addAll(contacts);
      notifyListeners(); // Notify listeners to update the frontend
    } catch (e) {
      debugPrint('Error fetching contacts: $e');
    }
  }

  // Update a contact in the database
  Future<void> updateContact(
      int id, String firstName, String lastName, String contactNumber) async {
    try {
      if (!isar.isOpen) {
        await initialize(); // Ensure isar is initialized
      }
      final existingContact = await isar.contacts.get(id);
      if (existingContact != null) {
        existingContact.firstName = firstName;
        existingContact.lastName = lastName;
        existingContact.contactNumber = contactNumber;

        await isar.writeTxn(() async {
          await isar.contacts.put(existingContact);
        });
        await fetchContacts(); // Refreshing the contact list
      }
    } catch (e) {
      debugPrint('Error updating contact: $e');
    }
  }

  // Delete a contact from the database
  Future<void> deleteContact(int id) async {
    try {
      if (!isar.isOpen) {
        await initialize(); // Ensure isar is initialized
      }
      await isar.writeTxn(() async {
        await isar.contacts.delete(id);
      });
      await fetchContacts(); // Refresh the contact list
    } catch (e) {
      debugPrint('Error deleting contact: $e');
    }
  }
}
