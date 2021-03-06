//
//  PlayerController.h
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TCBlobDownload/TCBlobDownload.h>
@class FMmodel;

@interface PlayerController : UIViewController

@property (nonatomic, strong) NSMutableArray *musicArray;
@property (nonatomic, assign) int str;
@property (nonatomic, strong) NSString *tag;
//图片
@property(nonatomic , strong) NSURL *PicUrl;
//小标题
@property(nonatomic , strong) NSString *radioTitle;
//主持电台
@property(nonatomic , strong) NSString *nickname;
//持续时间
@property(nonatomic , strong) NSString *duration;
//电台地址
@property (nonatomic,strong)NSString *playPathAacv224;
//电台下载地址
@property (nonatomic,strong)NSString *file_m4a_url;
@property (nonatomic,strong)NSString *file_low_url;
@property (nonatomic,strong)FMmodel *playModel;



@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIImageView *imgView;

@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *djLab;

@property (nonatomic,strong)UIButton *liebiaoBtn;
@property (nonatomic,strong)UIButton *xiazaiBtn;
@property (nonatomic,strong)UIButton *shoucangBtn;

@property (nonatomic,strong)UILabel *liebiaoLab;
@property (nonatomic,strong)UILabel *xiazaiLab;
@property (nonatomic,strong)UILabel *shoucangLab;

@property (nonatomic,strong)UISlider *timeSlider;
@property (nonatomic,strong)UIButton *previousBtn;
@property (nonatomic,strong)UIButton *startOrPuaseBtn;
@property (nonatomic,strong)UIButton *nextBtn;


@end
