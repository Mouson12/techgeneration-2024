import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_app/features/application/users/models/user_ranking.dart';
import 'package:office_app/features/application/users/user_repository.dart';

part 'ranking_cubit_state.dart';

class RankingCubit extends Cubit<RankingCubitState> {
  RankingCubit() : super(RankingCubitInitial());

  void fetchRanking(int month) async {
    emit(RankingCubitLoading());

    UserRepository repository = UserRepository();
    UserRanking? ranking = await repository.getUserRanking(month);

    emit(RankingCubitLoaded(ranking));
  }
}
