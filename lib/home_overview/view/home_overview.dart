import 'package:continual_care/home_overview/cubit/home_overview_cubit.dart';
import 'package:continual_care/home_overview/home_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_repository/jobs_repository.dart';

import '../../schedule/widgets/job_list_tile.dart';

class HomeOverviewPage extends StatelessWidget {
  const HomeOverviewPage({Key? key}) : super(key: key);

  static Page page() => const SlideRightPage<void>(
        key: ValueKey('home_overview_page'),
        child: HomeOverviewPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomeOverviewCubit(repository: context.read<JobsRepository>())
              ..getUpcoming(),
        child: HomeOverviewView());
  }
}

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Overview'),
        ),
        body: BlocBuilder<HomeOverviewCubit, HomeOverviewState>(
          builder: (context, state) {
            return Column(
              children: [
                if (state.job != null)
                  JobListTile(job: state.job!)
                else
                  Text("NO upcomming jobs")
              ],
            );
          },
        ));
  }
}
