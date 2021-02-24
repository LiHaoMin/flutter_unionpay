import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:unionpay/unionpay.dart';

void main() {
  const MethodChannel channel = MethodChannel('unionpay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
//    expect(await Unionpay.platformVersion, '42');
  });
}
