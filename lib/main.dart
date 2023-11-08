import 'package:covid_19/datasource/datasorce.dart';
import 'package:covid_19/home_page/screen/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Cicular', primaryColor: primaryBlack),
    home: const HomePage(),
  ));
}
