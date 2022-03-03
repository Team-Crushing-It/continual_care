import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
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
