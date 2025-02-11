import 'package:flutter/material.dart';
import 'package:contact_management_app/pages/contacts_list.dart';
import 'package:contact_management_app/pages/add_contact.dart';
import 'package:contact_management_app/pages/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Management App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Index of the selected bottom navigation bar item

  // List of pages to display based on the selected index
  final List<Widget> _pages = [
    const ContactsList(), // Contacts List page
    const AddContact(), // Add Contact page
    const About(), // About page
  ];

  // Function to handle bottom navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts), // Contacts icon
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add), // Add icon
            label: 'Add Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info), // Info icon
            label: 'About',
          ),
        ],
        selectedItemColor: Colors.brown[400], // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
      ),
    );
  }
}
