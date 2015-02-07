//
//  ClickHideView.h
//  original
//
//  Created by ia on 2015/02/07.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickHideViewDelegate;

@interface ClickHideView : UIView
@property (weak, nonatomic) id <ClickHideViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *useLabel;
@end

@protocol ClickHideViewDelegate <NSObject>

- (void)hideView:(ClickHideView *)view pushedClickButton:(id)sender;

@optional
@end


