//
//  TrakingManager.h
//  original
//
//  Created by ia on 2015/06/13.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackingManager : NSObject


// スクリーン名計測用メソッド
+ (void)sendScreenTracking:(NSString *)screenName;

// イベント計測用メソッド
+ (void)sendEventTracking:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value screen:(NSString *)screen;

@end
