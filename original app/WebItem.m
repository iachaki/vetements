//
//  WebItem.m
//  original
//
//  Created by ia on 2014/09/26.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "WebItem.h"


@implementation WebItem

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.urlString forKey:@"urlString"];
    [aCoder encodeObject:self.imageStr forKey:@"imageStr"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        self.title = [coder decodeObjectForKey:@"title"];
        self.urlString = [coder decodeObjectForKey:@"urlString"];
        self.imageStr = [coder decodeObjectForKey:@"imageStr"];
    }
    return self;
}

@end


