// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contact_management_app/models/contact.dart';

class ApiService {
  // 1. Getting a Single Contact
  static Future<Map<String, dynamic>> getSingleContact(int contid) async {
    final String url =
        'https://apps.ashesi.edu.gh/contactmgt/actions/get_a_contact_mob?contid=$contid';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load contact');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error fetching single contact');
    }
  }

  // 2. Getting All Contacts
  static Future<List<Contact>> getAllContacts() async {
    final String url =
        'https://apps.ashesi.edu.gh/contactmgt/actions/get_all_contact_mob';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Contact.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load contacts');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error fetching all contacts');
    }
  }

  // 3. Adding the  New Contact
  static Future<String> addNewContact(String fullname, String phonename) async {
    final String url =
        'https://apps.ashesi.edu.gh/contactmgt/actions/add_contact_mob';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['ufullname'] = fullname
        ..fields['uphonename'] = phonename;

      var response = await request.send();
      print("Response ${response.toString()}");

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return responseData; // API might return 'success' or 'failed'
      } else {
        return 'failed';
      }
    } catch (e) {
      print("Error: $e");
      return 'failed';
    }
  }

  // 4. Editing the Contact
  static Future<String> editContact(
      String fullname, String phonename, int cid) async {
    final String url =
        'https://apps.ashesi.edu.gh/contactmgt/actions/update_contact';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['cid'] = cid.toString()
        ..fields['ufullname'] = fullname
        ..fields['uphonename'] = phonename;

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return responseData; // Expected response: 'success' or 'failed'
      } else {
        throw Exception(
            'Failed to update contact. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error updating contact: $e');
    }
  }

  // 5. Deleting the Contact
  static Future<bool> deleteContact(int cid) async {
    final String url =
        'https://apps.ashesi.edu.gh/contactmgt/actions/delete_contact';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['cid'] = cid.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return responseData == 'true'; // Expected response: 'true' or 'false'
      } else {
        throw Exception('Failed to delete contact');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error deleting contact');
    }
  }

  // 6. Updating the Contact
  static Future<String> updateContact(
      int pid, String pname, String pphone) async {
    final String url =
        'https://apps.ashesi.edu.gh/contactmgt/actions/update_contact';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['cid'] = pid.toString()
        ..fields['cname'] = pname
        ..fields['cnum'] = pphone;

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return responseData; // Expected response: 'success' or 'failed'
      } else {
        throw Exception('Failed to update contact');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error updating contact');
    }
  }
}
