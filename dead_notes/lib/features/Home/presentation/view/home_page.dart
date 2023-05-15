import 'package:dead_notes/features/Home/presentation/bloc/home_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TopBar(title: homeLocalize(context),),
            body: ListView(
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
                    _overviewItem('123', finishedInTimeLocalize(context)),
                    _overviewItem('45', deadlinesFailedLocalize(context)),
                    _overviewItem('75%', successRateLocalize(context)),
                    _overviewItem('2 ${daysLocalize(context).toLowerCase()}', averageTimeLocalize(context)),
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
                ...[
                  _pinnedItem(value: 'Basics of algorithms', percentage: 70, dateTime: DateTime(2023, 5, 20)),
                  _pinnedItem(value: 'Engineering', percentage: 23, dateTime: DateTime(2023, 6, 15)),
                  _pinnedItem(value: 'Math', percentage: 87, dateTime: DateTime(2023, 5, 16)),
                  _pinnedItem(value: 'Basics of algorithms', percentage: 70, dateTime: DateTime(2023, 5, 20)),
                  _pinnedItem(value: 'Engineering', percentage: 23, dateTime: DateTime(2023, 6, 15)),
                  _pinnedItem(value: 'Math', percentage: 87, dateTime: DateTime(2023, 5, 16)),
                ]
              ],
            ),
          );
        },
      ),
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
    required DateTime dateTime,}) {
    return Card(
      color: Theme.of(context).primaryColor,
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
                Text('$percentage%', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),),
                Text(DateFormat('dd MMM').format(dateTime), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),),
              ],
            )
          ],
        ),
      ),
    );
  }
}