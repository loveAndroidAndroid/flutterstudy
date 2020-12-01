import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterwanandroid/common/comon.dart';
import 'package:flutterwanandroid/common/user.dart';
import 'package:flutterwanandroid/components/ToastUtil.dart';
import 'package:flutterwanandroid/data/api/ApiService.dart';
import 'package:flutterwanandroid/data/model/UserModel.dart';
import 'package:flutterwanandroid/utils/print_long.dart';

void main() => runApp(MyApp());

//Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          // primarySwatch: Colors.white,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RandomWords());
  }
}

//Stateful widgets 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
// 一个 StatefulWidget类。
// 一个 State类。 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在.
class RandomWords extends StatefulWidget {
  @override
  createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ToastUtil.show(msg: "中间显示的 ");
          // _register();
          _login("zhangxiaowen1", "zhangxiaowen1");
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future _login(String username, String password) async {
    if ((null != username && username.length > 0) &&
        (null != password && password.length > 0)) {
      apiService.login((UserModel model, Response response) {
        if (null != model) {
          printLong(model.errorMsg);
          if (model.errorCode == Constants.STATUS_SUCCESS) {
            User().saveUserInfo(model, response);
            ToastUtil.show(msg: "登录成功");
          } else {
            ToastUtil.show(msg: model.errorMsg);
          }
        }
      }, (DioError error) {
        print(error.response);
      }, username, password);
    } else {
      ToastUtil.show(msg: "用户名或密码不能为空");
    }
  }

  Future _register() async {
    apiService.register((UserModel _userModel) {
      if (_userModel != null) {
        if (_userModel.errorCode == 0) {
          ToastUtil.show(msg: "注册成功！");
        } else {
          ToastUtil.show(msg: _userModel.errorMsg);
        }
      }
    }, (DioError error) {
      print(error.response);
    }, "zhangxiaowen1", "zhangxiaowen1");
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

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.blue : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return Divider();

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }
}
