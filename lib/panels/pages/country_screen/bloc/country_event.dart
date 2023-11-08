import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class InitCountry extends CountryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
