import 'package:jobs_repository/jobs_repository.dart';

enum JobsViewFilter { all, activeOnly, completedOnly }

extension JobsViewFilterX on JobsViewFilter {
  bool apply(Job job) {
    switch (this) {
      case JobsViewFilter.all:
        return true;
      case JobsViewFilter.activeOnly:
        return !job.isCompleted;
      case JobsViewFilter.completedOnly:
        return job.isCompleted;
    }
  }

  Iterable<Job> applyAll(Iterable<Job> jobs) {
    return jobs.where(apply);
  }
}
