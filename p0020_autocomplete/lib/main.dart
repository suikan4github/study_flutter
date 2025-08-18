import 'package:flutter/material.dart';

void main() {
  runApp(const AutocompleteExampleApp());
}

class AutocompleteExampleApp extends StatelessWidget {
  const AutocompleteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Autocomplete (Default) Example')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: AutocompleteExample(),
          ),
        ),
      ),
    );
  }
}

class AutocompleteExample extends StatelessWidget {
  const AutocompleteExample({super.key});

  static const List<String> _options = <String>[
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Strawberry',
    'Cherry',
    'Peach',
    'Mango',
    'Blueberry',
    'Kiwi',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          // 入力が空の場合は何も表示しない
          return const Iterable<String>.empty();
        }
        // 入力値に部分一致するオプションを返す
        return _options.where((String option) {
          return option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          );
        });
      },
      onSelected: (String selection) {
        debugPrint('選択されたフルーツ: $selection');
      },
    );
  }
}
