//
//  MineController.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "MineController.h"


@interface MineController ()

@end

@implementation MineController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"我的";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self draw];
    

}
//未登录
-(void)draw{
    //头像设置
    self.headImageView.image = [UIImage imageNamed:@"阿狸.jpg"];
    //背景设置
    self.imageBG.image = [UIImage imageNamed:@"BG.jpg"];
    //昵称设置
    self.nameLabel.text = @"未登录";
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.titleLabel.text = @"";
    NSMutableArray *arr =[[NSMutableArray alloc]initWithObjects:@"登录",@"收藏列表",@"下载列表",@"最近收听",@"定时功能",@"设置",@"意见与反馈", nil];
    
    [self addArray:arr];
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
