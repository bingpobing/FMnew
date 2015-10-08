//
//  PlayerModel.h
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject

@property (nonatomic,strong)NSString *record_name;//大标题
@property (nonatomic,strong)NSString *record_image_url;//图片
@property (nonatomic,strong)NSString *record_title;//小标题
@property (nonatomic,strong)NSString *record_play_dj;//主持
@property (nonatomic,strong)NSString *record_file_duration;//持续时间

@end
