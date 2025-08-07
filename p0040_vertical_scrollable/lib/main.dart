import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: VerticalLayoutExample());
  }
}

class VerticalLayoutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('垂直レイアウトの例')),
      body: Column(
        children: <Widget>[
          // ウィジェットFoo (高さ固定)
          Container(
            height: 100,
            color: Colors.blue,
            child: Center(
              child: Text(
                'ウィジェットFoo (高さ固定)',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),

          // ウィジェットBar (残りスペースを埋め、スクロール可能)
          Expanded(child: SingleChildScrollView(child: BarWidget())),
        ],
      ),
    );
  }
}

// ウィジェットBarのサンプル（内部の四角形が正方形になるように修正）
class BarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 画面の幅を取得
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.green,
      child: Column(
        children: <Widget>[
          // 内部の四角形ウィジェット
          // AspectRatioで正方形にする
          AspectRatio(
            aspectRatio: 1.0, // 縦横比を1.0に設定して正方形にする
            child: Container(
              width: screenWidth * 0.9, // 画面幅に依存する幅
              color: Colors.orange,
              child: Center(child: Text('正方形の四角形')),
            ),
          ),
          SizedBox(height: 20),
          Text('ここからスクロール可能なコンテンツ', style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          // スクロール可能であることを示すためのダミーコンテンツ
          for (var i = 0; i < 3; i++)
            Container(
              height: 30,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Colors.lightGreen[100 + (i * 10)],
              child: Center(child: Text('アイテム $i')),
            ),
        ],
      ),
    );
  }
}
