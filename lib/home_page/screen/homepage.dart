import 'dart:convert';

import 'package:covid_19/datasource/datasorce.dart';
import 'package:covid_19/panels/infopanel/screen/infopanel.dart';
import 'package:covid_19/panels/most_country/screen/mosteffectedcountries.dart';
import 'package:covid_19/panels/pages/country_screen/screen/countrypage.dart';
import 'package:covid_19/panels/worldwidepanel/screen/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List countryData = [];

  fetCountryData() async {
    http.Response response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: const Text('THÔNG TIN VỀ COVID-19'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            padding: const EdgeInsets.all(10),
            color: Colors.orange[100],
            child: Text(DataSource.quote,
                style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  ' VIỆT NAM',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CountryPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Quốc Gia Khác',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const WorldwidePanel(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'THỐNG KÊ TẠI MỘT SỐ QUỐC GIA KHÁC',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          countryData == null
              ? Container()
              : MosteffectedPanel(
                  countryData: countryData,
                ),
          const InfoPanel(),
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'CHÚNG TA CÙNG NHAU VƯỢT QUA',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          const SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}
