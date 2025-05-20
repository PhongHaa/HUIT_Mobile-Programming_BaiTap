import 'package:flutter/material.dart';
import 'package:tuan9_trenlop/database/db_helper.dart';
import 'add_contact_screen.dart';

class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});
  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  List<Map<String, dynamic>> _contacts = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
    });
    final contacts = await DBHelper().getContacts();
    setState(() {
      _contacts = contacts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh bạ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddContactScreen(),
                ),
              );
              _loadContacts(); // Tải lại danh bạ sau khi thêm
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _contacts.isEmpty
              ? const Center(child: Text('Không có danh bạ nào.'))
              : ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return ListTile(
                    leading:
                        contact['avatar'] != null
                            ? CircleAvatar(
                              backgroundImage: MemoryImage(contact['avatar']),
                            )
                            : const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(contact['name'] ?? 'Không có tên'),
                    subtitle: Text(
                      '${contact['phone'] ?? 'Không có số'}\n${contact['email'] ?? 'Không có email'}',
                    ),
                  );
                },
              ),
    );
  }
}
