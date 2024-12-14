part of 'medication_cubit.dart';

abstract class MedicationState {}

final class MedicationInitial extends MedicationState {}

final class MedicationLoading extends MedicationState {}

final class MedicationLoaded extends MedicationState {
  final MedicationModel medication;

  MedicationLoaded(this.medication);
}

final class MedicationError extends MedicationState {
  final String message;

  MedicationError(this.message);
}
