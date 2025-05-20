import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: BaiTap2Screen(),
    );
  }
}

class BaiTap2Screen extends StatefulWidget {
  @override
  _BaiTap2ScreenState createState() => _BaiTap2ScreenState();
}

class _BaiTap2ScreenState extends State<BaiTap2Screen> {
  String _display = '0';
  String _currentMode = 'Standard';
  bool _menuOpen = false;
  
  // Các chế độ máy tính
  final List<Map<String, dynamic>> _calculatorModes = [
    {
      'title': 'Calculator',
      'isHeader': true,
    },
    {
      'title': 'Standard',
      'icon': Icons.calculate,
    },
    {
      'title': 'Scientific',
      'icon': Icons.science,
    },
    {
      'title': 'Graphing',
      'icon': Icons.bar_chart,
    },
    {
      'title': 'Programmer',
      'icon': Icons.code,
    },
    {
      'title': 'Date calculation',
      'icon': Icons.date_range,
    },
    {
      'title': 'Converter',
      'isHeader': true,
    },
    {
      'title': 'Currency',
      'icon': Icons.currency_exchange,
    },
    {
      'title': 'Volume',
      'icon': Icons.view_in_ar,
    },
    {
      'title': 'Length',
      'icon': Icons.straighten,
    },
    {
      'title': 'Weight and mass',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Temperature',
      'icon': Icons.thermostat,
    },
    {
      'title': 'Energy',
      'icon': Icons.bolt,
    },
    {
      'title': 'Area',
      'icon': Icons.crop_square,
    },
    {
      'title': 'Speed',
      'icon': Icons.speed,
    },
    {
      'title': 'Settings',
      'icon': Icons.settings,
    },
  ];
  
  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _display = '0';
      } else if (buttonText == '=') {
        try {
          // Đây chỉ là một phiên bản đơn giản, cần cải thiện logic tính toán
          _display = _evaluateExpression(_display).toString();
        } catch (e) {
          _display = 'Error';
        }
      } else if (buttonText == 'CE') {
        _display = '0';
      } else {
        if (_display == '0' && buttonText != '.') {
          _display = buttonText;
        } else {
          _display += buttonText;
        }
      }
    });
  }
  
  double _evaluateExpression(String expression) {
    // Đây là một hàm tính toán đơn giản, trong thực tế bạn có thể sử dụng thư viện
    // để xử lý biểu thức phức tạp hơn
    expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
    try {
      // Đây chỉ là một ví dụ đơn giản, không xử lý được các biểu thức phức tạp
      // Trong ứng dụng thực tế, bạn nên sử dụng một parser biểu thức toán học đầy đủ
      return 0; // Kết quả mặc định, trong thực tế sẽ tính toán biểu thức
    } catch (e) {
      return 0;
    }
  }
  
  void _changeMode(String mode) {
    setState(() {
      _currentMode = mode;
      _menuOpen = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Máy tính"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display section
          Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          _menuOpen = !_menuOpen;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      _currentMode,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Text(
                  _display,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
          // Menu overlay (hiển thị khi _menuOpen = true)
          if (_menuOpen)
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: _calculatorModes.length,
                  itemBuilder: (context, index) {
                    final item = _calculatorModes[index];
                    
                    if (item['isHeader'] == true) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                        child: Text(
                          item['title'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    
                    return ListTile(
                      leading: Icon(item['icon']),
                      title: Text(item['title']),
                      selected: _currentMode == item['title'],
                      selectedTileColor: Colors.grey.withOpacity(0.2),
                      onTap: () => _changeMode(item['title']),
                    );
                  },
                ),
              ),
            ),
          
          if (!_menuOpen)
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    // Memory buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMemoryButton('MC'),
                        _buildMemoryButton('MR'),
                        _buildMemoryButton('M+'),
                        _buildMemoryButton('M-'),
                        _buildMemoryButton('MS'),
                        _buildMemoryButton('M∨'),
                      ],
                    ),
                    // Calculator buttons
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        childAspectRatio: 1.5,
                        padding: EdgeInsets.all(8),
                        children: [
                          _buildCalculatorButton('%'),
                          _buildCalculatorButton('CE'),
                          _buildCalculatorButton('C'),
                          _buildCalculatorButton('⌫'),
                          _buildCalculatorButton('¹/ₓ'),
                          _buildCalculatorButton('x²'),
                          _buildCalculatorButton('√x'),
                          _buildCalculatorButton('÷'),
                          _buildCalculatorButton('7'),
                          _buildCalculatorButton('8'),
                          _buildCalculatorButton('9'),
                          _buildCalculatorButton('×'),
                          _buildCalculatorButton('4'),
                          _buildCalculatorButton('5'),
                          _buildCalculatorButton('6'),
                          _buildCalculatorButton('-'),
                          _buildCalculatorButton('1'),
                          _buildCalculatorButton('2'),
                          _buildCalculatorButton('3'),
                          _buildCalculatorButton('+'),
                          _buildCalculatorButton('+/-'),
                          _buildCalculatorButton('0'),
                          _buildCalculatorButton('.'),
                          _buildCalculatorButton('=', isEquals: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildMemoryButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
  
  Widget _buildCalculatorButton(String text, {bool isEquals = false}) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Material(
        color: isEquals ? Colors.blue : Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () => _onButtonPressed(text),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: isEquals ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}