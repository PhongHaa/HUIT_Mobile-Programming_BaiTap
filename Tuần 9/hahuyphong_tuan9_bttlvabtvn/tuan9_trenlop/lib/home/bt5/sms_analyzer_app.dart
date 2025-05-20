import 'package:flutter/material.dart';
import 'package:another_telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class SmsAnalyzerApp extends StatelessWidget {
  const SmsAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Analyzer',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const SmsAnalyzerScreen(),
    );
  }
}

class SmsAnalyzerScreen extends StatefulWidget {
  const SmsAnalyzerScreen({super.key});

  @override
  State<SmsAnalyzerScreen> createState() => _SmsAnalyzerScreenState();
}

class _SmsAnalyzerScreenState extends State<SmsAnalyzerScreen> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> _messages = [];
  List<SmsMessage> _filteredMessages = [];
  bool _isLoading = true;
  String _filterPhone = '';
  String _groupFilter = 'Tất cả';
  String _statisticType = 'Ngày';

  @override
  void initState() {
    super.initState();
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.sms, Permission.phone].request();
    if (statuses[Permission.sms]!.isGranted) {
      _loadMessages();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng cấp quyền để đọc SMS!')),
      );
    }
  }

  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);
    final messages = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE],
      sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)],
    );
    setState(() {
      _messages = messages;
      _filteredMessages = messages;
      _isLoading = false;
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredMessages =
          _messages.where((msg) {
            final body = msg.body?.toLowerCase() ?? '';
            final address = msg.address ?? '';
            final matchPhone =
                _filterPhone.isEmpty || address.contains(_filterPhone);
            final matchGroup = switch (_groupFilter) {
              'QC' => body.startsWith('[qc]'),
              'OTP' =>
                body.startsWith('[otp]') && RegExp(r'\d{6}').hasMatch(body),
              _ => true,
            };
            return matchPhone && matchGroup;
          }).toList();
    });
  }

  Map<String, int> _generateStatistic() {
    final statMap = <String, int>{};
    for (var msg in _filteredMessages) {
      final date = DateTime.fromMillisecondsSinceEpoch(msg.date ?? 0);
      final key =
          _statisticType == 'Ngày'
              ? DateFormat('yyyy-MM-dd').format(date)
              : DateFormat('yyyy-MM').format(date);
      statMap[key] = (statMap[key] ?? 0) + 1;
    }
    return statMap;
  }

  void _onOtpTap(SmsMessage message) {
    final body = message.body ?? '';
    final otpMatch = RegExp(r'\d{6}').firstMatch(body);
    final otp = otpMatch?.group(0) ?? 'Không tìm thấy OTP';
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Mã OTP'),
            content: Text('Mã OTP là: $otp'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Widget _buildMessageItem(SmsMessage msg) {
    final isOtp = msg.body?.toLowerCase().startsWith('[otp]') ?? false;
    return ListTile(
      title: Text(msg.body ?? 'Không có nội dung'),
      subtitle: Text('Từ: ${msg.address ?? 'Không rõ'}'),
      onTap: isOtp ? () => _onOtpTap(msg) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final statMap = _generateStatistic();

    return Scaffold(
      appBar: AppBar(title: const Text('📊 SMS Analyzer')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Tổng số tin nhắn: ${_filteredMessages.length}'),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Lọc theo số điện thoại',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _filterPhone = value;
                            _applyFilters();
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _groupFilter,
                                decoration: const InputDecoration(
                                  labelText: 'Nhóm lọc',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Tất cả',
                                    child: Text('Tất cả'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'QC',
                                    child: Text('[QC] Quảng cáo'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'OTP',
                                    child: Text('[OTP] Mã OTP'),
                                  ),
                                ],
                                onChanged: (value) {
                                  _groupFilter = value!;
                                  _applyFilters();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _statisticType,
                                decoration: const InputDecoration(
                                  labelText: 'Thống kê theo',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Ngày',
                                    child: Text('Ngày'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Tháng',
                                    child: Text('Tháng'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _statisticType = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Thống kê:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...statMap.entries.map(
                          (e) => ListTile(
                            title: Text('${e.key}'),
                            trailing: Text('${e.value} tin'),
                          ),
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Danh sách tin nhắn:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ..._filteredMessages.map(_buildMessageItem).toList(),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
