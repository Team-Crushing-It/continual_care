import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care/edit_job/edit_job.dart';
import 'package:jobs_repository/jobs_repository.dart';

class EditJobPage extends StatelessWidget {
  const EditJobPage({super.key});

  static Route<void> route({Job? initialJob}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditJobBloc(
          jobsRepository: context.read<JobsRepository>(),
          initialJob: initialJob,
        ),
        child: const EditJobPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditJobBloc, EditJobState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditJobStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditJobView(),
    );
  }
}

class EditJobView extends StatelessWidget {
  const EditJobView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditJobBloc bloc) => bloc.state.status);
    final isNewJob = context.select(
      (EditJobBloc bloc) => bloc.state.isNewJob,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewJob
              ? 'l10n.editJobAddAppBarTitle'
              : 'l10n.editJobEditAppBarTitle',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'l10n.editJobSaveButtonTooltip',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: status.isLoadingOrSuccess
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<EditJobBloc>().add(const EditJobSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                _PayField(),
                _LocationField(),
                _CaregiverField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PayField extends StatelessWidget {
  const _PayField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.pay ?? 0;

    return TextFormField(
      key: const Key('editJobView_pay_textFormField'),
      initialValue: state.pay.toString(),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'pay',
        hintText: hintText.toString(),
      ),
      keyboardType: TextInputType.number,
      maxLength: 50,
      onChanged: (value) {
        value.characters.length > 0
            ? context
                .read<EditJobBloc>()
                .add(EditJobPayChanged(double.parse(value)))
            : null;
      },
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.location ?? '';

    return TextFormField(
      key: const Key('editJobView_location_textFormField'),
      initialValue: state.location,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'location',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditJobBloc>().add(EditJobLocationChanged(value));
      },
    );
  }
}

class _CaregiverField extends StatelessWidget {
  const _CaregiverField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.caregivers ?? '';

    return TextFormField(
      key: const Key('editJobView_caregiver_textFormField'),
      // initialValue: state.caregivers,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'l10n.editJobDescriptionLabel',
        hintText: 'hintText',
      ),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        // context.read<EditJobBloc>().add(EditJobCaregiverChanged(value));
      },
    );
  }
}
