import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_samaritan/services/files.dart';
import '../models/boxes.dart';
import '../models/transaction.dart';
import 'core_state.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;

  const AppStateContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AppStateContainer> createState() => AppStateContainerState();
}

class AppStateContainerState extends State<AppStateContainer> {
  AppState state = AppState();

  ///i am not sure if i have to put this here but we will change it if necessary
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void deleteTransaction(Transaction transaction) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() => transactions.remove(transaction));
  }

  Future addTransaction(String name, String description, String adverseReaction,
      String id, String overdossage) async {
    final medicine = Transaction()
      ..name = name
      ..description = description
      ..adverseReaction = adverseReaction
      ..medId = id
      ..overdossage = overdossage;

    final box = Boxes.getTransactions();
    // box.add(medicine);

    box.put(name, medicine);

    ///this is also antoher option
    setState(() {
      state.medicines.add(medicine);
    });

    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  @override
  Widget build(BuildContext context) => StateInheritedWidget(
        child: widget.child,
        state: state,
        stateWidget: this,
      );
}

class StateInheritedWidget extends InheritedWidget {
  final AppState state;
  final AppStateContainerState stateWidget;

  const StateInheritedWidget({
    Key? key,
    required Widget child,
    required this.state,
    required this.stateWidget,
  }) : super(key: key, child: child);

  static AppStateContainerState? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<StateInheritedWidget>()
      ?.stateWidget;

  @override
  bool updateShouldNotify(StateInheritedWidget oldWidget) =>
      oldWidget.state != state;
}
