part of 'edit_job_bloc.dart';

enum EditJobStatus { initial, loading, success, failure }

extension EditJobStatusX on EditJobStatus {
  bool get isLoadingOrSuccess => [
        EditJobStatus.loading,
        EditJobStatus.success,
      ].contains(this);
}

class EditJobState extends Equatable {
  const EditJobState({
    this.status = EditJobStatus.initial,
    this.initialJob,
    this.title = '',
    this.description = '',
  });

  final EditJobStatus status;
  final Job? initialJob;
  final String title;
  final String description;

  bool get isNewJob => initialJob == null;

  EditJobState copyWith({
    EditJobStatus? status,
    Job? initialJob,
    String? title,
    String? description,
  }) {
    return EditJobState(
      status: status ?? this.status,
      initialJob: initialJob ?? this.initialJob,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialJob, title, description];
}
