import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

//이 샛기가 데이터 바뀌는거 눈치까는 클라스
//이 샛기를 메인다트에다 야무지게 넣어주면 눈치를 알아서 까버림
class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('naming app'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        }

        var realIndex = index ~/ 2;

        if(realIndex >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return Text(
          realIndex.toString(),
          textScaleFactor: 1.5,
        );
      }),
    );
  }
}
