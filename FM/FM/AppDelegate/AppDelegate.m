//
//  AppDelegate.m
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"
#import "DiscoverController.h"
#import "RadioController.h"
#import "MineController.h"

@interface AppDelegate ()<UIScrollViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    


    
    [AVOSCloud setApplicationId:@"gygk6k80xeVgrlVM2PkeEzsW"
                      clientKey:@"PupC2Jsgb9wzzaDOuyW8hExC"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    //1
    DiscoverController *discoverVC = [[DiscoverController alloc]init];
    UINavigationController *discoverNC = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    discoverVC.title = @"发现";
    UIImage *image1 = [UIImage imageNamed:@"faxian"];
    discoverVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:image1 selectedImage:image1];

    //2
    RadioController *radioVC = [[RadioController alloc]init];
    UINavigationController *RadioNC = [[UINavigationController alloc]initWithRootViewController:radioVC];
    radioVC.title = @"电台";
    UIImage *image2 = [UIImage imageNamed:@"diantai"];
    radioVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"电台" image:image2 selectedImage:image2];
    
    //3
    MineController *mineVC = [MineController new];
    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    mineVC.title = @"我的";
    UIImage *image4 = [UIImage imageNamed:@"mine"];
    mineVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:image4 selectedImage:image4];
    

    
    NSArray *allNC = @[discoverNC,RadioNC,mineNC];
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
    
    tabBarVC.viewControllers = allNC;
    
    tabBarVC.tabBar.tintColor = [UIColor orangeColor];
    
    self.window.rootViewController = tabBarVC;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //启动图
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //判断滑动图是否出现过,第一次调用时"isScrollViewAppear"这个key对应的值是nil，会进入if中
    if (![@"YES" isEqualToString:[userDefaults objectForKey:@"isScrollViewAppear"]]) {
        //显示滑动图
        [self showScrollView];
    }
    
    return YES;
}


-(void) showScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置UIScrollView 的显示内容的尺寸，有n张图要显示，就设置 屏幕宽度*n ，这里假设要显示4张图
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height);
    
    scrollView.tag = 100;
    
    //设置翻页效果，不允许反弹，不显示水平滑动条，设置代理为自己
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //在UIScrollView 上加入 UIImageView
    for (int i = 0 ; i < 4; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i , 0, kScreenWidth, kScreenHeight)];
        
        //将要加载的图片放入imageView 中
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        imageView.image = image;
        
        [scrollView addSubview:imageView];
    }
    
    //初始化 UIPageControl 和 _scrollView 显示在 同一个页面中
    UIPageControl *pageConteol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    pageConteol.center = CGPointMake(kScreenWidth/2, kScreenHeight/1.1);
    pageConteol.numberOfPages = 4;
    //未选中圆点的颜色
    pageConteol.pageIndicatorTintColor = [UIColor orangeColor];
    //选中圆点的颜色
    pageConteol.currentPageIndicatorTintColor = [UIColor greenColor];//现在的;通用的;最近的
    pageConteol.tag = 200;
    
    [self.window addSubview:scrollView];
    [self.window addSubview: pageConteol];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取pageControl
    UIPageControl *pageControl = (UIPageControl *)[self.window viewWithTag:200];
    //根据偏移量来控制currentPage
    pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
    
    //当显示到最后一页时，让滑动图消失
    if (pageControl.currentPage == 3) {
        
        //调用方法，使滑动图消失
        [self scrollViewDisappear];
    }
}
-(void)scrollViewDisappear{
    
    //拿到 window 中的 UIScrollView 和 UIPageControl
    UIScrollView *scrollView = (UIScrollView *)[self.window viewWithTag:100];
    UIPageControl *page = (UIPageControl *)[self.window viewWithTag:200];
    
    //设置滑动图消失的动画效果图
    [UIView animateWithDuration:3.0f animations:^{
        
        scrollView.center = CGPointMake(self.window.frame.size.width/2, 1.5 * self.window.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [scrollView removeFromSuperview];
        [page removeFromSuperview];
    }];
    
    //将滑动图启动过的信息保存到 NSUserDefaults 中，使得第二次不运行滑动图
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"YES" forKey:@"isScrollViewAppear"];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
