//
//  DiscoverListModel.h
//  FM
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverListModel : NSObject


//cell详情属性
@property (nonatomic,strong)NSString *record_file_duration;//持续时间

@property (nonatomic,strong)NSString *record_title;//小标题

@property (nonatomic,strong)NSString *record_file_url;//电台地址

@property (nonatomic,strong)NSString *record_file_bitrate;

@property (nonatomic,strong)NSString *file_size_low;

@property (nonatomic,assign)NSInteger user_acount;//收听的人数

@property (nonatomic,strong)NSString *file_low_url;//电台地址

@property (nonatomic,assign)NSInteger record_key;

@property (nonatomic,strong)NSString *record_created_at;//开始时间

@property (nonatomic,assign)NSInteger is_new;

@property (nonatomic,strong)NSString *record_number;

@property (nonatomic,strong)NSString *record_name;

@property (nonatomic,assign)NSInteger file_size;

@property (nonatomic,strong)NSString *record_file_type;

@property (nonatomic,strong)NSString *record_image_url;//图片地址

@property (nonatomic,strong)NSString *file_m4a_url;//电台下载地址


//headerView上的属性

@property (nonatomic,strong)NSString *location_name;

@property (nonatomic,strong)NSString *record_play_modify_at;

@property (nonatomic,assign)NSInteger is_collect;

@property (nonatomic,strong)NSString *default_order;

@property (nonatomic,strong)NSString *record_play_name;

@property (nonatomic,strong)NSString *play_time_start;

@property (nonatomic,assign)NSInteger record_amount;

@property (nonatomic,strong)NSString *record_play_decription;//简介

@property (nonatomic,strong)NSString *channel_name;//电台

@property (nonatomic,assign)NSInteger channel_key;

@property (nonatomic,strong)NSString *record_play_tag_names;

@property (nonatomic,strong)NSString *record_play_image_url;//左边图片

@property (nonatomic,strong)NSString *category_name;

@property (nonatomic,strong)NSString *record_play_dj;//主持





@end
