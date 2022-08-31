import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'home_overview_state.dart';

class HomeOverviewCubit extends Cubit<HomeOverviewState> {
  HomeOverviewCubit({
    required this.repository,
    required Job? job,
  }) : super(HomeOverviewState(job: job));

  final JobsRepository repository;

  void getUpcoming() async {
    // final output = await repository.getJobs().first;

    final output2 = Job(id: 'new', location: 'updated Jooooooooob');

    emit(state.copyWith(job: output2));
  }
}
