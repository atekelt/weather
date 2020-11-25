import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart' as dr;
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('Integration test...', () {
    dr.FlutterDriver driver;
    setUpAll(() async {
      final envVars = Platform.environment;
      final adbPath = p.join(
        envVars['ANDROID_SDK_ROOT'],
        Platform.isWindows ? 'adb.exe' : 'adb',
      );
      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.example.weather', // replace with your app id
        'android.permission.RECORD_AUDIO',
        'android.permission.ACCESS_COARSE_LOCATION',
        'android.permission.ACCESS_FINE_LOCATION'
      ]);
      driver = await dr.FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('Test city name..', () async {
      final cityName = dr.find.byValueKey('cityName');
      expect(await driver.getText(cityName), 'Addis Ababa');
    });
  });
}
