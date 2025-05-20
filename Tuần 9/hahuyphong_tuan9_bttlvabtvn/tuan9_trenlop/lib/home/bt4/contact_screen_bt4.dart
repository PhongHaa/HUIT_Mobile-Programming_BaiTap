import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tuan9_trenlop/database/db_helper.dart';
import 'package:tuan9_trenlop/exercises/class/add_contact_screen.dart';

class ContactScreenBT4 extends StatefulWidget {
  const ContactScreenBT4({super.key});

  @override
  State<ContactScreenBT4> createState() => _ContactScreenBT4State();
}

class _ContactScreenBT4State extends State<ContactScreenBT4> {
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _searchController.addListener(_filterContacts);
  }

  Future<void> _loadContacts() async {
    final data = await DBHelper().getContacts();
    setState(() {
      _contacts = data;
      _filteredContacts = data;
    });
  }

  void _filterContacts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts =
          _contacts.where((contact) {
            final name = contact['name']?.toLowerCase() ?? '';
            final phone = contact['phone']?.toLowerCase() ?? '';
            return name.contains(query) || phone.contains(query);
          }).toList();
    });
  }

  void _deleteContact(int id) async {
    final db = await DBHelper().database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
    _loadContacts();
  }

  void _editContact(Map<String, dynamic> contact) async {
    // TODO: Hiển thị dialog hoặc chuyển sang màn hình sửa thông tin
    // Sau khi sửa xong và cập nhật vào DB, gọi lại _loadContacts();
  }

  Widget _buildAvatar(Uint8List? avatar) {
    if (avatar != null) {
      return CircleAvatar(backgroundImage: MemoryImage(avatar));
    } else {
      return const CircleAvatar(child: Icon(Icons.person));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
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
              _loadContacts();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredContacts.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final contact = _filteredContacts[index];
                return ListTile(
                  leading: _buildAvatar(contact['avatar']),
                  title: Text(contact['name'] ?? ''),
                  subtitle: Text(contact['phone'] ?? ''),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editContact(contact);
                      } else if (value == 'delete') {
                        _deleteContact(contact['id']);
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
