import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class InitHomePage extends HomePageEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Click extends HomePageEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
