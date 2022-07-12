import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care/app/app.dart';
import 'package:continual_care/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int groupIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      backgroundColor: Color(0xff2A3066),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 18, top: 16, bottom: 16),
          child: const Text(
            'Gene Yllanes',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 18,
            ),
            child: IconButton(
                key: const Key('homePage_logout_iconButton'),
                icon: Image.asset(
                  "assets/settings_icon.png",
                  width: 35,
                  height: 35,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Logout ?"),
                            content: Text("Do you accept?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No")),
                              TextButton(
                                  onPressed: () {
                                    context
                                        .read<AppBloc>()
                                        .add(AppLogoutRequested());
                                    Navigator.pop(context);
                                  },
                                  child: Text("Yes"))
                            ],
                          ));
                }),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          BottomNavigationBarItem(
            groupIndex: groupIndex,
            title: "Home",
            iconPath: "assets/home_icon.png",
            index: 0,
            onSelected: (index) {
              setState(() {
                groupIndex = index;
              });
              print(groupIndex);
            },
          ),
          BottomNavigationBarItem(
            groupIndex: groupIndex,
            title: "Messages",
            iconPath: "assets/messages_icon.png",
            index: 1,
            onSelected: (index) {
              setState(() {
                groupIndex = index;
              });
              print("here is the group index : " + groupIndex.toString());
            },
          ),
          BottomNavigationBarItem(
            titleColor: Colors.white,
            activeColor: Color.fromARGB(143, 208, 4, 4),
            inactiveColor: Color(0xffD00404),
            groupIndex: groupIndex,
            title: "Alert",
            iconPath: "assets/warning_icon.png",
            index: 2,
            onSelected: (index) {
              setState(() {
                groupIndex = index;
              });
              print("here is the group index : " + groupIndex.toString());
            },
          )
        ],
      ),
    );
  }
}

class BottomNavigationBarItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final int index;
  final Color activeColor;
  final Color inactiveColor;
  final Color titleColor;
  int groupIndex;
  final Function(int index) onSelected;
  BottomNavigationBarItem({
    this.titleColor = const Color(0xff2A3066),
    this.activeColor = const Color(0xff7895A1),
    this.inactiveColor = const Color(0xffCCCCCC),
    required this.groupIndex,
    required this.index,
    required this.onSelected,
    required this.iconPath,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: groupIndex == index ? activeColor : inactiveColor,
        height: 64,
        child: InkWell(
          onTap: () {
            onSelected(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 35,
                height: 35,
              ),
              Text(
                title,
                style: TextStyle(color: titleColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
