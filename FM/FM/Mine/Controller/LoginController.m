//
//  LoginController.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "LoginController.h"
#import "RegisterViewController.h"
#import "XWAlterview.h"
#import "LoginMineController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"
@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIButton *btn4Login;
@property (weak, nonatomic) IBOutlet UIButton *btn4Register;
@property (weak, nonatomic) IBOutlet UITextField *lab4Name;
@property (weak, nonatomic) IBOutlet UITextField *lab4Password;


@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    //注册按钮事件
    [self.btn4Register addTarget:self action:@selector(changeToRegister:) forControlEvents:UIControlEventTouchUpInside];
}
//点击注册按钮的事件
- (void)changeToRegister:(id)sender{
    //跳转到注册页面
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}
//登录事件
- (IBAction)action4Login:(id)sender {
    AVQuery *query = [AVQuery queryWithClassName:@"FM"];
    NSArray *arr = [query findObjects];
    int cou = 0;
    self.objId = nil;
    for (NSDictionary *dic in arr) {
        cou++;
        if ([dic[@"name"]  isEqualToString: self.lab4Name.text]) {
            if ([dic[@"password"] isEqualToString: self.lab4Password.text])
            {
                LoginMineController *loginmineVC = [LoginMineController new];
                NSLog(@"%@",dic);
                self.objId = dic[@"objectId"];
                loginmineVC.temp = self.objId;
                AppDelegate *aaa = [[UIApplication sharedApplication] delegate];
                aaa.tempID = YES;
                NSLog(@"成功");
                self.lab4Password.text = @"";
                self.lab4Name.text = @"";
                [self.navigationController pushViewController:loginmineVC animated:YES];
                break;
            }
            else{
                self.view.alpha = 0.3;
                XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"登录失败" contentText:@"用户名密码或账号，请重新登录?" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
                alter.rightBlock=^()
                {
                    NSLog(@"右边按钮被点击");
                };
                alter.leftBlock=^()
                {
                    self.lab4Password.text = @"";
                    self.lab4Name.text = @"";
                    
                    NSLog(@"左边按钮被点击");
                };
                alter.dismissBlock=^()
                {
                    self.view.alpha = 1;
                    
                    NSLog(@"窗口即将消失");
                };
                [alter show];
            }
            
            
        }else if(cou == arr.count){
            self.view.alpha = 0.3;
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"登录失败" contentText:@"用户名密码或账号，请重新登录?" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
            alter.rightBlock=^()
            {
                NSLog(@"右边按钮被点击");
            };
            alter.leftBlock=^()
            {
                self.lab4Password.text = @"";
                self.lab4Name.text = @"";
                
                NSLog(@"左边按钮被点击");
            };
            alter.dismissBlock=^()
            {
                self.view.alpha = 1;
                
                NSLog(@"窗口即将消失");
            };
            [alter show];
            
        }
    }
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
