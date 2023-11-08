import 'dart:convert';
import 'dart:developer';

import 'package:covid_19/home_page/home_page_screen/bloc/home_page_event.dart';
import 'package:covid_19/model/home_page_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageModel? homePageModel;

  HomePageBloc() : super(const HomePageState()) {
    on<InitHomePage>((event, emit) async {
      emit(state.copyWith(status: BlocStatusEnum.loading));

      http.Response response = await http
          .get(Uri.parse('https://disease.sh/v3/covid-19/countries/vietnam'));

      final json = jsonDecode(response.body);

      if (json != null) {
        homePageModel = HomePageModel.fromJson(json);
      } else {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
        ));
      }

      emit(state.copyWith(
          status: BlocStatusEnum.success, homePageModel: homePageModel));
    });

    on<Click>((event, emit) async {
      log('alo');
    });
  }
}

