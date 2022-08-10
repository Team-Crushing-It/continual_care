import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_repository/jobs_repository.dart';

part 'edit_job_event.dart';
part 'edit_job_state.dart';

class EditJobBloc extends Bloc<EditJobEvent, EditJobState> {
  EditJobBloc({
    required JobsRepository jobsRepository,
    required Job? initialJob,
  })  : _jobsRepository = jobsRepository,
        super(
          EditJobState(
            initialJob: initialJob,
            title: initialJob?.title ?? '',
            description: initialJob?.description ?? '',
          ),
        ) {
    on<EditJobTitleChanged>(_onTitleChanged);
    on<EditJobDescriptionChanged>(_onDescriptionChanged);
    on<EditJobSubmitted>(_onSubmitted);
  }

  final JobsRepository _jobsRepository;

  void _onTitleChanged(
    EditJobTitleChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    EditJobDescriptionChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    EditJobSubmitted event,
    Emitter<EditJobState> emit,
  ) async {
    emit(state.copyWith(status: EditJobStatus.loading));
    final job = (state.initialJob ?? Job(title: '')).copyWith(
      title: state.title,
      description: state.description,
    );

    try {
      await _jobsRepository.saveJob(job);
      emit(state.copyWith(status: EditJobStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditJobStatus.failure));
    }
  }
}
