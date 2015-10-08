//
//  PlayerController.m
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "PlayerController.h"
#import "LiebiaoTableViewController.h"

@interface PlayerController ()

@end

@implementation PlayerController

//因为这个页面要一直存在,所以要使用单例
+(PlayerController *)shareController{
    static PlayerController *playerController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerController = [PlayerController new];
    });
    return playerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    
    //设置导航栏右边按钮:图片
    //图片渲染(保持原有的特性)(如果图片不是镂空的,必须渲染)
    UIImage *image = [UIImage imageNamed:@"gengduo"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//翻译;表现 模式 //原始的;最初的
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickChange)];
    
    
    
    [self loadViewStyle];
    
    //[self.view addSubview:self.liebiaoBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadViewStyle{
    
    UIImage *image1 = [UIImage imageNamed:@"电台图片.jpeg"];
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.imgView.layer.cornerRadius = 100;
    self.imgView.layer.masksToBounds = YES;
    self.imgView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2-150);
    //设置显示的图片
    self.imgView.image = image1;
    [self.view addSubview:self.imgView];
    
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+20, self.view.frame.size.width, 30)];
    self.titleLab.text = @"标题";
    self.titleLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.titleLab];
    
    
    self.djLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+70, self.view.frame.size.width, 30)];
    self.djLab.text = @"主持";
    self.djLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.djLab];
 
    
    //列表
    self.liebiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.liebiaoBtn.frame = CGRectMake(0, 0, 50, 50);
    self.liebiaoBtn.center = CGPointMake(kScreenWidth/2-150, kScreenHeight/2+100);
    [self.liebiaoBtn setImage:[UIImage imageNamed:@"liebiao"] forState:UIControlStateNormal];
    [self.liebiaoBtn addTarget:self action:@selector(clickLiebiaoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.liebiaoBtn];
    
    self.liebiaoLab = [[UILabel alloc]init];
    self.liebiaoLab.frame = CGRectMake(0, 0, 50, 50);
    self.liebiaoLab.center = CGPointMake(kScreenWidth/2-145, kScreenHeight/2+125);
    self.liebiaoLab.text = @"列表";
    [self.view addSubview:self.liebiaoLab];
    
    //定时
    self.dingshiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dingshiBtn.frame = CGRectMake(0, 0, 50, 50);
    self.dingshiBtn.center = CGPointMake(kScreenWidth/2-50, kScreenHeight/2+100);
    [self.dingshiBtn setImage:[UIImage imageNamed:@"dingshi"] forState:UIControlStateNormal];
    [self.dingshiBtn addTarget:self action:@selector(clickDingshiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dingshiBtn];
    
    self.dingshiLab = [[UILabel alloc]init];
    self.dingshiLab.frame = CGRectMake(0, 0, 50, 50);
    self.dingshiLab.center = CGPointMake(kScreenWidth/2-45, kScreenHeight/2+125);
    self.dingshiLab.text = @"定时";
    [self.view addSubview:self.dingshiLab];
    
    //下载
    self.xiazaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xiazaiBtn.frame = CGRectMake(0, 0, 50, 50);
    self.xiazaiBtn.center = CGPointMake(kScreenWidth/2+50, kScreenHeight/2+100);
    [self.xiazaiBtn setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];
    [self.xiazaiBtn addTarget:self action:@selector(clickXiazaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.xiazaiBtn];
    
    self.xiazaiLab = [[UILabel alloc]init];
    self.xiazaiLab.frame = CGRectMake(0, 0, 50, 50);
    self.xiazaiLab.center = CGPointMake(kScreenWidth/2+55, kScreenHeight/2+125);
    self.xiazaiLab.text = @"下载";
    [self.view addSubview:self.xiazaiLab];
    
    //收藏
    self.shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shoucangBtn.frame = CGRectMake(0, 0, 50, 50);
    self.shoucangBtn.center = CGPointMake(kScreenWidth/2+150, kScreenHeight/2+100);
    [self.shoucangBtn setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
    [self.shoucangBtn addTarget:self action:@selector(clickShoucangBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shoucangBtn];
    
    self.shoucangLab = [[UILabel alloc]init];
    self.shoucangLab.frame = CGRectMake(0, 0, 50, 50);
    self.shoucangLab.center = CGPointMake(kScreenWidth/2+155, kScreenHeight/2+125);
    self.shoucangLab.text = @"收藏";
    [self.view addSubview:self.shoucangLab];
    
    //滑块
    self.timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imgView.frame)+210, kScreenWidth-40, 31)];
    [self.timeSlider addTarget:self action:@selector(timeSliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.timeSlider];
    
    //开始暂停
    self.startOrPuaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startOrPuaseBtn.frame = CGRectMake(0, 0, 50, 50);
    self.startOrPuaseBtn.center = CGPointMake(kScreenWidth/2, kScreenHeight/2+220);
    [self.startOrPuaseBtn setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
    [self.view addSubview:self.startOrPuaseBtn];
    
    //上一首
    self.previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.previousBtn.frame = CGRectMake(0, 0, 50, 50);
    self.previousBtn.center = CGPointMake(kScreenWidth/2-80, kScreenHeight/2+220);
    [self.previousBtn setImage:[UIImage imageNamed:@"shang"] forState:UIControlStateNormal];
    [self.view addSubview:self.previousBtn];
    
    //下一首
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(0, 0, 50, 50);
    self.nextBtn.center = CGPointMake(kScreenWidth/2+80, kScreenHeight/2+220);
    [self.nextBtn setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
    [self.view addSubview:self.nextBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//导航栏按钮
- (void)clickChange{
    
    //上拉菜单 ActionSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享到" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    //常规
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    //取消
    UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    [alert addAction:alertAction1];
    [alert addAction:alertAction2];
    [alert addAction:alertAction3];

    [self presentViewController:alert animated:YES completion:nil];
}
//时间滑条拖动事件
- (void)timeSliderAction:(UISlider *)sender{
    NSLog(@"%f",sender.value);
    
}
//列表事件
- (void)clickLiebiaoBtn:(UIButton *)sender{
    
    LiebiaoTableViewController *liebiaoTableVC = [[LiebiaoTableViewController alloc]init];
    
    [self.navigationController pushViewController:liebiaoTableVC animated:YES];
}
//定时事件
- (void)clickDingshiBtn:(UIButton *)sender{
    
    //上拉菜单 ActionSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"定时关闭" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    //常规
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"10分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"30分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"50分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *alertAction4 = [UIAlertAction actionWithTitle:@"70分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *alertAction5 = [UIAlertAction actionWithTitle:@"90分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    //警示
    UIAlertAction *alertAction6 = [UIAlertAction actionWithTitle:@"该节目播放完毕后自动关闭" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }];
    //取消
    UIAlertAction *alertAction7 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];

    [alert addAction:alertAction1];
    [alert addAction:alertAction2];
    [alert addAction:alertAction3];
    [alert addAction:alertAction4];
    [alert addAction:alertAction5];
    [alert addAction:alertAction6];
    [alert addAction:alertAction7];
    
    //显示提示框视图控制器
    [self presentViewController:alert animated:YES completion:nil];
}
//下载事件
- (void)clickXiazaiBtn:(UIButton *)sender{
    
    //上拉菜单 ActionSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下载" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    //常规
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"高品质" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"标准品质" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
//收藏事件
- (void)clickShoucangBtn:(UIButton *)sender{
    
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
