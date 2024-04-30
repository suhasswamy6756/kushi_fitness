import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseContactsScreen extends StatefulWidget {
  @override
  _DatabaseContactsScreenState createState() => _DatabaseContactsScreenState();
}

class _DatabaseContactsScreenState extends State<DatabaseContactsScreen> {
  late Future<List<String>> _databaseContactsFuture;

  @override
  void initState() {
    super.initState();
    _databaseContactsFuture = fetchDatabaseContacts();
  }

  Future<List<String>> fetchDatabaseContacts() async {
    List<String> databaseContacts = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('contact').get();
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        // Assume each document in the 'users' collection has a field named 'phoneNumber'
        String phoneNumber = docSnapshot.get('phoneNumber');
        databaseContacts.add(phoneNumber);
      }
    } catch (e) {
      print('Error fetching database contacts: $e');
    }
    return databaseContacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Contacts'),
      ),
      body: FutureBuilder<List<String>>(
        future: _databaseContactsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String> databaseContacts = snapshot.data ?? [];
            return ListView.builder(
              itemCount: databaseContacts.length,
              itemBuilder: (context, index) {
                String contact = databaseContacts[index];
                return Material( // Wrap the ListTile with Material
                  child: ListTile(
                    title: Text(contact),
                    // Add any additional UI components or functionality here
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
