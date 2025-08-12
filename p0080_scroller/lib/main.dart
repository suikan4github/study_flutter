import 'dart:async';
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
        appBar: AppBar(title: const Text('Flutter Focus List')),
        body: const FocusListScreen(),
      ),
    );
  }
}

class FocusListScreen extends StatefulWidget {
  const FocusListScreen({super.key});

  @override
  State<FocusListScreen> createState() => _FocusListScreenState();
}

class _FocusListScreenState extends State<FocusListScreen> {
  final List<String> foo = List.generate(100, (index) => 'アイテム $index');
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollToFocusedItem(isInitial: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _focusedIndex = (_focusedIndex + 1) % foo.length;
        _scrollToFocusedItem();
        _onFocusChanged();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {}); // ボタンの状態を更新するために呼び出す
  }

  void _scrollToFocusedItem({bool isInitial = false}) {
    if (_scrollController.hasClients) {
      final double itemHeight = 48.0; // ListTileの高さ
      final double focusedOffset = _focusedIndex * itemHeight;
      final double screenHeight = MediaQuery.of(context).size.height;
      final double halfScreenHeight = screenHeight / 2;

      // フォーカスされたアイテムが画面の中央に来るようにスクロール位置を調整
      final double targetOffset =
          focusedOffset - halfScreenHeight + (itemHeight / 2);

      if (isInitial) {
        // 初期表示時はアニメーションなしでジャンプ
        _scrollController.jumpTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        );
      } else {
        // それ以外はアニメーションでスクロール
        _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _onFocusChanged() {
    // フォーカスが変更されたときに実行したい処理をここに記述
    print('新しいフォーカス: ${foo[_focusedIndex]}');
  }

  @override
  Widget build(BuildContext context) {
    final int startIndex = (_focusedIndex - 2).clamp(0, foo.length - 1);
    final int endIndex = (_focusedIndex + 2).clamp(0, foo.length - 1);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: foo.length,
            itemBuilder: (context, index) {
              final isFocused = index == _focusedIndex;
              final isWithinRange = index >= startIndex && index <= endIndex;
              final hasSeven = foo[index].contains('7');

              // フォーカスされたアイテムとその前後2つのみを表示
              if (!isWithinRange) {
                return const SizedBox.shrink();
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _focusedIndex = index;
                    _stopTimer();
                    _scrollToFocusedItem();
                    _onFocusChanged();
                  });
                },
                child: Container(
                  color: isFocused
                      ? Colors.blue
                      : hasSeven
                      ? Colors.red[100] // "7"が含まれる場合の背景色
                      : null,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    foo[index],
                    style: TextStyle(
                      fontSize: 16,
                      color: isFocused ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: _startTimer, child: const Text('スタート')),
              ElevatedButton(onPressed: _stopTimer, child: const Text('ストップ')),
            ],
          ),
        ),
      ],
    );
  }
}
