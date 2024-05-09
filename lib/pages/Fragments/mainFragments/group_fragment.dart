import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class GroupFragment extends StatelessWidget {
  const GroupFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: const Center(

          child: Text("groups here")), // Move the ContactList widget outside the bottom modal sheet
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactModal(context); // Show bottom modal sheet when FAB is pressed
        },
        child: const Icon(Icons.sync),
      ),
    );
  }

  void _showContactModal(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      scrollControlDisabledMaxHeightRatio: 0.89,
      context: context,
      builder: (BuildContext context) {
        return const ContactList(); // Display the ContactList widget within the bottom modal sheet
      },
    );
  }
}
class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);

    return Consumer<ContactProvider>(
      builder: (context, provider, _) {
        if (provider.contacts == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _fetchContacts(context);
                  },
                  child: const Text('Sync Contacts'),
                ),
                const SizedBox(height: 20),
                const Text('Press "Sync Contacts" to fetch contacts'),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search contacts...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    // Implement search functionality here
                    List<Contact> filteredContacts = [];
                    if (query.isNotEmpty) {
                      filteredContacts = provider.contacts!.where((contact) {
                        return contact.displayName!.toLowerCase().contains(query.toLowerCase());
                      }).toList();
                    } else {
                      // If the query is empty, show all contacts
                      filteredContacts = provider.contacts!.toList();
                    }
                    // Update the contacts shown based on the search result
                    contactProvider.setContacts(filteredContacts);

                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.contacts!.length,
                  itemBuilder: (context, index) {
                    Contact contact = provider.contacts!.elementAt(index);
                    // Check if contact's number exists in Firestore (replace with your logic)
                    bool isContactInFirestore = false; // Replace with your logic
                    String title = contact.displayName ?? 'No Name';
                    String subtitle = contact.phones!.isNotEmpty
                        ? contact.phones!.elementAt(0).value ?? 'No phone number'
                        : 'No phone number';
                    return ListTile(
                      title: Text(title),
                      subtitle: Text(subtitle),
                      trailing: !isContactInFirestore
                          ? ElevatedButton(
                        onPressed: () {
                          // Handle invite action
                          // Replace with your logic to handle invite action
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Invite"),
                                content: Text(
                                    "Invite ${contact.displayName ?? 'this contact'}?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Send invitation
                                      // Replace with your logic to send invitation
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Invite"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Invite'),
                      )
                          : null,
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> _fetchContacts(BuildContext context) async {
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isDenied) {
        // Permission was denied, show a dialog explaining why the permission is necessary
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Contacts Permission Required"),
              content: const Text(
                  "Please grant permission to access your contacts so that we can find friends to invite."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }
    }

    Iterable<Contact> contacts = await ContactsService.getContacts();
    contactProvider.setContacts(contacts);
  }
}
class ContactProvider extends ChangeNotifier {
  Iterable<Contact>? _contacts;

  Iterable<Contact>? get contacts => _contacts;

  void setContacts(Iterable<Contact> contacts) {
    _contacts = contacts;
    notifyListeners();
  }
}

