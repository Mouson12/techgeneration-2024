part of 'alarm_cubit.dart';

abstract class AlarmState {}

class AlarmInitial extends AlarmState {}

class AlarmLoading extends AlarmState {}

class AlarmLoaded extends AlarmState {
  final AlertModel alert;

  AlarmLoaded(this.alert);
}

class AlarmError extends AlarmState {
  final String message;

  AlarmError(this.message);
}
