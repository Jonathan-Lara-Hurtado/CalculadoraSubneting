import 'dart:ffi';

import 'package:calculadora_de_redes/admob/ad_manager.dart';
import 'package:calculadora_de_redes/screens/conversorscreen.dart';
import 'package:calculadora_de_redes/screens/maskscreen.dart';
import 'package:calculadora_de_redes/screens/menudrawer.dart';
import 'package:calculadora_de_redes/screens/subnetcalculatorscreen.dart';
import 'package:calculadora_de_redes/screens/vlsmscreen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('IPv4 Calculator'),
            bottom: TabBar(
              tabs: [
                Container(
                  child: Tab(
                    text: 'SUBNET CALCULATOR',
                  ),
                ),
                Container(
                  child: Tab(
                    text: 'CONVERTER',
                  ),
                ),
//                Container(
                //                child: Tab(text: 'VLSM CALCULATOR'),
                //            ),
                Container(
                  child: Tab(text: 'CONVERTER MASK'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CalculatorSubnetScreen(),
              ConversorScreen(),
              //VlsmScreen(),
              MascaraScreen(),
            ],
          ),
          drawer: SafeArea(
            child: MenuDrawer(),
          ),
        ));
  }
}
