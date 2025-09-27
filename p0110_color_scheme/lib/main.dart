import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // SettingsオブジェクトをProviderの管理下に置く。
    ChangeNotifierProvider(
      create: (context) => Settings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    // ProviderからSettingsオブジェクトを取得
    Settings settings = Provider.of<Settings>(context);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        // ここでカラースキームを決定する。
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        // システムのダイナミックカラーを取得で来て、かつユーザーがその利用を望んでいるか。
        if (lightDynamic != null &&
            darkDynamic != null &&
            settings.isWallpaperBased) {
          // 壁紙に基づくカラースキームを利用する。
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          // アプリ固有のカラースキームを利用する。
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          );
        }

        // 生成したカラースキームに基づいてアプリを構築する。
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<Settings>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SegmentedButton<bool>(
              segments: const <ButtonSegment<bool>>[
                ButtonSegment<bool>(
                  value: false,
                  label: Text('アプリ'),
                  icon: Icon(Icons.home),
                ),
                ButtonSegment<bool>(
                  value: true,
                  label: Text('壁紙'),
                  icon: Icon(Icons.wallpaper),
                ),
              ],
              selected: <bool>{settings.isWallpaperBased},
              onSelectionChanged: (Set<bool> newSelection) {
                settings.isWallpaperBased = newSelection.first;
              },
            ),
            const SizedBox(height: 32),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// カラースキームをどう生成するか、ユーザーの選択を保持するクラス
//
// このクラスはProviderの管理下でアプリ全体で共有される。
class Settings with ChangeNotifier {
  bool _isWallpaperBased = true;

  bool get isWallpaperBased => _isWallpaperBased;

  set isWallpaperBased(bool value) {
    if (_isWallpaperBased != value) {
      _isWallpaperBased = value;
      notifyListeners();
    }
  }
}
