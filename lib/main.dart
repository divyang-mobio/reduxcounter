import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'redux/reducer.dart';
import 'redux/state.dart';

import 'redux/action.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: Store<CounterState>(counterUpdate, initialState: CounterState(count: 0)),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Redux Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<CounterState, String>(
              converter: (store) => store.state.count.toString(),
              builder: (context, count) => Text(
                count,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StoreConnector<CounterState, VoidCallback>(converter: (store) {
            return () => store.dispatch(CounterActions.increment);
          }, builder: (_, callback) {
            return FloatingActionButton(
              onPressed: callback,
              child: const Icon(Icons.add),
            );
          }),
          SizedBox(width: 10),
          StoreConnector<CounterState, VoidCallback>(converter: (store) {
            return () => store.dispatch(CounterActions.decrement);
          }, builder: (_, callback) {
            return FloatingActionButton(
              onPressed: callback,
              child: const Icon(Icons.remove),
            );
          })
        ],
      ),
    );
  }
}
