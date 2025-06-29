import 'package:flutter/material.dart';
import 'unified_input_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: UnifiedInputScreen(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.whatshot_rounded, size: 96, color: Color(0xFFFFB300)),
            const SizedBox(height: 20),
            const Text(
              'ولّعها',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
                fontFamily: 'Cairo',
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '🎯 التطبيق الذكي لمودك اليومي – إصدار V2.5',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
