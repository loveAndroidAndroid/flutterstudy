import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwanandroid/common/comon.dart';
import 'package:flutterwanandroid/common/user.dart';
import 'package:flutterwanandroid/components/ToastUtil.dart';
import 'package:flutterwanandroid/data/api/ApiService.dart';
import 'package:flutterwanandroid/data/model/UserModel.dart';
import 'package:flutterwanandroid/ui/HomeScreen.dart';
import 'package:flutterwanandroid/utils/loading_dialog.dart';
import 'package:flutterwanandroid/utils/print_long.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'SplashScreen.dart';

/// 登录页面
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _psdController = TextEditingController();

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _psdFocusNode = FocusNode();

  Future _login(String username, String password) async {
    if ((null != username && username.length > 0) &&
        (null != password && password.length > 0)) {
      _showLoading(context, "正在登陆...");
      apiService.login((UserModel model, Response response) {
        _dismissLoading(context);
        if (null != model) {
          printLong(model.errorMsg);
          if (model.errorCode == Constants.STATUS_SUCCESS) {
            User().saveUserInfo(model, response);
            ToastUtil.show(msg: "登录成功");
            LoginClick();
          } else {
            ToastUtil.show(msg: model.errorMsg);
          }
        }
      }, (DioError error) {
        _dismissLoading(context);
        print(error.response);
      }, username, password);
    } else {
      ToastUtil.show(msg: "用户名或密码不能为空");
    }
  }

  Future _register(String username, String password) async {
    if ((null != username && username.length > 0) &&
        (null != password && password.length > 0)) {
      _showLoading(context, "正在注册...");
      apiService.register((UserModel _userModel) {
        _dismissLoading(context);
        if (_userModel != null) {
          if (_userModel.errorCode == 0) {
            ToastUtil.show(msg: "注册成功！");
          } else {
            ToastUtil.show(msg: _userModel.errorMsg);
          }
        }
      }, (DioError error) {
        _dismissLoading(context);
        print(error.response);
      }, username, password);
    } else {
      ToastUtil.show(msg: "用户名或密码不能为空");
    }
  }

  @override
  void initState() {
    // Configure keyboard actions
    // FormKeyboardActions.setKeyboardActions(context, _buildConfig(context));
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _userNameFocusNode,
        ),
        KeyboardAction(
          focusNode: _psdFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          ),
        ),
      ],
    );
  }

  /// 显示Loading
  _showLoading(BuildContext context, loadingText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new LoadingDialog(
            outsideDismiss: false,
            loadingText: loadingText,
          );
        });
  }

  /// 隐藏Loading
  _dismissLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0.4,
            title: Text("登录注册界面"),
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "用户登录与注册界面",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "完成注册和登录后方可使用本App",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: TextField(
                        focusNode: _userNameFocusNode,
                        autofocus: false,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "请输入您的用户名",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: TextField(
                        focusNode: _psdFocusNode,
                        controller: _psdController,
                        decoration: InputDecoration(
                          labelText: "密码",
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "请输入您的密码",
                        ),
                        obscureText: true,
                        maxLines: 1,
                      ),
                    ),

                    // 登录按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(16.0),
                              elevation: 0.5,
                              child: Text("登录"),
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () {
                                String username = _userNameController.text;
                                String password = _psdController.text;
                                _login(username, password);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 注册按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(16.0),
                              elevation: 0.5,
                              child: Text("注册"),
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () {
                                String username = _userNameController.text;
                                String password = _psdController.text;
                                _register(username, password);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text("", style: TextStyle(fontSize: 14)),
                          onPressed: () {},
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void LoginClick() async {
    await Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => route == null);
  }
}
