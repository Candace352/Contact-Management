import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_management_app/models/contacts_database.dart'; // Import ContactsDatabase
import 'package:contact_management_app/pages/contacts_list.dart'; // Import ContactsList
import 'package:contact_management_app/pages/add_contact.dart'; // Import AddContact
import 'package:contact_management_app/pages/about.dart'; // Import About

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the ContactsDatabase
  final contactsDatabase = ContactsDatabase();
  await contactsDatabase.initialize(); // Initialize the database

  // Run the app with MultiProvider because i faced problems with the provider as it was facing challenges contacts database
  runApp(
    MultiProvider(
      providers: [
        // Provide the ContactsDatabase instance to the app
        ChangeNotifierProvider(create: (_) => contactsDatabase),
      ],
      child: const MyApp(),
    ),
  );
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
    const ContactsList(), 
    const AddContact(), 
    const About(), 
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
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts), 
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add), 
            label: 'Add Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info), 
            label: 'About',
          ),
        ],
        selectedItemColor: Colors.brown[400], // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
      ),
    );
  }
}
