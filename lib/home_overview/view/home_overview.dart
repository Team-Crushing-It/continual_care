import 'package:continual_care/home_overview/cubit/home_overview_cubit.dart';
import 'package:continual_care/home_overview/home_overview.dart';
import 'package:continual_care/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_repository/jobs_repository.dart';

class HomeOverviewPage extends StatelessWidget {
  const HomeOverviewPage({Key? key}) : super(key: key);

  static Page page() => const SlideRightPage<void>(
        key: ValueKey('home_overview_page'),
        child: HomeOverviewPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeOverviewCubit(
        repository: context.read<JobsRepository>(),
        job: Job(),
      )..getUpcoming(),
      child: const HomeOverviewView(),
    );
  }
}

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final upcomingJob = context.read<HomeOverviewCubit>().state.job!;
    return Scaffold(
      body: Column(
        children: [
          JobListTile(job: upcomingJob)
        ],
      ),
    );
  }
}
