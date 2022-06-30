import 'state.dart';
import 'action.dart';

  CounterState counterUpdate(CounterState state, dynamic action) {
    if (action == CounterActions.increment) {
      return CounterState(count: state.count + 1);
    } else if (action == CounterActions.decrement) {
      return CounterState(count: state.count - 1);
    } else {
      return CounterState(count: state.count);
    }
  }
