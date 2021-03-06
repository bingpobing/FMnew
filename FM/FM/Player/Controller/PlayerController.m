//
//  PlayerController.m
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "PlayerController.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "FMmodel.h"
#import "SCModel.h"
#import "AppDelegate.h"
#import "ListModel.h"
#import "DiscoverListModel.h"
#import "download.h"
#import "downloadManager.h"
#import "downloadModel.h"

@interface PlayerController ()

//可以使用AVPlayer播放本地音频和支持流媒体播放
@property(nonatomic , strong)AVPlayer *radioPalyer;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)BOOL playOrPause;
@property (nonatomic,assign) int numOfMusic;
@property (nonatomic,strong)UIImage *img;
@end


@implementation PlayerController

-(void)setPlayModel:(FMmodel *)playModel{
    NSURL *url = [NSURL URLWithString:playModel.imgUrl];
    self.PicUrl = url;
    self.playPathAacv224 = playModel.playPath;
    self.radioTitle = playModel.musicName;
    self.nickname = playModel.people;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numOfMusic = self.str;
    
    //背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:193/255.0 green:230/255.0 blue:252/255.0 alpha:1];
    
    [self play];
     self.playOrPause = YES;
    
    //进度条使用NStimer监控播放的进度
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerRadio) userInfo:nil repeats:YES];
    
    [self loadViewStyle];
    
    //[self.view addSubview:self.liebiaoBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)play{
    
    [FMmodel creatTable];
    NSString *img = [NSString stringWithFormat:@"%@",self.PicUrl];
    
    FMmodel *model = [FMmodel modelWithMusicName:self.radioTitle people:self.nickname imgUrl:img playPath:self.playPathAacv224];
    if (self.radioTitle != nil) {
        [model insertToTable];
    }
    
    self.radioPalyer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:self.playPathAacv224]];
    [self.radioPalyer play];
}

- (void)loadViewStyle{
    
    //返回按钮
    _backBtn.titleLabel.text = nil;
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, kScreenWidth*0.26, 64);
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    //传过来的图片
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.53, kScreenWidth * 0.53)];
    [_imgView sd_setImageWithURL:_PicUrl];
    _imgView.layer.cornerRadius = (kScreenWidth * 0.53)*0.5;
    _imgView.layer.masksToBounds = YES;
    _imgView.center = CGPointMake(kScreenWidth/2, kScreenHeight/5 + kScreenHeight*0.075);
    [self.view addSubview:_imgView];
    
    //小标题
    _titleLab.text = nil;
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame)+20, kScreenWidth, kScreenWidth*0.1)];
    _titleLab.text = self.radioTitle;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLab];
    
    //电台主持
    _djLab.text = nil;
    _djLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame)+60, kScreenWidth, kScreenWidth*0.1)];
    _djLab.text = self.nickname;
    _djLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_djLab];
    
    //列表
    [_liebiaoBtn removeFromSuperview];
    _liebiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _liebiaoBtn.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _liebiaoBtn.center = CGPointMake(kScreenWidth/2-kScreenWidth*0.26, kScreenHeight/2+kScreenWidth*0.26);
    [_liebiaoBtn setImage:[UIImage imageNamed:@"liebiao"] forState:UIControlStateNormal];
    [_liebiaoBtn addTarget:self action:@selector(clickLiebiaoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_liebiaoBtn];
    
    _liebiaoLab.text = nil;
    _liebiaoLab = [[UILabel alloc]init];
    _liebiaoLab.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _liebiaoLab.center = CGPointMake(kScreenWidth/2-kScreenWidth*0.26, CGRectGetMaxY(_liebiaoBtn.frame) + kScreenHeight * 0.015);
    _liebiaoLab.text = @"列表";
    [self.view addSubview:_liebiaoLab];
    
    //下载
    [_xiazaiBtn removeFromSuperview];
    _xiazaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _xiazaiBtn.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    self.xiazaiBtn.center = CGPointMake(kScreenWidth/2, kScreenHeight/2+kScreenWidth*0.26);
    [_xiazaiBtn setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];
    [_xiazaiBtn addTarget:self action:@selector(clickXiazaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_xiazaiBtn];
    
    _xiazaiLab.text = nil;
    _xiazaiLab = [[UILabel alloc]init];
    _xiazaiLab.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _xiazaiLab.center = CGPointMake(kScreenWidth/2+5, CGRectGetMaxY(_xiazaiBtn.frame) + kScreenHeight * 0.015);
    _xiazaiLab.text = @"下载";
    [self.view addSubview:_xiazaiLab];
    
    //收藏
    [_shoucangBtn removeFromSuperview];
    _shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shoucangBtn.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _shoucangBtn.center = CGPointMake(kScreenWidth/2+kScreenWidth*0.26, kScreenHeight/2+kScreenWidth*0.26);
    [_shoucangBtn setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
    [_shoucangBtn addTarget:self action:@selector(clickShoucangBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shoucangBtn];
    
    _shoucangLab.text = nil;
    _shoucangLab = [[UILabel alloc]init];
    _shoucangLab.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _shoucangLab.center = CGPointMake(kScreenWidth/2+kScreenWidth*0.27, CGRectGetMaxY(_shoucangBtn.frame) + kScreenHeight * 0.015);
    _shoucangLab.text = @"收藏";
    [self.view addSubview:_shoucangLab];
    
    //滑块
    [_timeSlider removeFromSuperview];
    _timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(kScreenWidth*0.107, CGRectGetMaxY(_imgView.frame)+kScreenHeight * 0.35, kScreenWidth-kScreenWidth*0.213, kScreenHeight*0.046)];
    [self.view addSubview:_timeSlider];
    
    //开始暂停
    [_startOrPuaseBtn removeFromSuperview];
    _startOrPuaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startOrPuaseBtn.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _startOrPuaseBtn.center = CGPointMake(kScreenWidth/2, kScreenHeight/2+kScreenHeight*0.39);
    self.img = nil;
    self.img = [UIImage imageNamed:@"zanting"];
    [_startOrPuaseBtn setImage:self.img forState:UIControlStateNormal];
    [_startOrPuaseBtn addTarget:self action:@selector(clickStartOrPuaseBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startOrPuaseBtn];
    
    //上一首
    [_previousBtn removeFromSuperview];
    _previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _previousBtn.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _previousBtn.center = CGPointMake(kScreenWidth/2-kScreenWidth*0.2, kScreenHeight/2+kScreenHeight*0.39);
    [_previousBtn setImage:[UIImage imageNamed:@"shang"] forState:UIControlStateNormal];
    [_previousBtn addTarget:self action:@selector(clickPreviousBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_previousBtn];
    
    //下一首
    [_nextBtn removeFromSuperview];
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, 0, kScreenWidth*0.13, kScreenWidth*0.13);
    _nextBtn.center = CGPointMake(kScreenWidth/2+kScreenWidth*0.2, kScreenHeight/2+kScreenHeight*0.39);
    [_nextBtn setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(clickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//返回事件
- (void)clickBackBtn:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.radioPalyer pause];
}
//列表事件
- (void)clickLiebiaoBtn:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.radioPalyer pause];
}
//下载事件
- (void)clickXiazaiBtn:(UIButton *)sender{
    if ([self.tag isEqualToString:@"2000"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下载" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        //常规
        UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"高品质" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            download *down = [download new];
            TCBlobDownloadManager *manger = [TCBlobDownloadManager new];
            NSString *img = [NSString stringWithFormat:@"%@",self.PicUrl];
            [down downloadWithUrl:self.file_m4a_url start:manger radioTitle:self.radioTitle nickname:self.nickname PicUrl:img playPathAacv224:self.playPathAacv224];
           
        }];
        //取消
        UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [alert addAction:alertAction1];
        [alert addAction:alertAction2];
        //显示提示框视图控制器
        [self presentViewController:alert animated:YES completion:nil];
    }else if([self.tag isEqualToString:@"1000"]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下载" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        //常规
        UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"高品质" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            download *down = [download new];
            TCBlobDownloadManager *manger = [TCBlobDownloadManager new];
            NSString *img = [NSString stringWithFormat:@"%@",self.PicUrl];
            [down downloadWithUrl:self.file_m4a_url start:manger radioTitle:self.radioTitle nickname:self.nickname PicUrl:img playPathAacv224:self.playPathAacv224];
        }];
        UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"标准品质" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            download *down = [download new];
            TCBlobDownloadManager *manger = [TCBlobDownloadManager new];
            NSString *img = [NSString stringWithFormat:@"%@",self.PicUrl];
            [down downloadWithUrl:self.file_low_url start:manger radioTitle:self.radioTitle nickname:self.nickname PicUrl:img playPathAacv224:self.playPathAacv224];
            
        }];
        //取消
        UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        
        [alert addAction:alertAction1];
        [alert addAction:alertAction2];
        [alert addAction:alertAction3];
        
        //显示提示框视图控制器
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}
//收藏事件
- (void)clickShoucangBtn:(UIButton *)sender{
    
    AppDelegate *bbb = [UIApplication sharedApplication].delegate;
    if (bbb.tempID) {
        [SCModel creatTable];
        NSString *img = [NSString stringWithFormat:@"%@",self.PicUrl];
        
        SCModel *model = [SCModel modelWithMusicName:self.radioTitle people:self.nickname imgUrl:img playPath:self.playPathAacv224 ];
        
        if (self.radioTitle != nil) {
            [model insertToTable];
        }
        
    }else{
        NSLog(@"请登录");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        
        UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         
        }];
        [alert addAction:alertAction1];
        [alert addAction:alertAction2];

        //显示提示框视图控制器
        [self presentViewController:alert animated:YES completion:nil];
    }
}
//滑块
- (void)timerRadio{
    
    _timeSlider.value = CMTimeGetSeconds(self.radioPalyer.currentItem.currentTime)/CMTimeGetSeconds(self.radioPalyer.currentItem.duration);
}
//暂停播放按钮
- (void)clickStartOrPuaseBtnBtn:(UIButton *)sender{
    UIButton *btn = (UIButton *)sender;
    if (self.playOrPause == YES) {
        self.playOrPause = NO;
        [self.radioPalyer pause];
        
        [btn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    }else{
        self.playOrPause = YES;
        [self.radioPalyer play];
        
        [btn setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
    }
}
//上一首
- (void)clickPreviousBtn:(UIButton *)sender{
 
    self.numOfMusic --;
    if (self.numOfMusic < 0) {
        return;
    }
    
    if ([self.tag isEqualToString:@"2000"]) {
        ListModel *model = [ListModel new];
        model = self.musicArray[self.numOfMusic];
        self.PicUrl = model.PicUrl;
        self.radioTitle = model.title;
        self.nickname = model.nickname;
        self.duration = model.duration;
        self.playPathAacv224 = model.playPathAacv224;
    }else if([self.tag isEqualToString:@"1000"]){
        DiscoverListModel *model = [DiscoverListModel new];
        NSURL *url = [NSURL URLWithString:model.record_image_url];
        model = self.musicArray[self.numOfMusic];
        self.PicUrl = url;
        self.radioTitle = model.record_title;
        self.nickname = model.record_name;
        self.duration = model.record_file_duration;
        self.playPathAacv224 = model.record_file_url;
    }
    
    [self play];
    [self loadViewStyle];
 
}
//下一首
- (void)clickNextBtn:(UIButton *)sender{
    
    self.numOfMusic ++;
    if (self.numOfMusic > self.musicArray.count) {
        return;
    }
    
    if ([self.tag isEqualToString:@"2000"]) {
        ListModel *model = [ListModel new];
        model = self.musicArray[self.numOfMusic];
        self.PicUrl = model.PicUrl;
        self.radioTitle = model.title;
        self.nickname = model.nickname;
        self.duration = model.duration;
        self.playPathAacv224 = model.playPathAacv224;
    }else if([self.tag isEqualToString:@"1000"]){
        DiscoverListModel *model = [DiscoverListModel new];
        NSURL *url = [NSURL URLWithString:model.record_image_url];
        model = self.musicArray[self.numOfMusic];
        self.PicUrl = url;
        self.radioTitle = model.record_title;
        self.nickname = model.record_name;
        self.duration = model.record_file_duration;
        self.playPathAacv224 = model.record_file_url;
    }

    [self play];
    [self loadViewStyle];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
