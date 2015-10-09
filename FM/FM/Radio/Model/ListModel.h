//
//  ListModel.h
//  FM
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property(nonatomic , strong) NSURL *PicUrl;

@property(nonatomic , strong) NSString *title;

@property(nonatomic , strong) NSString *nickname;

@property(nonatomic , strong) NSString *playtime;

@property(nonatomic , strong) NSString *likes;

@property(nonatomic , strong) NSString *duration;

@end
