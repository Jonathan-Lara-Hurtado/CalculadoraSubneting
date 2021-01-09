import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AjustesScreen extends StatefulWidget {
  @override
  _AjustesScreenState createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  bool estadoDark = Get.isDarkMode ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
              title: Text('Dark Mode'),
              value: estadoDark,
              onChanged: (value) {
                setState(() {
                  estadoDark = value ? true : false;
                  if (estadoDark)
                    Get.changeTheme(ThemeData.dark());
                  else
                    Get.changeTheme(ThemeData.light());
                });
              })
        ],
      ),
    );
  }
}
