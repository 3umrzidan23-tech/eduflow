import 'package:equatable/equatable.dart';
import '../../data/models/home_data.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeData data;

  const HomeLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
