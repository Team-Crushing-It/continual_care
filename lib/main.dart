import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashLogo(),
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const title = 'Site Build In Progress';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff1E4F63),
          width: 15,
        ),
      ),
      child: MaterialApp(
        title: title,
        home: Scaffold(
          backgroundColor: const Color(0xff050B2C),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xff050B2C),
            title: const Text(title),
          ),
          body: Stack(
            children: <Widget>[
              const Center(child: CircularProgressIndicator()),
              Center(
                child: Image.asset('assets/logo_dark_clean.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
