import 'package:flutter/material.dart';

class BaiTap5Screen extends StatefulWidget {
  @override
  _BaiTap5ScreenState createState() => _BaiTap5ScreenState();
}

class _BaiTap5ScreenState extends State<BaiTap5Screen> {
  int _currentCardIndex = 0;
  final List<Map<String, dynamic>> _cards = [
    {
      'color': Color(0xFF8A56E6),
      'balance': 5250.25,
      'cardNumber': '12345678',
      'expiry': '10/24',
    },
    {
      'color': Color(0xFF4389E5),
      'balance': 1850.75,
      'cardNumber': '87654321',
      'expiry': '05/25',
    },
    {
      'color': Color(0xFFE65691),
      'balance': 3400.50,
      'cardNumber': '23456789',
      'expiry': '12/26',
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      'icon': 'assets/send_icon.png',
      'label': 'Send',
      'iconData': Icons.attach_money,
      'iconColor': Colors.green,
    },
    {
      'icon': 'assets/pay_icon.png',
      'label': 'Pay',
      'iconData': Icons.credit_card,
      'iconColor': Colors.blue,
    },
    {
      'icon': 'assets/bills_icon.png',
      'label': 'Bills',
      'iconData': Icons.receipt_long,
      'iconColor': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCardSection(),
            _buildCardIndicator(),
            _buildQuickActions(),
            _buildMenuItems(),
            _buildFloatingActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Cards',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.add,
              color: Colors.black54,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection() {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: _cards.length,
        onPageChanged: (index) {
          setState(() {
            _currentCardIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return _buildCard(_cards[index]);
        },
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> card) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: card['color'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: card['color'].withOpacity(0.4),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Balance',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$${card['balance'].toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card['cardNumber'].toString(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                Text(
                  card['expiry'],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _cards.length,
        (index) => Container(
          width: index == _currentCardIndex ? 24 : 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == _currentCardIndex
                ? Colors.black54
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _quickActions.map((action) {
          return _buildActionItem(action);
        }).toList(),
      ),
    );
  }

  Widget _buildActionItem(Map<String, dynamic> action) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            action['iconData'],
            color: action['iconColor'],
            size: 28,
          ),
        ),
        SizedBox(height: 8),
        Text(
          action['label'],
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildMenuItem(
              'Statistics',
              'Payment and Income',
              Icons.bar_chart,
              Colors.blue,
              Colors.orange,
              Colors.green,
              Colors.red,
            ),
            SizedBox(height: 16),
            _buildMenuItem(
              'Transactions',
              'Transaction History',
              Icons.compare_arrows,
              Colors.green,
              Colors.green,
              Colors.green,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    String subtitle,
    IconData iconData,
    Color color1,
    Color color2,
    Color color3,
    Color color4,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: title == 'Statistics'
                ? Icon(Icons.bar_chart, color: color1, size: 28)
                : Icon(Icons.compare_arrows, color: color1, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.attach_money,
          color: Colors.white,
        ),
      ),
    );
  }
}