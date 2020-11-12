import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/src/saved.dart';

//이 샛기가 데이터 바뀌는거 눈치까는 클라스
//이 샛기를 메인다트에다 야무지게 넣어주면 눈치를 알아서 까버림
//순서 잣같이 해놨네
class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('naming app'),
        //AppBar 오른쪽 메뉴버튼 페이지 이동 기능
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SavedList(
                        saved: _saved,
                      )));
            },
          )
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      //조건 부분
      if (index.isOdd) {
        return Divider();
      }

      var realIndex = index ~/ 2;

      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }

      //여서 값 출력
      return _buildRow(_suggestions[realIndex]);
    });
  }

  Widget _buildRow(WordPair pair) {
    //contains 값의 유무에 따라 true false 를 반환
    final bool alreadvSaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadvSaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onTap: () {
        setState(() {
          if (alreadvSaved)
            _saved.remove(pair); // true
          else
            _saved.add(pair); // false

          print(_saved.toString());
        });
      },
    );
  }
}
