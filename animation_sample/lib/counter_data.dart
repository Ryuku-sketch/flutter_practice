import 'package:animation_sample/counter_service.dart';
import 'package:animation_sample/counter_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateNotifierProvider<Counter, CounterState>(
        (ref){
          return Counter(counterService: ref.watch(counterServiceProvider));
});

class Counter extends StateNotifier<CounterState> {
  Counter({required CounterService counterService})
      : _counterService = counterService, super(CounterState(count: 0));
  final CounterService _counterService;

  void increment(){
    state = state.copyWith(
      count: _counterService.increment(state.count)
    );

  }
}
