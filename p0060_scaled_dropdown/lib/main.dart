import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: DropdownDemo());
  }
}

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  @override
  _DropdownDemoState createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String _selectedItem = 'アイテム１';
  final List<String> _items = ['アイテム１', '非常に長いアイテム２', 'アイテム３'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ドロップダウンとFittedBox')),
      body: Center(
        child: Container(
          width: 150, // ドロップダウンのコンテナサイズを小さく設定
          height: 50,
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<String>(
            value: _selectedItem,
            isExpanded: true, // コンテナの幅いっぱいに広げる
            items: _items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                // ドロップダウンリスト内の各項目にFittedBoxを適用
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(value, style: const TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue!;
              });
            },
            // ボタン本体にもFittedBoxを適用
            selectedItemBuilder: (BuildContext context) {
              return _items.map((String value) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(value, style: const TextStyle(fontSize: 16)),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
