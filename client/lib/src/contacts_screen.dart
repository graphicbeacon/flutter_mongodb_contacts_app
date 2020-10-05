import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'api.dart';
import 'contact.dart';
import 'contacts_listing.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key, this.title}) : super(key: key);

  final String title;
  final ContactsApi api = ContactsApi();

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts([bool showSpinner = false]) {
    if (showSpinner) {
      setState(() {
        loading = true;
      });
    }

    widget.api.getContacts().then((data) {
      setState(() {
        contacts = data;
        loading = false;
      });
    });
  }

  void _addContact() async {
    final faker = Faker();
    final person = faker.person;
    final fullName = '${person.firstName()} ${person.lastName()}';

    final createdContact = await widget.api.createContact(fullName);
    setState(() {
      contacts.add(createdContact);
    });
  }

  void _deleteContact(String id) async {
    await widget.api.deleteContact(id);
    setState(() {
      contacts.removeWhere((contact) => contact.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ContactsListing(
              contacts: contacts,
              onAdd: _addContact,
              onDelete: _deleteContact,
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _loadContacts(true);
            },
            tooltip: 'Refresh list',
            backgroundColor: Colors.purple,
            child: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _addContact,
            tooltip: 'Add new contact',
            child: Icon(Icons.person_add),
          ),
        ],
      ),
    );
  }
}
