//
//  SaveHideView.h
//  original
//
//  Created by ia on 2015/02/07.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SaveHideViewDelegate;

@interface SaveHideView : UIView
@property (weak, nonatomic) id <SaveHideViewDelegate> delegate;
@end

@protocol SaveHideViewDelegate <NSObject>

- (void)hideView:(SaveHideView *)view pushedSaveButton:(id)sender;

@optional
@end