import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BaiTap4Screen extends StatefulWidget {
  @override
  _BaiTap4ScreenState createState() => _BaiTap4ScreenState();
}

class _BaiTap4ScreenState extends State<BaiTap4Screen> {
  int _selectedIndex = 0;
  String _selectedMood = "";
  
  final List<Map<String, dynamic>> _moodOptions = [
    {'emoji': '😢', 'text': 'Bad'},
    {'emoji': '🙂', 'text': 'Fine'},
    {'emoji': '😊', 'text': 'Well'},
    {'emoji': '🤗', 'text': 'Excellent'},
  ];
  
  final List<Map<String, dynamic>> _exerciseCategories = [
    {
      'title': 'Speaking Skillz',
      'count': '16 Exercises',
      'color': Colors.orange,
      'icon': Icons.mic
    },
    {
      'title': 'Reading Skills',
      'count': '8 Exercises',
      'color': Colors.green,
      'icon': Icons.person
    },
    {
      'title': 'Writing Skills',
      'count': '20 Exercises',
      'color': Colors.pink,
      'icon': Icons.star
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildMoodSelector(),
            _buildExercisesList(),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    String formattedDate = DateFormat('dd MMM, yyyy').format(DateTime.now());
    
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: Colors.blue[400],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Jared!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white70, size: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMoodSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'How do you feel?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _moodOptions.map((mood) {
              return _buildMoodOption(mood['emoji'], mood['text']);
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMoodOption(String emoji, String text) {
    bool isSelected = _selectedMood == text;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = text;
        });
      },
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildExercisesList() {
    return Expanded(
      child: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercises',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_horiz, size: 20),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _exerciseCategories.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return _buildExerciseCard(
                    _exerciseCategories[index]['title'],
                    _exerciseCategories[index]['count'],
                    _exerciseCategories[index]['color'],
                    _exerciseCategories[index]['icon'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildExerciseCard(String title, String count, Color color, IconData icon) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  count,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.more_horiz, size: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomNavigation() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.home, true),
          _buildNavItem(1, Icons.chat_bubble_outline, false),
          _buildNavItem(2, Icons.person_outline, false),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(int index, IconData icon, bool isSelected) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.grey,
        size: 22,
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}