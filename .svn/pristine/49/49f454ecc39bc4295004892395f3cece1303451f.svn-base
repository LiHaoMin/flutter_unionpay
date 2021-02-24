import 'dart:async';

import 'package:flutter/services.dart';
import 'package:unionpay/unionpay_result.dart';

class Unionpay {

  static const MethodChannel _channel =
      const MethodChannel('unionpay');

  static Future<UnionpayResult> pay(String payInfo, bool isSandbox, String urlScheme) async {
    try{
      var res =  await _channel.invokeMethod('pay',<String, dynamic>{
        'payInfo': payInfo,
        'isSandbox': isSandbox,
        'urlScheme': urlScheme
      });

      final UnionpayResult result = new UnionpayResult();
      if( res['pay_result'] == "success" ){
        result.setOupayRest(0, "支付完成",payChannel:'unionpay',channelData:res );
      }else if( res['pay_result'] == "cancel"){
        result.setOupayRest(-2, "用户取消",payChannel:'unionpay',channelData:res );
      }else{
        result.setOupayRest(-1, "支付失败",payChannel:'unionpay',channelData:res );
      }
      return result;
    } on PlatformException catch (e) {
      print(e);
      final UnionpayResult result = new UnionpayResult();
      result.setOupayRest(-1, "银联支付异常[$e]");
      return result;
    }
  }
}
