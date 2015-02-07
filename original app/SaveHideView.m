//
//  SaveHideView.m
//  original
//
//  Created by ia on 2015/02/07.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import "SaveHideView.h"

@implementation SaveHideView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"SaveHideView" bundle:[NSBundle mainBundle]];
        NSArray *array = [nib instantiateWithOwner:self options:nil];
        self = [array objectAtIndex:0];
    }
    return self;
}

- (IBAction)SaveButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(hideView:pushedSaveButton:)]) {
        [self.delegate hideView:self pushedSaveButton:sender];
    }
}

@end
