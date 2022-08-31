part of 'home_overview_cubit.dart';

class HomeOverviewState extends Equatable {
  const HomeOverviewState({
    this.job,
  });

  final Job? job;

  HomeOverviewState copyWith({
    Job? job,
  }) {
    return HomeOverviewState(
      job: job ?? this.job,
    );
  }

  @override
  List<Object?> get props => [job];
}
