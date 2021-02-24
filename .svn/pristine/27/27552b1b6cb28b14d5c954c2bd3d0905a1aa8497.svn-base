package com.mbp.flutter.unionpay;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.unionpay.UPPayAssistEx;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.ref.WeakReference;
import java.net.URL;
import java.net.URLConnection;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.util.HashMap;
import java.util.Map;

/** UnionpayPlugin */
public class UnionpayPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Application mApplication;
  private WeakReference<Activity> mActivity;
  private Result result;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "unionpay");
    channel.setMethodCallHandler(this);
    mApplication = (Application) flutterPluginBinding.getApplicationContext();
  }

  public MethodCallHandler initPlugin(MethodChannel methodChannel, Registrar registrar) {
    channel = methodChannel;
    mApplication = (Application) registrar.context().getApplicationContext();
    mActivity = new WeakReference<>(registrar.activity());
    registrar.addActivityResultListener(this);
    return this;
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "unionpay");
    channel.setMethodCallHandler(new UnionpayPlugin().initPlugin(channel, registrar));
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    mActivity = new WeakReference<>(activityPluginBinding.getActivity());
    activityPluginBinding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {

  }

  @Override
  public void onDetachedFromActivity() {
    mActivity = null;
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("pay")) {
      this.result = result;
      String tn = call.argument("payInfo");
      boolean isSandbox = call.argument("isSandbox");
      String upMode = "00";
      if(isSandbox) {
        upMode = "01";
      }

      try {
        UPPayAssistEx.startPay (mActivity.get(), null, null, tn, upMode);
      } catch (Exception e) {
        result.error("unionpay_err", e.getMessage(), null);
      }
    } else {
      result.notImplemented();
    }
  }

  /**
   * 银联支付回调
   */
  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
    if (intent == null) {
      return false;
    }

    switch (requestCode){
      case 10:{
        /*
         * 支付控件返回字符串:success、fail、cancel 分别代表支付成功，支付失败，支付取消
         */
        Map<String, String>  resultMap = new HashMap<String,String>();
        String payResult = intent.getExtras().getString("pay_result");
        resultMap.put("pay_result", payResult);

        if (payResult.equalsIgnoreCase("success")) {
          if (intent.hasExtra("result_data")) {
            String resultData = intent.getExtras().getString("result_data");
            resultMap.put("result_data", resultData);
          }
        }

        this.result.success(resultMap);
      } break;
      default:
        return false;
    }
    return true;
  }
}
