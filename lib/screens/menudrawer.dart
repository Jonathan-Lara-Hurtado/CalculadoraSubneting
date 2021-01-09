import 'package:calculadora_de_redes/screens/acercadescreen.dart';
import 'package:calculadora_de_redes/screens/ajustesscreen.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjustesScreen()),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            leading: Icon(Icons.help),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AcercaDe()));
            },
          ),
        ],
      ),
    );
  }
}
