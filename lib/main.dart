import 'package:flutter/material.dart';
import 'package:gudang_kripto/pages/home.dart';
import 'package:gudang_kripto/provider/todo_provider.dart';
import 'package:gudang_kripto/pages/todo_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((value) {
    bool _isLoggedIn;

    String str = value.getString("user") ?? "";
    if (str.isEmpty) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TodoProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: _isLoggedIn ? TodoPage.routeName : HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => HomePage(),
            TodoPage.routeName: (context) => TodoPage(),
          },
        ),
      ),
    );
  });
}
