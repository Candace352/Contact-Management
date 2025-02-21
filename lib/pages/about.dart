import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Contacts Application',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[400],
        elevation: 3,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.brown[100],
                  ),
                  child:
                      const Icon(Icons.contacts, size: 80, color: Colors.brown),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Contact Management Application',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'A simple yet powerful tool to store, manage, and organize your contacts efficiently.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildInfoCard(Icons.info, 'Version', '1.1.0'),
                _buildInfoCard(
                    Icons.person, 'Developer', 'Candace Tariro Hunzwi'),
                _buildInfoCard(Icons.badge, 'Student ID', '92142025'),
                _buildInfoCard(Icons.calendar_today, 'Year', '2025'),
                const SizedBox(height: 20),
                const Divider(color: Colors.brown, thickness: 1),
                const SizedBox(height: 10),
                const Text(
                  '"Hard Work & Persistence"',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'This app is open-source and built using Flutter.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      elevation: 3,
      color: Colors.brown[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.brown),
        title: Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
