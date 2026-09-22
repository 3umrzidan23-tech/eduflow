import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit({HomeRepository? homeRepository})
      : _homeRepository = homeRepository ?? HomeRepositoryImpl(),
        super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final data = await _homeRepository.getHomeData();
      emit(HomeLoaded(data: data));
    } catch (e) {
      emit(HomeFailure(message: 'Failed to load home data: ${e.toString()}'));
    }
  }
}
