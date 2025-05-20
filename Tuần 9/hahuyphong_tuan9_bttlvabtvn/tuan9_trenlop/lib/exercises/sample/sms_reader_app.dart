import 'package:flutter/material.dart';
import 'package:another_telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsReaderApp extends StatelessWidget {
  const SmsReaderApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Reader',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SmsReaderHome(),
    );
  }
}

class SmsReaderHome extends StatefulWidget {
  const SmsReaderHome({super.key});
  @override
  State<SmsReaderHome> createState() => _SmsReaderHomeState();
}

class _SmsReaderHomeState extends State<SmsReaderHome> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> _messages = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    // Yêu cầu quyền SMS
    Map<Permission, PermissionStatus> statuses =
        await [Permission.sms, Permission.phone].request();
    if (statuses[Permission.sms]!.isGranted) {
      _loadMessages();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng cấp quyền để đọc tin nhắn SMS!'),
        ),
      );
    }
  }

  Future<void> _loadMessages() async {
    setState(() {
      _isLoading = true;
    });
    // Lấy tin nhắn từ hộp thư đến
    List<SmsMessage> messages = await telephony.getInboxSms(
      columns: [
        SmsColumn.ADDRESS,
        SmsColumn.BODY,
        SmsColumn.DATE,
        SmsColumn.TYPE,
      ],
      sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)],
    );
    setState(() {
      _messages = messages;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SMS Reader')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _messages.isEmpty
              ? const Center(child: Text('Không có tin nhắn nào.'))
              : ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  SmsMessage message = _messages[index];
                  return ListTile(
                    title: Text(message.body ?? 'Không có nội dung'),
                    subtitle: Text('Từ: ${message.address ?? 'Không rõ'}'),
                  );
                },
              ),
    );
  }
}
