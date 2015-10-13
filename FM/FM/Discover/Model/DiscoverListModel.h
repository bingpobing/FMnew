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
@property (nonatomic,strong)NSString *record_file_duration;

@property (nonatomic,strong)NSString *record_title;

@property (nonatomic,strong)NSString *record_file_url;

@property (nonatomic,strong)NSString *record_file_bitrate;

@property (nonatomic,strong)NSString *file_size_low;

@property (nonatomic,assign)NSInteger user_acount;

@property (nonatomic,strong)NSString *file_low_url;

@property (nonatomic,assign)NSInteger record_key;

@property (nonatomic,strong)NSString *record_created_at;

@property (nonatomic,assign)NSInteger is_new;

@property (nonatomic,strong)NSString *record_number;

@property (nonatomic,strong)NSString *record_name;

@property (nonatomic,assign)NSInteger file_size;

@property (nonatomic,strong)NSString *record_file_type;

@property (nonatomic,strong)NSString *record_image_url;

@property (nonatomic,strong)NSString *file_m4a_url;


//headerView上的属性

@property (nonatomic,strong)NSString *location_name;

@property (nonatomic,strong)NSString *record_play_modify_at;

@property (nonatomic,assign)NSInteger is_collect;

@property (nonatomic,strong)NSString *default_order;

@property (nonatomic,strong)NSString *record_play_name;

@property (nonatomic,strong)NSString *play_time_start;

@property (nonatomic,assign)NSInteger record_amount;

@property (nonatomic,strong)NSString *record_play_decription;

@property (nonatomic,strong)NSString *channel_name;

@property (nonatomic,assign)NSInteger channel_key;

@property (nonatomic,strong)NSString *record_play_tag_names;

@property (nonatomic,strong)NSString *record_play_image_url;

@property (nonatomic,strong)NSString *category_name;

@property (nonatomic,strong)NSString *record_play_dj;





@end
