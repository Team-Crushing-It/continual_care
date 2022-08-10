part of 'schedule_bloc.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.jobs = const [],
    this.filter = JobsViewFilter.all,
    this.lastDeletedJob,
  });

  final ScheduleStatus status;
  final List<Job> jobs;
  final JobsViewFilter filter;
  final Job? lastDeletedJob;

  Iterable<Job> get filteredJobs => filter.applyAll(jobs);

  ScheduleState copyWith({
    ScheduleStatus Function()? status,
    List<Job> Function()? jobs,
    JobsViewFilter Function()? filter,
    Job? Function()? lastDeletedJob,
  }) {
    return ScheduleState(
      status: status != null ? status() : this.status,
      jobs: jobs != null ? jobs() : this.jobs,
      filter: filter != null ? filter() : this.filter,
      lastDeletedJob:
          lastDeletedJob != null ? lastDeletedJob() : this.lastDeletedJob,
    );
  }

  @override
  List<Object?> get props => [
        status,
        jobs,
        filter,
        lastDeletedJob,
      ];
}
