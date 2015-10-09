//
//  DiscoverModel.h
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject


//top_name
//cellHeader名称
@property (nonatomic,strong)NSString *top_name;

//top_info
//收听总数
@property (nonatomic,assign)NSInteger record_play_listen_amount;
//cell名称
@property (nonatomic,strong)NSString *record_play_name;
//
@property (nonatomic,assign)NSInteger record_play_is_live;
//cell描述
@property (nonatomic,strong)NSString *record_play_summarize;
//cell图片
@property (nonatomic,strong)NSString *record_play_image_url;
//cell编号ID
@property (nonatomic,assign)NSInteger record_play_key;


//轮播图横幅
//
@property (nonatomic,assign)NSInteger banner_channel_key;
//
@property (nonatomic,strong)NSString *banner_record_play_key;
//
@property (nonatomic,strong)NSString *banner_text;
//轮播图片名称
@property (nonatomic,strong)NSString *banner_record_play_name;
//
@property (nonatomic,assign)NSInteger banner_type;
//轮播图片
@property (nonatomic,strong)NSString *banner_image_url;

@property (nonatomic,strong)NSString *banner_link_url;



@end
