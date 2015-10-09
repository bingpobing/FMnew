//
//  DiscoverController.m
//  FM
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "DiscoverController.h"

@interface DiscoverController ()

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    //带轮播图
    RecommendedController *oneViewController = [[RecommendedController alloc] init];
    oneViewController.title = @"推荐";
    oneViewController.view.backgroundColor = [UIColor brownColor];
    
    Category4ScrollViewController *twoViewController = [[Category4ScrollViewController alloc] initWithNSInteger:3];
    twoViewController.title = @"音乐";
    twoViewController.view.backgroundColor = [UIColor purpleColor];
    
    Category4ScrollViewController *threeViewController = [[Category4ScrollViewController alloc] initWithNSInteger:4];
    threeViewController.title = @"资讯";
    threeViewController.view.backgroundColor = [UIColor orangeColor];
    
    Category4ScrollViewController *fourViewController = [[Category4ScrollViewController alloc] initWithNSInteger:2];
    fourViewController.title = @"娱乐";
    fourViewController.view.backgroundColor = [UIColor magentaColor];
    
    Category4ScrollViewController *fiveViewController = [[Category4ScrollViewController alloc] initWithNSInteger:6];
    fiveViewController.title = @"财经";
    fiveViewController.view.backgroundColor = [UIColor yellowColor];
    
    
    
    //无轮播图
    Category4EasyViewController *sixViewController = [[Category4EasyViewController alloc] initWithNSInteger:11];
    sixViewController.title = @"文化";
    sixViewController.view.backgroundColor = [UIColor cyanColor];
    
    //    NoWheelViewController *sevenViewController = [[NoWheelViewController alloc] initWithNSInteger:9];
    //    sevenViewController.title = @"生活";
    //    sevenViewController.view.backgroundColor = [UIColor blueColor];
    
    Category4EasyViewController *eightViewController = [[Category4EasyViewController alloc] initWithNSInteger:10];
    eightViewController.title = @"体育";
    eightViewController.view.backgroundColor = [UIColor greenColor];
    
    Category4EasyViewController *nineghtViewController = [[Category4EasyViewController alloc] initWithNSInteger:7];
    nineghtViewController.title = @"故事";
    nineghtViewController.view.backgroundColor = [UIColor redColor];
    
    Category4EasyViewController *tenViewController = [[Category4EasyViewController alloc]initWithNSInteger:5];
    tenViewController.title = @"情感";
    tenViewController.view.backgroundColor = [UIColor magentaColor];
    
    Category4EasyViewController *elevenViewController = [[Category4EasyViewController alloc]initWithNSInteger:12];
    elevenViewController.title = @"校园";
    elevenViewController.view.backgroundColor = [UIColor yellowColor];
    
    Category4EasyViewController *twelveViewController = [[Category4EasyViewController alloc]initWithNSInteger:8];
    twelveViewController.title = @"汽车";
    twelveViewController.view.backgroundColor = [UIColor blueColor];
    
    
    SCNavTabBarController *SCNavTabBar = [[SCNavTabBarController alloc]init];
    SCNavTabBar.subViewControllers = @[oneViewController,twoViewController,threeViewController,fourViewController,fiveViewController,sixViewController,eightViewController,nineghtViewController,tenViewController,elevenViewController,twelveViewController];
    SCNavTabBar.showArrowButton = YES;
    [SCNavTabBar addParentController:self];
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
