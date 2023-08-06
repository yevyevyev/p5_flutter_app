import 'dart:async';

class Debouncer {
  Debouncer(this.duration);

  void debounce(Function callback) {
    _timer?.cancel();
    _timer = Timer.periodic(duration, (timer) {
      callback();
      _timer?.cancel();
    });
  }

  void dispose() {
    _timer?.cancel();
  }

  Timer? _timer;
  final Duration duration;
}
