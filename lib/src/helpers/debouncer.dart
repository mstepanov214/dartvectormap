import 'dart:async';

class Debouncer {
  final Duration _duration;

  Debouncer(Duration duration) : _duration = duration;

  Timer _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(_duration, action);
  }

  void cancel() => _timer?.cancel();
}
