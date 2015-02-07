//
//  ClickHideView.m
//  original
//
//  Created by ia on 2015/02/07.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import "ClickHideView.h"

@implementation ClickHideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"ClickHideView" bundle:[NSBundle mainBundle]];
        NSArray *array = [nib instantiateWithOwner:self options:nil];
        self = [array objectAtIndex:0];
    }
    return self;
}

- (IBAction)handleClickButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(hideView:pushedClickButton:)]) {
        [self.delegate hideView:self pushedClickButton:sender];
    }
}
@end
