import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('UI グループとボタン')),
        body: MyTwoGroupsWithButtons(),
      ),
    );
  }
}

class MyTwoGroupsWithButtons extends StatelessWidget {
  const MyTwoGroupsWithButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 最初のUIグループ
        Expanded(
          child: Container(
            color: Colors.blue[100],
            child: Center(
              child: Column(
                // グループ内の要素を縦に並べる
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('グループ 1', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // ボタン1が押されたときの処理
                      print('ボタン1が押されました');
                    },
                    child: const Text('ボタン 1'),
                  ),
                ],
              ),
            ),
          ),
        ),

        // 2つ目のUIグループ
        Expanded(
          child: Container(
            color: Colors.green[100],
            child: Center(
              child: Column(
                // グループ内の要素を縦に並べる
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('グループ 2', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // ボタン2が押されたときの処理
                      print('ボタン2が押されました');
                    },
                    child: const Text('ボタン 2'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
