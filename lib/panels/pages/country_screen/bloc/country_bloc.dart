import 'dart:convert';

import 'package:covid_19/model/country_model.dart';
import 'package:covid_19/panels/pages/country_screen/bloc/country_event.dart';
import 'package:covid_19/panels/pages/country_screen/bloc/country_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;



class CountryBloc extends Bloc<CountryEvent, CountryState> {
  List<CountryModel>? countryModel = [];

  CountryBloc() : super(const CountryState()) {
    on<InitCountry>((event, emit) async {
      emit(state.copyWith(status: BlocStatusEnum.loading));

      http.Response response =
      await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

      final json = jsonDecode(response.body);
      if (json != null) {
        final a = json.map<CountryModel>((e) {
          return CountryModel.fromJson(e); /// map dữ liệu từ json trả về theo key
        }).toList() as List<CountryModel>;
        countryModel?.addAll(a);
      }

      emit(state.copyWith(
          status: BlocStatusEnum.success, listCountry: countryModel));
    });
  }
}
