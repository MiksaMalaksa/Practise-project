import 'package:dead_notes/features/Deadline/presentation/blocs/deadline_bloc.dart';
import 'package:dead_notes/features/Deadline/presentation/view/deadline_page.dart';
import 'package:dead_notes/features/Home/presentation/bloc/home_bloc.dart';
import 'package:dead_notes/features/injection.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final DeadlineBloc _bloc = sl.get<DeadlineBloc>();

  @override
  void initState() {
    _bloc.add(const GetDeadlinesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeadlineBloc, DeadlineState>(
      bloc: _bloc,
      builder: (context, state) {
        int finishedInTime = 0;
        int failed = 0;
        int successRate = 0;
        int avDays = 0;
        if (state is Loaded) {
          finishedInTime = state.deadlines.where((e) => e.finishTime != null && e.deadlineTime.compareTo(e.finishTime!) >= 0).toList().length;
          failed = state.deadlines.where((e) => (e.finishTime != null && e.deadlineTime.compareTo(e.finishTime!) < 0) || (e.tasks.where((t) => !t.isDone).isNotEmpty && e.deadlineTime.compareTo(DateTime.now()) < 0)).toList().length;
          successRate = finishedInTime > 0 ? (finishedInTime/(finishedInTime + failed) * 100).round() : 0;
          List<int> days = [];
          for (int i = 0; i < state.deadlines.length; i++) {
            if (state.deadlines[i].finishTime != null) {
              days.add(state.deadlines[i].finishTime!.difference(state.deadlines[i].creationTime).inDays);
            }
          }
          if (days.isNotEmpty) avDays = (days.reduce((a, b) => a + b) / days.length).round();
        }

        return Scaffold(
          appBar: TopBar(title: homeLocalize(context),),
          body: (state is Loaded) ? ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(overviewLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
              ),
              GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(10),
                physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
                childAspectRatio: 1.3,
                children: [
                  _overviewItem(finishedInTime.toString(), finishedInTimeLocalize(context)),
                  _overviewItem(failed.toString(), deadlinesFailedLocalize(context)),
                  _overviewItem('$successRate%', successRateLocalize(context)),
                  _overviewItem('$avDays ${daysLocalize(context).toLowerCase()}', averageTimeLocalize(context)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(pinnedLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
                    const SizedBox(width: 10,),
                    DesignedIcon(assetPath: 'assets/pin.png', size: 15, color: Theme.of(context).colorScheme.secondary,),
                  ],
                )
              ),
              ...List.generate(state.deadlines.length, (index) {
                if (!state.deadlines[index].isFavorite) return Container();
                double percentage = (state.deadlines[index].tasks.where((e) => e.isDone).toList().length / state.deadlines[index].tasks.length) * 100;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeadlinePage(deadline: state.deadlines[index],))).then((value) => _bloc.add(const GetDeadlinesEvent()));
                  },
                  child: _pinnedItem(value: state.deadlines[index].title, percentage: percentage, dateTime: state.deadlines[index].deadlineTime, color: state.deadlines[index].color),
                );
              }),
            ],
          ) : Container(),
        );
      },
    );
  }

  Widget _overviewItem(String value, String description) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),),
            Text(description, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),)
          ],
        ),
      ),
    );
  }

  Widget _pinnedItem({
    required String value,
    required double percentage,
    required DateTime dateTime,
    Color? color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const DesignedIcon(assetPath: 'assets/pin.png', size: 14, color: Colors.white,),
                    const SizedBox(width: 5,),
                    Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),),
                  ],
                ),
              ),
              LinearProgressIndicator(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
                minHeight: 5,
                value: percentage * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${percentage.toStringAsPrecision(4)}%', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),),
                  Text(DateFormat('dd MMM').format(dateTime), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}