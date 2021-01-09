import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Get.isDarkMode ? Colors.black45 : Colors.grey[900],
            child: Container(
              padding: EdgeInsets.all(60),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(
                    image: AssetImage('assets/logo.png'),
                    height: 80.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Programmer: JALH',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          'Contact : larahurtadocorp@gmail.com',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
