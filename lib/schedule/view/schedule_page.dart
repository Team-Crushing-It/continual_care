import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care/edit_job/view/edit_job_page.dart';
import 'package:continual_care/schedule/schedule.dart';
import 'package:jobs_repository/jobs_repository.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(
        key: ValueKey('schedule_page'),
        child: SchedulePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(
        jobsRepository: context.read<JobsRepository>(),
      )..add(const ScheduleSubscriptionRequested()),
      child: const ScheduleView(),
    );
  }
}

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        actions: const [
          ScheduleFilterButton(),
          ScheduleOptionsButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(EditJobPage.route());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ScheduleBloc, ScheduleState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ScheduleStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('l10n.jobsOverviewErrorSnackbarText'),
                    ),
                  );
              }
            },
          ),
          BlocListener<ScheduleBloc, ScheduleState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedJob != current.lastDeletedJob &&
                current.lastDeletedJob != null,
            listener: (context, state) {
              final deletedJob = state.lastDeletedJob!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(' l10n.jobsOverviewJobDeletedSnackbarText'),
                    action: SnackBarAction(
                      label: 'l10n.jobsOverviewUndoDeletionButtonText,',
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<ScheduleBloc>()
                            .add(const ScheduleUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state.jobs.isEmpty) {
              if (state.status == ScheduleStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != ScheduleStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    ' l10n.jobsOverviewEmptyText,',
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final job in state.filteredJobs)
                    JobListTile(
                      job: job,
                      onToggleCompleted: (isCompleted) {
                        context.read<ScheduleBloc>().add(
                              ScheduleJobCompletionToggled(
                                job: job,
                                isCompleted: isCompleted,
                              ),
                            );
                      },
                      onDismissed: (_) {
                        context
                            .read<ScheduleBloc>()
                            .add(ScheduleJobDeleted(job));
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          EditJobPage.route(initialJob: job),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}