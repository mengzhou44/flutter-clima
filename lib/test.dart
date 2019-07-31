import 'dart:io';

void main() {
  doTasks();
}

void doTasks() async {
  String result = await doTask1();
  doTask2(result);
}

Future<String> doTask1() async {
  Duration threeSeconds = Duration(seconds: 3);
  String result;
  await Future.delayed(threeSeconds, () {
    result = "123";
  });

  return result;
}

void doTask2(result) {
  print('do task 2  with result $result');
}
