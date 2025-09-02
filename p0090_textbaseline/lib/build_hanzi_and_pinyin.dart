import 'package:flutter/material.dart';

const String _pinyinOnly = "pinyin only";

/// Display a Hanzi and its pinyin.
Widget buildHanziAndPinyin(
  BuildContext context, {
  String hanzi = _pinyinOnly,
  String pinyin = "",
}) {
  const int flexHanzi = 100;
  const int flexPinyin = 150;

  final double textSize =
      (Theme.of(context).textTheme.bodyLarge!.fontSize ?? 16.0) * 1.4;

  return Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      // このRowで、すべての子要素を下揃えにする
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // hanziの部分
        hanzi == _pinyinOnly
            ? SizedBox.shrink()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('漢字: '),
                  Text(hanzi, style: TextStyle(fontSize: textSize)),
                ],
              ),
        // 間隔を空けるためのSizedBox（またはSpacer）
        SizedBox(width: 16), // 適度な間隔を空ける
        // pinyinの部分
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('ピンイン: '),
            Text(pinyin, style: TextStyle(fontSize: textSize)),
          ],
        ),
      ],
    ),
  );
} // buildHanziAndPinyin()
