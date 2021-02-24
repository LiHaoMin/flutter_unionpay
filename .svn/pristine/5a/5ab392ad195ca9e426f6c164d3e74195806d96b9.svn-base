#import "UnionpayPlugin.h"
#import "PayUnionPay.h"

@interface UnionpayPlugin()
@property (readwrite,copy,nonatomic) FlutterResult __result;
@property (readwrite,copy,nonatomic) NSString * uppay_urlScheme;
@end

@implementation UnionpayPlugin{
    UIViewController *_viewController;
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"unionpay"
            binaryMessenger:[registrar messenger]];
 UIViewController *viewController =
    [UIApplication sharedApplication].delegate.window.rootViewController;
    UnionpayPlugin* instance = [[UnionpayPlugin alloc] initWithViewController:viewController];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  self.__result = result;

  if ([@"pay" isEqualToString:call.method]) {
    NSString * payInfo = call.arguments[@"payInfo"];
    NSNumber * isSandbox = call.arguments[@"isSandbox"];
    NSString * urlScheme = call.arguments[@"urlScheme"];

    self.uppay_urlScheme = urlScheme;

    [PayUnionPay startPay:payInfo isSandbox:[isSandbox boolValue] urlScheme:urlScheme viewCtrl:_viewController result:result ];

  }  else {
    result(FlutterMethodNotImplemented);
  }

}

//回调通知
- (BOOL)handleOpenURL:(NSURL*)url {
    NSLog(@"reslut = %@",url);
    NSLog(@"url.scheme = %@",url.scheme);
    if( [url.scheme isEqualToString:self.uppay_urlScheme] ){
        return [PayUnionPay handleOpenURL:url result:self.__result];
    }

    return NO;
}

#pragma ApplicatioonLifeCycle

/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options{
    return [self handleOpenURL:url];
}

/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url{
    return [self handleOpenURL:url];
}

/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
  sourceApplication:(NSString*)sourceApplication
         annotation:(id)annotation{
    return [self handleOpenURL:url];
}

@end
