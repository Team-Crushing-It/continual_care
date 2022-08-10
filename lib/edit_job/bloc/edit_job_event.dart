part of 'edit_job_bloc.dart';

abstract class EditJobEvent extends Equatable {
  const EditJobEvent();

  @override
  List<Object> get props => [];
}

class EditJobTitleChanged extends EditJobEvent {
  const EditJobTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class EditJobDescriptionChanged extends EditJobEvent {
  const EditJobDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class EditJobSubmitted extends EditJobEvent {
  const EditJobSubmitted();
}
