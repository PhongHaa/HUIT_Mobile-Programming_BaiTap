import 'package:flutter/material.dart';

class BaiTap3Screen extends StatefulWidget {
  @override
  _BaiTap3ScreenState createState() => _BaiTap3ScreenState();
}

class _BaiTap3ScreenState extends State<BaiTap3Screen> {
  int _selectedIndex = 0;
  final List<String> _gradientTypes = ['Linear', 'Mirror-title', 'Radial'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar Demo'),
        backgroundColor: Colors.teal,
      ),
      body: _buildGradientScreen(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavigationItem(0, Icons.linear_scale, 'Linear'),
              _buildNavigationItem(1, Icons.view_column, 'Mirror-title'),
              _buildNavigationItem(2, Icons.radio_button_checked, 'Radial'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.orange : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientScreen(int index) {
    switch (index) {
      case 0:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.orange],
            ),
          ),
        );
      case 1:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.orange,
                Colors.blue,
                Colors.orange,
                Colors.blue,
              ],
              stops: [0.0, 0.25, 0.5, 0.75, 1.0],
            ),
          ),
        );
      case 2:
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.0,
              colors: [
                Colors.blue,
                Colors.purple,
                Colors.blue,
                Colors.purple,
                Colors.blue,
              ],
              stops: [0.0, 0.25, 0.5, 0.75, 1.0],
            ),
          ),
        );
      default:
        return Container(color: Colors.white);
    }
  }
}