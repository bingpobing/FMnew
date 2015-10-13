//
//  LoginMineController.m
//  FM
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "LoginMineController.h"
#import "LoginController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"
@interface LoginMineController ()

@end

@implementation LoginMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawss];
    // Do any additional setup after loading the view.
}
//登录后
-(void)drawss{
    AVQuery *query = [AVQuery queryWithClassName:@"FM"];
    AVObject *post = [query getObjectWithId:self.temp];
    //设置cell
    NSMutableArray *arr =[[NSMutableArray alloc]initWithObjects:@"收藏列表",@"下载列表",@"最近收听",@"定时功能",@"设置",@"意见与反馈", nil];
    
    [self addArray:arr];
    //头像设置
    self.headImageView.image = [UIImage imageNamed:@"阿狸.jpg"];
    //背景设置
    self.imageBG.image = [UIImage imageNamed:@"BG.jpg"];
    //昵称设置
    NSString *name = [post objectForKey:@"name"];
    self.nameLabel.text = name;
    self.leftBtn.hidden = YES;
    //设置退出登录
    [self.rightBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action4Quit) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.frame = CGRectMake(0, 0, 100, 0);
    self.titleLabel.text = @"";
    self.tempID = self.temp;
}
-(void)action4Quit{
    NSLog(@"退出登录");
    AppDelegate *aaa = [[UIApplication sharedApplication] delegate];
    aaa.tempID = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
