#import <Flutter/Flutter.h>
#import "UPPaymentControl.h"

#ifndef FLUTTER_PAY_PAYUNIONPAY_H
#define FLUTTER_PAY_PAYUNIONPAY_H

@interface PayUnionPay : NSObject

+ (BOOL) checkInstallApp: (NSString*)appId;
+ (void) startPay: (NSString*)payInfo isSandbox:(BOOL)isSandbox urlScheme:(NSString*)urlScheme viewCtrl:(UIViewController *)viewCtrl result:(FlutterResult)result;
+ (BOOL) handleOpenURL: (NSURL*)url result:(FlutterResult)result;

@end


#endif //FLUTTER_PAY_PAYUNIONPAY_H
