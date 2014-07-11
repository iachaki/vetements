//
//  WebViewController.h
//  original app
//
//  Created by ia on 2014/07/04.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *label;
    IBOutlet UILabel *label2;
}

@end
