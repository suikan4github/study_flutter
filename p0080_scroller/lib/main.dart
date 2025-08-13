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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToFocusedItem(isInitial: true);
    });
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
    setState(() {});
  }

  void _scrollToFocusedItem({bool isInitial = false}) {
    if (_scrollController.hasClients) {
      final double itemHeight = 48.0;
      final double focusedOffset = _focusedIndex * itemHeight;
      final double screenHeight = MediaQuery.of(context).size.height;
      final double halfScreenHeight = screenHeight / 2;

      final double targetOffset =
          focusedOffset - halfScreenHeight + (itemHeight / 2);

      if (isInitial) {
        _scrollController.jumpTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        );
      } else {
        _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _onFocusChanged() {
    print('新しいフォーカス: ${foo[_focusedIndex]}');
  }

  // --- 新しく追加されたメソッド ---
  void _markItem() {
    setState(() {
      final currentItem = foo[_focusedIndex];
      // "*"が既についている場合は、それを削除する。
      // まだついていなければ、末尾に追加する。
      if (currentItem.endsWith('*')) {
        foo[_focusedIndex] = currentItem.substring(0, currentItem.length - 1);
      } else {
        foo[_focusedIndex] = '$currentItem*';
      }
    });
  }
  // ------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: foo.length,
            itemBuilder: (context, index) {
              final isFocused = index == _focusedIndex;
              final hasSeven = foo[index].contains('7');

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
                      ? Colors.red[100]
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
              // --- 新しく追加されたボタン ---
              ElevatedButton(onPressed: _markItem, child: const Text('マーク')),
              // --------------------------
            ],
          ),
        ),
      ],
    );
  }
}
