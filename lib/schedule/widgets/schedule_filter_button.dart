import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care/schedule/schedule.dart';

class ScheduleFilterButton extends StatelessWidget {
  const ScheduleFilterButton({super.key});

  @override
  Widget build(BuildContext context) {

    final activeFilter =
        context.select((ScheduleBloc bloc) => bloc.state.filter);

    return PopupMenuButton<JobsViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: 'l10n.jobsOverviewFilterTooltip,',
      onSelected: (filter) {
        context
            .read<ScheduleBloc>()
            .add(ScheduleFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: JobsViewFilter.all,
            child: Text('l10n.jobsOverviewFilterAll'),
          ),
          PopupMenuItem(
            value: JobsViewFilter.activeOnly,
            child: Text('l10n.jobsOverviewFilterActiveOnly'),
          ),
          PopupMenuItem(
            value: JobsViewFilter.completedOnly,
            child: Text('l10n.jobsOverviewFilterCompletedOnly'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
