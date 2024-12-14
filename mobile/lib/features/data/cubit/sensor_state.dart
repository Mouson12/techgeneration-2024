part of 'sensor_cubit.dart';

abstract class SensorState {}

final class SensorInitial extends SensorState {}

final class SensorLoading extends SensorState {}

final class SensorLoaded extends SensorState {
  final Map<String, SensorModel> sensors;

  SensorLoaded(this.sensors);
}

final class SensorError extends SensorState {
  final String message;

  SensorError(this.message);
}
