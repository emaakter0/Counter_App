import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;
  Color _numberColor = Colors.black;
  double _scale = 1.0;
  String _statusMessage = 'Start';

  final Map<int, String> _increaseMessages = {
    1: 'Counting increased',
    3: 'Going higher',
    5: 'Reaching halfway',
    7: 'Making great progress',
    10: 'Excellent counting',
  };

  final Map<int, String> _decreaseMessages = {
    1: 'Counting decreased',
    3: 'Going lower',
    5: 'Approaching halfway',
    7: 'Almost at start',
    0: 'Back to beginning',
  };

  void _updateStatusMessage(String action) {
    setState(() {
      if (action == 'reset') {
        _statusMessage = 'Counter has been reset';
      } else if (action == 'increase') {
        _statusMessage = _increaseMessages[_count] ?? 'Count is now $_count';
      } else if (action == 'decrease') {
        _statusMessage = _decreaseMessages[_count] ?? 'Count is now $_count';
      }
    });
  }

  void _increase() {
    setState(() {
      _count++;
      _numberColor = Colors.green;
      _scale = 1.1;
      _updateStatusMessage('increase');
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  void _decrease() {
    setState(() {
      if (_count > 0) _count--;
      _numberColor = Colors.red;
      _scale = 1.1;
      _updateStatusMessage('decrease');
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
      _numberColor = Colors.black;
      _updateStatusMessage('reset');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003A6C), // Ateneo Blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header Text
            const Text(
              'COUNTER APP',
              style: TextStyle(
                fontSize: 38, // Slightly larger
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2, // Better spacing
              ),
            ),
            const SizedBox(height: 25),

            // Status Message (larger and bolder)
            Text(
              _statusMessage,
              style: const TextStyle(
                fontSize: 24, // Increased size
                fontWeight: FontWeight.w600, // Semi-bold
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),

            // Counter Display
            Transform.scale(
              scale: _scale,
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  '$_count',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: _numberColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Buttons with colored shadows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  icon: Icons.remove,
                  color: Colors.red[400]!,
                  shadowColor: Colors.red.withOpacity(0.5),
                  onPressed: _decrease,
                  label: 'DECREASE', // Added label
                ),
                const SizedBox(width: 30),
                _buildButton(
                  icon: Icons.refresh,
                  color: Colors.blue[200]!,
                  shadowColor: Colors.blue.withOpacity(0.5),
                  onPressed: _reset,
                  label: 'RESET', // Added label
                ),
                const SizedBox(width: 30),
                _buildButton(
                  icon: Icons.add,
                  color: Colors.green[400]!,
                  shadowColor: Colors.green.withOpacity(0.5),
                  onPressed: _increase,
                  label: 'INCREASE', // Added label
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required Color color,
    required Color shadowColor,
    required VoidCallback onPressed,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, size: 40),
            color: color,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}