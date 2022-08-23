import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs_api/jobs_api.dart';
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
            pay: initialJob?.pay ?? 0,
            startTime: initialJob?.startTime ?? DateTime(1970),
            duration: initialJob?.duration ?? 0,
            location: initialJob?.location ?? '',
            coordinator: initialJob?.coordinator ?? User.empty,
            caregivers: initialJob?.caregivers ?? [],
            link: initialJob?.link ?? '',
            isCompleted: initialJob?.isCompleted ?? false,
          ),
        ) {
    on<EditJobPayChanged>(_onPayChanged);
    on<EditJobStartTimeChanged>(_onStartTimeChanged);
    on<EditJobDurationChanged>(_onDurationChanged);
    on<EditJobLocationChanged>(_onLocationChanged);
    on<EditJobCoordinatorChanged>(_onCoordinatorChanged);
    on<EditJobCaregiversChanged>(_onCaregiversChanged);
    on<EditJobLinkChanged>(_onLinkChanged);
    on<EditJobisCompletedChanged>(_onisCompletedChanged);
    on<EditJobSubmitted>(_onSubmitted);
  }

  final JobsRepository _jobsRepository;

  void _onPayChanged(
    EditJobPayChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(pay: event.pay));
  }

  void _onStartTimeChanged(
    EditJobStartTimeChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(startTime: event.startTime));
  }

  void _onDurationChanged(
    EditJobDurationChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onLocationChanged(
    EditJobLocationChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(location: event.location));
  }

  void _onCoordinatorChanged(
    EditJobCoordinatorChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(coordinator: event.coordinator));
  }

  void _onCaregiversChanged(
    EditJobCaregiversChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(caregivers: event.caregivers));
  }

  void _onLinkChanged(
    EditJobLinkChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(link: event.link));
  }

  void _onisCompletedChanged(
    EditJobisCompletedChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(isCompleted: event.isCompleted));
  }

  Future<void> _onSubmitted(
    EditJobSubmitted event,
    Emitter<EditJobState> emit,
  ) async {
    emit(state.copyWith(status: EditJobStatus.loading));
    final job = (state.initialJob ?? Job()).copyWith(
      pay: state.pay,
      startTime: state.startTime,
      location: state.location,
      coordinator: state.coordinator,
      caregivers: state.caregivers,
      link: state.link,
      isCompleted: state.isCompleted,
    );

    try {
      await _jobsRepository.saveJob(job);
      emit(state.copyWith(status: EditJobStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditJobStatus.failure));
    }
  }
}
