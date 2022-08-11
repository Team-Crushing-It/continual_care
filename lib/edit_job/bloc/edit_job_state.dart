part of 'edit_job_bloc.dart';

enum EditJobStatus { initial, loading, success, failure }

extension EditJobStatusX on EditJobStatus {
  bool get isLoadingOrSuccess => [
        EditJobStatus.loading,
        EditJobStatus.success,
      ].contains(this);
}

class EditJobState extends Equatable {
  EditJobState({
    this.status = EditJobStatus.initial,
    this.initialJob,
    this.pay = 0,
    DateTime? dateTime,
    this.location = '',
    this.caregiver = '',
    this.link = '',
    this.isCompleted = false,
  }) : this.dateTime = dateTime ?? DateTime(1970);

  final EditJobStatus status;
  final Job? initialJob;
  final double pay;
  final DateTime dateTime;
  final String location;
  final String caregiver;
  final String link;
  final bool isCompleted;

  bool get isNewJob => initialJob == null;

  EditJobState copyWith({
    EditJobStatus? status,
    Job? initialJob,
    double? pay,
    DateTime? dateTime,
    String? location,
    String? caregiver,
    String? link,
    bool? isCompleted,
  }) {
    return EditJobState(
      status: status ?? this.status,
      initialJob: initialJob ?? this.initialJob,
      pay: pay ?? this.pay,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      caregiver: caregiver ?? this.caregiver,
      link: link ?? this.link,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props =>
      [status, initialJob, pay, dateTime, location, caregiver, link];
}
