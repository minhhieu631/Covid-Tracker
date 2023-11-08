import 'package:covid_19/model/home_page_model.dart';
import 'package:equatable/src/equatable.dart';
import 'package:covid_19/model/country_model.dart';

enum BlocStatusEnum { init, loading, success, failed }

class HomePageState extends Equatable {
  final BlocStatusEnum? status; // thuộc tính
  final HomePageModel? homePageModel;

  final String? mesErr;

  const HomePageState({this.status, this.homePageModel, this.mesErr});// constructor

  @override
  List<Object?> get props => [status, homePageModel, mesErr];

  HomePageState copyWith({
    BlocStatusEnum? status,
    HomePageModel? homePageModel,
    String? mesErr,
  }) {
    return HomePageState(
      status: status ?? this.status,
      homePageModel: homePageModel ?? this.homePageModel,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
