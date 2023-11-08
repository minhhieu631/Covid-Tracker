import 'package:equatable/src/equatable.dart';
import 'package:covid_19/model/country_model.dart';


enum BlocStatusEnum { init, loading, success, failed }

class CountryState extends Equatable {
  final BlocStatusEnum? status;
  final List<CountryModel>? listCountry;

  final String? mesErr;

  const CountryState({this.status, this.listCountry, this.mesErr});

  @override
  List<Object?> get props => [status, listCountry, mesErr];

  CountryState copyWith({
    BlocStatusEnum? status,
    List<CountryModel>? listCountry,
    String? mesErr,
  }) {
    return CountryState(
      status: status ?? this.status,
      listCountry: listCountry ?? this.listCountry,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
