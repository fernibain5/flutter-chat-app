import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';

import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  UsersPage.routeName: (_) => UsersPage(),
  ChatPage.routeName: (_) => ChatPage(),
  LoadingPage.routeName: (_) => LoadingPage(),
  RegisterPage.routeName: (_) => RegisterPage(),
  LoginPage.routeName: (_) => LoginPage(),
};
