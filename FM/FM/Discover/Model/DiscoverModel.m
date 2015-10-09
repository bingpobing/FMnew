//
//  DiscoverModel.m
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"==========%@",key);
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.record_play_image_url];
}



@end
