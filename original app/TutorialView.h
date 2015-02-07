//
//  TutorialView.h
//  original
//
//  Created by ia on 2014/12/25.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol TutorialViewDelegate;

@interface TutorialView : UIView
@property (weak, nonatomic) id <TutorialViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *useLabel;
@end

@protocol TutorialViewDelegate <NSObject>

- (void)hideView:(TutorialView *)view pushedWebButton:(id)sender;

@optional
@end

