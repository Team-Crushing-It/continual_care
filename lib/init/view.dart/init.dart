import 'package:continual_care/profile_flow/profile_flow.dart';
import 'package:flutter/material.dart';

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      primary: Colors.black,
      textStyle: const TextStyle(fontSize: 16),
      fixedSize: Size.fromWidth(200),
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: style,
              onPressed: () {},
              child: const Text('Find a caregiver'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: style,
              onPressed: () async {
                final profile = await Navigator.of(context).push(
                  ProfileFlow.route(),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Profile Flow Complete!\n$profile'),
                    ),
                  );
              },
              child: const Text('Find a job'),
            ),
          ),
        ],
      ),
    );
  }
}
