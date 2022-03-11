import 'package:continual_care/init/view.dart/init.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(5, 11, 44, .1),
  100: const Color.fromRGBO(5, 11, 44, .2),
  200: const Color.fromRGBO(5, 11, 44, .3),
  300: const Color.fromRGBO(5, 11, 44, .4),
  400: const Color.fromRGBO(5, 11, 44, .5),
  500: const Color.fromRGBO(5, 11, 44, .6),
  600: const Color.fromRGBO(5, 11, 44, .7),
  700: const Color.fromRGBO(5, 11, 44, .8),
  800: const Color.fromRGBO(5, 11, 44, .9),
  900: const Color.fromRGBO(5, 11, 44, 1),
};

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xffA5B9C1),
          primarySwatch: MaterialColor(0xff050B2C, color),
        ),
      ),
      home: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'I would like to:';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Init(),
      ),
    );
  }
}

//=====================================================================

class FadeInLogo extends StatelessWidget {
  const FadeInLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Center(child: CircularProgressIndicator()),
        Center(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: 'assets/logo_dark_clean.png',
          ),
        ),
      ],
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
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'assets/logo_dark_clean.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
