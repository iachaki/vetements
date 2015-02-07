//
//  UrlHideView.m
//  original
//
//  Created by ia on 2015/02/07.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import "UrlHideView.h"

@implementation UrlHideView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"UrlHideView" bundle:[NSBundle mainBundle]];
        NSArray *array = [nib instantiateWithOwner:self options:nil];
        self = [array objectAtIndex:0];
    }
    return self;
}

- (IBAction)handleUrlButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(hideView:pushedUrlButton:)]) {
        [self.delegate hideView:self pushedUrlButton:sender];
    }
}

@end
