part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class ScheduleSubscriptionRequested extends ScheduleEvent {
  const ScheduleSubscriptionRequested();
}

class ScheduleJobCompletionToggled extends ScheduleEvent {
  const ScheduleJobCompletionToggled({
    required this.job,
    required this.isCompleted,
  });

  final Job job;
  final bool isCompleted;

  @override
  List<Object> get props => [job, isCompleted];
}

class ScheduleJobDeleted extends ScheduleEvent {
  const ScheduleJobDeleted(this.job);

  final Job job;

  @override
  List<Object> get props => [job];
}

class ScheduleUndoDeletionRequested extends ScheduleEvent {
  const ScheduleUndoDeletionRequested();
}

class ScheduleFilterChanged extends ScheduleEvent {
  const ScheduleFilterChanged(this.filter);

  final JobsViewFilter filter;

  @override
  List<Object> get props => [filter];
}

class ScheduleToggleAllRequested extends ScheduleEvent {
  const ScheduleToggleAllRequested();
}

class ScheduleClearCompletedRequested extends ScheduleEvent {
  const ScheduleClearCompletedRequested();
}
