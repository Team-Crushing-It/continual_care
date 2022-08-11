part of 'edit_job_bloc.dart';

abstract class EditJobEvent extends Equatable {
  const EditJobEvent();

  @override
  List<Object> get props => [];
}

class EditJobPayChanged extends EditJobEvent {
  const EditJobPayChanged(this.pay);

  final double pay;

  @override
  List<Object> get props => [pay];
}

class EditJobDateTimeChanged extends EditJobEvent {
  const EditJobDateTimeChanged(this.dateTime);

  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class EditJobLocationChanged extends EditJobEvent {
  const EditJobLocationChanged(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class EditJobCaregiverChanged extends EditJobEvent {
  const EditJobCaregiverChanged(this.caregiver);

  final String caregiver;

  @override
  List<Object> get props => [caregiver];
}

class EditJobLinkChanged extends EditJobEvent {
  const EditJobLinkChanged(this.link);

  final String link;

  @override
  List<Object> get props => [link];
}

class EditJobisCompletedChanged extends EditJobEvent {
  const EditJobisCompletedChanged(this.isCompleted);

  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

class EditJobSubmitted extends EditJobEvent {
  const EditJobSubmitted();
}
