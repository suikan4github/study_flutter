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
        appBar: AppBar(title: const Text('Autocomplete Example')),
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
    'Papaya',
    'Coconut',
    'Lemon',
    'Lime',
    'Raspberry',
    'Blackberry',
    'Watermelon',
    'Pineapple',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          // 入力文字列が空の場合は、すべてのオプションを返す
          return _options;
        }
        // 入力文字列がある場合は、先頭一致でフィルタリング
        return _options.where((String option) {
          return option.toLowerCase(). /*startsWith*/ contains(
            textEditingValue.text.toLowerCase(),
          );
        });
      },

      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
              decoration: const InputDecoration(
                labelText: 'フルーツ名を入力',
                border: OutlineInputBorder(),
              ),
            );
          },

      onSelected: (String selection) {
        debugPrint('選択されたフルーツ: $selection');
      },

      // optionsViewBuilderをシンプルに修正
      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            // 入力文字列が空でない場合、または候補が1つ以上ある場合はリストを表示
            // 入力文字列が空で、かつ候補が元のリストと同じ場合は、フォーカスがないと判断して非表示にする
            if (options.isEmpty) {
              return const SizedBox.shrink();
            }

            // optionsの数が元のリストと同じで、かつテキストフィールドが空の場合（フォーカスが外れた状態）にリストを非表示にする
            // ただし、このロジックは完全ではありません。
            // より安全なのは、onTapでリストを閉じること。

            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        // GestureDetectorの代わりにInkWellを使用
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(title: Text(option)),
                      );
                    },
                  ),
                ),
              ),
            );
          },
    );
  }
}
