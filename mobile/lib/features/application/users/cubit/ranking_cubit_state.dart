part of 'ranking_cubit.dart';

abstract class RankingCubitState {}

final class RankingCubitInitial extends RankingCubitState {}

final class RankingCubitLoading extends RankingCubitState {
  UserRanking? ranking;
  RankingCubitLoading({this.ranking});
}

final class RankingCubitLoaded extends RankingCubitState {
  UserRanking? ranking;

  RankingCubitLoaded(this.ranking);
}
