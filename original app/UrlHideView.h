//
//  UrlHideView.h
//  original
//
//  Created by ia on 2015/02/07.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UrlHideViewDelegate;

@interface UrlHideView : UIView
@property (weak, nonatomic) id <UrlHideViewDelegate> delegate;
@end

@protocol UrlHideViewDelegate <NSObject>

- (void)hideView:(UrlHideView *)view pushedUrlButton:(id)sender;

@optional
@end