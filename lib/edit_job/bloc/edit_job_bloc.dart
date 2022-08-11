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
            pay: initialJob?.pay ?? 0,
            dateTime: initialJob?.dateTime ?? DateTime(1970),
            location: initialJob?.location ?? '',
            caregiver: initialJob?.caregiver ?? '',
            link: initialJob?.link ?? '',
            isCompleted: initialJob?.isCompleted ?? false,
          ),
        ) {
    on<EditJobPayChanged>(_onPayChanged);
    on<EditJobDateTimeChanged>(_onDateTimeChanged);
    on<EditJobLocationChanged>(_onLocationChanged);
    on<EditJobCaregiverChanged>(_onCaregiverChanged);
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

  void _onDateTimeChanged(
    EditJobDateTimeChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(dateTime: event.dateTime));
  }

  void _onLocationChanged(
    EditJobLocationChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(location: event.location));
  }

  void _onCaregiverChanged(
    EditJobCaregiverChanged event,
    Emitter<EditJobState> emit,
  ) {
    emit(state.copyWith(caregiver: event.caregiver));
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
      dateTime: state.dateTime,
      location: state.location,
      caregiver: state.caregiver,
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
