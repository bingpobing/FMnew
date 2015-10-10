//
//  PlayerController.h
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMmodel;
@interface PlayerController : UIViewController


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
@property (nonatomic,strong)UILabel *playedTimeLab;
@property (nonatomic,strong)UILabel *lastTimeLab;
@property (nonatomic,strong)UIButton *previousBtn;
@property (nonatomic,strong)UIButton *startOrPuaseBtn;
@property (nonatomic,strong)UIButton *nextBtn;

//因为这个页面要一直存在,所以要使用单例
+ (PlayerController *)shareController;


@end
