import 'package:flutter/material.dart';

class MeProfilePage extends StatefulWidget {
  const MeProfilePage({Key? key}) : super(key: key);

  @override
  _MeProfilePageState createState() => _MeProfilePageState();
}

class _MeProfilePageState extends State<MeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Title(color: Colors.white,title: "メロンけも", child: Container(color: Colors.lightGreenAccent,));
  }
}
