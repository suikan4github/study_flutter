import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 親の制約からアスペクト比を計算
        double currentAspectRatio =
            constraints.maxWidth / constraints.maxHeight;

        // 画面が3:2より横に太い場合
        if (currentAspectRatio > 3 / 4) {
          return Container(
            color: Colors.black,
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: constraints.maxHeight * (3 / 4),
                  height: constraints.maxHeight,
                  child: const AppPage(),
                ),
              ),
            ),
          );
        } else {
          // 画面が3:2以下の場合
          return const AppPage();
        }
      },
    );
  }
}

// アプリのメインコンテンツ
class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FittedBox Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('FittedBox Demo')),
        body: Container(
          color: Colors.white,
          child: const Center(child: Text('このアプリは 4:3 の縦横比に制限されています。')),
        ),
      ),
    );
  }
}
