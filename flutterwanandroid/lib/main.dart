import 'package:flutter/material.dart';
import 'package:flutterwanandroid/common/comon.dart';
import 'package:flutterwanandroid/ui/SplashScreen.dart';

void main() => runApp(MyApp());

//Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName, // 标题
      debugShowCheckedModeBanner: false, //去掉debug图标
      theme: ThemeData(
        primaryColor: Colors.white,
        // primarySwatch: Colors.white,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new SplashScreen(), // 启动页
    );
  }
}
