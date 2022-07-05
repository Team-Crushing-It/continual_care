import 'package:flutter/widgets.dart';
import 'package:continual_care/app/app.dart';
import 'package:continual_care/home/home.dart';
import 'package:continual_care/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
