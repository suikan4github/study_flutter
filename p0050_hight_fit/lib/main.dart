import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('LayoutBuilderとオーバーフロー')),
        body: Center(
          child: Container(
            width: 700,
            height: 50,
            color: Colors.grey[300],
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // 親の利用可能な高さを取得
                final double availableHeight = constraints.maxHeight;

                // 高さからおおよそのフォントサイズを計算
                // 行間などを考慮して少し小さめに設定
                final double calculatedFontSize = availableHeight * 0.9;

                return Text(
                  'これは非常に長いテキストです',
                  style: TextStyle(
                    fontSize: calculatedFontSize, // 計算したフォントサイズを適用
                    color: Colors.black,
                  ),
                  maxLines: 1, // 1行に制限
                  overflow: TextOverflow.ellipsis, // 幅がはみ出したら三点リーダーにする
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
