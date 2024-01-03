import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt widget2Value = 0.obs;
  RxInt widget1Seconds = 0.obs;
  RxInt widget3Attempts = 0.obs;
  RxInt widget3SuccessScore = 0.obs;
  RxInt widget3FailureScore = 0.obs;
  RxInt widget4Counter = 5.obs;
  RxBool showSuccessMessage = false.obs;
  RxString failureMessage = "".obs;
  Timer? widget4Timer;

  @override
  void onInit() {
    super.onInit();
    _loadValues();
  }

  void _updateWidget2And1Values() {
    widget2Value.value = _generateRandomNumber();
    widget1Seconds.value = _getCurrentSeconds();
  }

  void onWidget5Tap() {
    widget3Attempts.value++;

    _updateWidget2And1Values();

    if (widget2Value.value == widget1Seconds.value) {
      widget3SuccessScore.value++;
      showSuccessMessage.value = true;
    } else {
      showSuccessMessage.value = false;
      _showFailureMessage();

      widget3FailureScore.value++;
      _resetWidget4Timer();

      Future.delayed(Duration(seconds: 5), () {
        if (widget4Counter.value == 0) {
          _showTimeoutFailureMessage();
        }
      });
    }

    widget4Counter.value = 5;
    _resetWidget4Timer();
    _storeCurrentValues();
  }

  void _resetWidget4Timer() {
    widget4Timer?.cancel();
    widget4Timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget4Counter.value > 0) {
        widget4Counter.value--;
      } else {
        _showTimeoutFailureMessage();
        widget4Counter.value = 5;
        timer.cancel();
      }
    });
  }

  void _storeCurrentValues() {
    _storeValues(
      widget2Value.value,
      widget1Seconds.value,
      widget3Attempts.value,
      widget3SuccessScore.value,
      widget3FailureScore.value,
    );
  }

  void _loadValues() {
    int loadedWidget2Value = 0;
    int loadedWidget1Seconds = _getCurrentSeconds();
    int loadedWidget3Attempts = 0;
    int loadedWidget3SuccessScore = 0;
    int loadedWidget3FailureScore = 0;

    widget2Value.value = loadedWidget2Value;
    widget1Seconds.value = loadedWidget1Seconds;
    widget3Attempts.value = loadedWidget3Attempts;
    widget3SuccessScore.value = loadedWidget3SuccessScore;
    widget3FailureScore.value = loadedWidget3FailureScore;
  }

  void _storeValues(
    int widget2Value,
    int widget1Seconds,
    int widget3Attempts,
    int widget3SuccessScore,
    int widget3FailureScore,
  ) {
    print(
        "Stored Values: $widget2Value, $widget1Seconds, $widget3Attempts, $widget3SuccessScore, $widget3FailureScore");
  }

  void _showFailureMessage() {
    failureMessage.value = "Sorry! Try Again!";
  }

  void _showTimeoutFailureMessage() {
    failureMessage.value =
        "Sorry! Timeout. One attempt is considered for failure as a penalty. Failure Score: ${widget3FailureScore.value} out of ${widget3Attempts.value}";
    Future.delayed(Duration(seconds: 3), () {
      failureMessage.value = "";
    });
  }

  int _generateRandomNumber() {
    return Random().nextInt(60);
  }

  int _getCurrentSeconds() {
    return DateTime.now().second;
  }

  @override
  void onClose() {
    widget4Timer?.cancel();
    super.onClose();
  }
}
