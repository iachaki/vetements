//
//  WebViewController.h
//  original app
//
//  Created by ia on 2014/07/04.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyFashionData.h"
#import "CustomIOS7AlertView.h"
#import "SVProgressHUD.h"

@interface WebViewController : UIViewController<UIGestureRecognizerDelegate, CustomIOS7AlertViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *label;
    IBOutlet UILabel *label2;
    NSString* jpg64Str;

    NSManagedObjectContext *magicalContext;
}
//-(IBAction)backBtnUserClick;

#pragma mark yuma_fix
@property (nonatomic) NSString *urlString;

@end
