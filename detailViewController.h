//
//  detailViewController.h
//  original app
//
//  Created by ia on 2014/08/04.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate> {
    IBOutlet UIScrollView *scrollView;    //今回はスクロールビューにテキストフィールドを載せているので
    UITextField *activeField;    //選択されたテキストフィールドを入れる
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *urlLabel;
    IBOutlet UIImageView *imgView;
    NSString *url ;
    
    IBOutlet UIButton *urlbtn;
}

-(IBAction)openurl;

@property (nonatomic) int entryId;

@end
