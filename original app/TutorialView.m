//
//  TutorialView.m
//  original
//
//  Created by ia on 2014/12/25.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "TutorialView.h"

@implementation TutorialView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"TutorialView" bundle:[NSBundle mainBundle]];
        NSArray *array = [nib instantiateWithOwner:self options:nil];
        self = [array objectAtIndex:0];
    }
    return self;
}

- (IBAction)handleWebButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(hideView:pushedWebButton:)]) {
        [self.delegate hideView:self pushedWebButton:sender];
    }
}
@end

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

