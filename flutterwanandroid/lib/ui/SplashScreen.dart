import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwanandroid/ui/LoginScreen.dart';
import 'package:flutterwanandroid/utils/Utils.dart';

/// 启动页面
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          // pushAndRemoveUntil 返回到根路由
          // 3秒后跳转首页
          new MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => route == null);
    });
  }

  // Stack https://book.flutterchina.club/chapter4/stack.html
  // Container https://book.flutterchina.club/chapter5/container.html
  // Column https://book.flutterchina.club/chapter4/row_and_column.html
  @override
  Widget build(BuildContext context) {
    // return Image(image: AssetImage(Utils.getImgPath('ic_launcher_news')));
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            alignment: Alignment.topCenter,
            child:
                // Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                // children: <Widget>[
                Image(
              fit: BoxFit.cover,
              height: 1280,
              image: AssetImage(Utils.getImgPath('nvshen')),
            ),
            // Card(
            //   elevation: 0,
            //   color: Colors.blue,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(48.0))),
            //   child: Card(
            //     elevation: 0,
            //     color: Colors.green,
            //     margin: EdgeInsets.all(2.0),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(48.0))),
            //     child: CircleAvatar(
            //       backgroundColor: Colors.transparent,
            //       backgroundImage:
            //       AssetImage(Utils.getImgPath('ic_launcher_news')),
            //       radius: 46.0,
            //     ),
            //   ),
            // ),
            // ],
            // ),
          )
        ],
      ),
    );
  }
}
