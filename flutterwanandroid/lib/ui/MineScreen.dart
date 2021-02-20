
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutterwanandroid/components/ToastUtil.dart';

/// 我的页面
class MineScreen extends StatefulWidget {
  final Set<WordPair> saved;

  const MineScreen({Key key, this.saved}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new MineScreenState(this.saved);
  }
}

class MineScreenState extends State<MineScreen> {

  Set<WordPair> _saved;

  MineScreenState(Set<WordPair> saved){
    this._saved = saved;
  }

  final _mine = <String>["我的收藏"];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {

    final tiles = _mine.map(
          (pair) {
        return ListTile(
          title: Text(
            pair,
            style: _biggerFont,
          ),
          onTap: () {
            if(pair == "我的收藏"){
              _pushSaved();
            }
          },
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context,tiles: divided).toList(),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('收藏的内容'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

}
