import 'dart:convert';
import 'package:covid_19/panels/pages/country_screen/bloc/country_event.dart';
import 'package:covid_19/panels/pages/country_screen/bloc/country_state.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/src/bloc_builder.dart';
import '../bloc/country_bloc.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
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
          title: const Text('CÁC QUỐC GIA TRÊN THẾ GIỚI'),
          backgroundColor: Colors.black54,
        ),
        body: BlocProvider(
          create: (context) => CountryBloc()..add(InitCountry()),
          child: BlocBuilder<CountryBloc, CountryState>(
            builder: (context, state) {
              final products = state.listCountry ?? [];
              if (state.status == BlocStatusEnum.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (products.isEmpty) {
                return const Center(
                  child: Text("Không có sản phẩm nào!"),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].country ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Image.network(
                                  products[index].countryInfo?.flag ?? '',///'' gan gia tri khi null,gan gia tri dung voi kieu du lieu
                                  height: 40,
                                  width: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Text(
                                  'SỐ CA NHIỄM ' '${products[index].cases}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  'ĐANG PHỤC HỒI ' '${products[index].active}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Text(
                                  'ĐÃ KHỎI BỆNH ' '${products[index].recovered}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Text(
                                  'TỬ VONG ' '${products[index].deaths}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ))
                      ],
                    ),
                  );
                },
                itemCount: products.length,
              );
            },
          ),
        ));
  }
}
