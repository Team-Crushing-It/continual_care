import 'package:continual_care/home_overview/home_overview.dart';
import 'package:flutter/material.dart';


class HomeOverviewPage extends StatelessWidget {
  const HomeOverviewPage({Key? key}) : super(key: key);

  static Page page() => const SlideRightPage<void>(
        key: ValueKey('home_overview_page'),
        child: HomeOverviewPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Overview'),
        ),
        body: Text('homeoverview'));
  }
}
