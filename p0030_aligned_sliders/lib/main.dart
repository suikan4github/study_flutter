import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/onsetDemo': (context) => const OnsetDemoScreen(),
      },
    );
  }
}

// ホーム画面
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム画面')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, // 固定幅
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/onsetDemo');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.speaker),
                    SizedBox(width: 8),
                    Text('発音練習を開始'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200, // 固定幅
              child: ElevatedButton(
                onPressed: () {
                  // 他の処理
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('設定'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// デモ画面
class OnsetDemoScreen extends StatefulWidget {
  const OnsetDemoScreen({super.key});

  @override
  State<OnsetDemoScreen> createState() => _OnsetDemoScreenState();
}

class _OnsetDemoScreenState extends State<OnsetDemoScreen> {
  double _volume = 1.0;
  double _speed = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('発音練習デモ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: const Text('音量', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    value: _volume,
                    min: 0.0,
                    max: 2.0,
                    onChanged: (double value) {
                      setState(() {
                        _volume = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: const Text('再生速度', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    value: _speed,
                    min: 0.0,
                    max: 2.0,
                    onChanged: (double value) {
                      setState(() {
                        _speed = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '音量: ${_volume.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              '再生速度: ${_speed.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
