import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care/home/home.dart';
import 'package:continual_care/schedule/schedule.dart';

List<Page> onGenerateHomePages(
  HomeState state,
  List<Page<dynamic>> pages,
) {
  if (state.page == CurrentHomePage.schedule) {
    return [SchedulePage.page()];
  }

  return pages;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(
        key: ValueKey('home_page'),
        child: HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlowBuilder(
        onGeneratePages: onGenerateHomePages,
        state: context.select<HomeCubit, HomeState>(
          (cubit) => cubit.state,
        ),
      ),
    );
  }
}
