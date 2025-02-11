import 'package:contact_management_app/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ContactsDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initializing the Isar database
  /*
  Using the Isar database based on a tutorial I followed by Mitch Koko, 
  it is simple and given that we haven't done much with APIs i thought it would be better to use and see if i am actually
   saving the contacts and the likes 
  */

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ContactSchema],
      directory: dir.path,
    );
    await fetchContacts(); // Fetch contacts after initialization
  }

  // List of all the contacts in the database
  List<Contact> currentContacts = [];

  // This is for adding a new contact to the database
  //It is following the constructor of the contact class from the contact.dart file
  Future<void> addContact(String fname, String lname, String phone) async {
    try {
      final contact = Contact.create(fname, lname, phone);
      await isar.writeTxn(() async {
        await isar.contacts.put(contact);
      });
      await fetchContacts(); // Refresh the contact list
    } catch (e) {
      debugPrint('Error adding contact: $e');
    }
  }

  // This is for fetching all the contacts from the database
  Future<void> fetchContacts() async {
    try {
      List<Contact> contacts = await isar.contacts.where().findAll();
      currentContacts.clear();
      currentContacts.addAll(contacts);
      notifyListeners(); // Notifying the frontend to update as soon as there is a change 
    } catch (e) {
      debugPrint('Error fetching contacts: $e');
    }
  }

  // Updating a contact in the database
  Future<void> updateContact(
      int id, String firstName, String lastName, String contactNumber) async {
    try {
      final existingContact = await isar.contacts.get(id);
      if (existingContact != null) {
        existingContact.firstName = firstName;
        existingContact.lastName = lastName;
        existingContact.contactNumber = contactNumber;

        await isar.writeTxn(() async {
          await isar.contacts.put(existingContact);
        });
        await fetchContacts(); // Using the fetchContact() method to refresh and update the contact list in the frontend
      }
    } catch (e) {
      debugPrint('Error updating contact: $e');
    }
  }

  // Deleting a contact from the database
  Future<void> deleteContact(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.contacts.delete(id);
      });
      await fetchContacts(); // Using the fetchContact() method to refresh and update the contact list in the frontend
    } catch (e) {
      debugPrint('Error deleting contact: $e');
    }
  }
}
