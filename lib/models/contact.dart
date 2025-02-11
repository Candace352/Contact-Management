import 'package:isar/isar.dart';

part 'contact.g.dart';

@Collection()
class Contact {
  Id id = Isar.autoIncrement; // Auto-increment ID for Isar database
  late String firstName;
  late String lastName;
  late String contactNumber;

  // Named constructor for better readability
  Contact({
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
  });


//Constructor for when creating a new contact, every contact should have the instance variables declared above
  factory Contact.create(String firstName, String lastName, String contactNumber) {
    return Contact(
      firstName: firstName,
      lastName: lastName,
      contactNumber: contactNumber,
    );
  }
}