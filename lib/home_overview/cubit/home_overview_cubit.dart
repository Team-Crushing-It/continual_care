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

    /// here is where you would filter/sort for the next job
  
    print('get upcoming');

    final output = await repository.getJobs().first;

    print('finished await');

    print('output.first ${output.first}');
;
    emit(state.copyWith(job: output.first));
  }
}
