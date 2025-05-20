import 'package:flutter/material.dart';
import 'exercises/sample/sms_contacts_home.dart';
import 'exercises/class/contacts_list_screen.dart';
import 'package:tuan9_trenlop/home/bt4/contact_screen_bt4.dart';
import 'package:tuan9_trenlop/home/bt5/sms_analyzer_app.dart';

void main() {
  runApp(const MainMenuApp());
}

class MainMenuApp extends StatelessWidget {
  const MainMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Tổng',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Tổng')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chọn một ứng dụng:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainApp()),
                );
              },
              child: const Text('📱 SMS & Contacts Reader'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactsListScreen(),
                  ),
                );
              },
              child: const Text('📇 Danh bạ'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreenBT4(),
                  ),
                );
              },
              child: const Text('📖 Danh bạ (BT4)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SmsAnalyzerApp(),
                  ),
                );
              },
              child: const Text('📊 SMS Analyzer (BT5)'),
            ),
          ],
        ),
      ),
    );
  }
}
