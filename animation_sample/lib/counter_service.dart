
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterServiceProvider = Provider(((ref){return CounterService();}));


class CounterService{

  int increment(int counter){
    return counter + 1;
  }

}