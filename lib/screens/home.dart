import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "KJBN LABS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => _buildRectangularBox(
                    "Current Second", controller.widget1Seconds.value)),
                Obx(() => _buildRectangularBox(
                    "Random Number", controller.widget2Value.value)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Obx(() => controller.showSuccessMessage.value
                ? _buildSuccessMessage()
                : _buildFailureMessage()),
          ),
          _buildCircularTimerWithButton(),
          SizedBox(height: 8.0),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildRectangularBox(String label, int value) {
    return Container(
      width: 150.0,
      height: 100.0,
      color: Colors.white,
      child: Center(
        child: Text(
          '$label: $value',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.green,
      child: Column(
        children: [
          Text(
            "Success :)",
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Text(
            "Score: ${controller.widget3SuccessScore}/${controller.widget3Attempts}",
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureMessage() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.orange,
      child: Column(
        children: [
          Obx(() => controller.widget3Attempts.value > 0
              ? Text(
                  controller.failureMessage.value.isNotEmpty
                      ? controller.failureMessage.value
                      : "Sorry try Again!",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                )
              : Container()),
          Divider(
            color: Colors.black,
          ),
          Text(
            "Attempts: ${controller.widget3Attempts.value}",
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularTimerWithButton() {
    return Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
          child: Center(
            child: Obx(() => Text(
                  "0:0${controller.widget4Counter}",
                  style: TextStyle(fontSize: 20.0),
                )),
          ),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            controller.onWidget5Tap();
          },
          child: Text("Click"),
        ),
      ],
    );
  }
}
