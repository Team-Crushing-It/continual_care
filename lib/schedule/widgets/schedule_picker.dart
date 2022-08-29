import 'package:continual_care/schedule/widgets/week_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/schedule_bloc.dart';
import '../models/models.dart';

class SchedulePicker extends StatefulWidget {
  const SchedulePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<SchedulePicker> createState() => _SchedulePickerState();
}

class _SchedulePickerState extends State<SchedulePicker> {
  late List<dynamic> weeks;
  late List<bool> tilesState;
  late ScrollController _controller;

  @override
  void initState() {
    weeks = WeeksGenerator(
            startTime: DateTime.now().subtract(Duration(days: 182)),
            endTime: DateTime.now().add(Duration(days: 182)))
        .generate();
    tilesState = List.generate(weeks.length, (index) => false);

    _controller = ScrollController(initialScrollOffset: 1056);

//  WidgetsBinding.instance
//         .addPostFrameCallback((_) => animateToTile(1000));
//     super.initState();
  }

  animateToTile(double pozish) {
    print('onScrolld $pozish');
    _controller.animateTo(pozish,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Color(0xffF6E7E7),
      child: ListView.builder(
        controller: _controller,
        itemExtent: 33,
        itemCount: weeks.length,
        itemBuilder: ((context, index) {

          
          if (weeks[index] is List) {
            tilesState.add(false);
            WeekListTile tile = WeekListTile(
              isActive: tilesState[index],
              index: index,
              text: weeks[index][0].day.toString() +
                  " - " +
                  weeks[index][1].day.toString(),
              onPressed: () {
                animateToTile(index*33);
                context.read<ScheduleBloc>().add(
                    ScheduleFilterChanged(weeks[index][0], weeks[index][1]));

                setState(() {
                  tilesState = tilesState.map((e) => false).toList();
                  tilesState[index] = true;
                });
              },
            );
            return tile;
          } else {
            return WeekListTile(
              text: weeks[index],
              onPressed: () {},
              isActive: false,
              isTitle: true,
            );
          }
        }),
      ),
    );
  }
}
