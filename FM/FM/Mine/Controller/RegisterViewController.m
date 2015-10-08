//
//  RegisterViewController.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "RegisterViewController.h"
#import "XWAlterview.h"
#import <AVOSCloud/AVOSCloud.h>
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt4Name;
@property (weak, nonatomic) IBOutlet UITextField *txt4Password;
@property (weak, nonatomic) IBOutlet UITextField *txt4Password2;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
}
- (IBAction)action4Register:(id)sender {
    AVObject *Post = [AVObject objectWithClassName:@"FM"];
    [Post setObject:self.txt4Name.text forKey:@"name"];
    [Post setObject:self.txt4Password.text forKey:@"password"];
    [Post setObject:self.txt4Password2.text forKey:@"passwords"];
    AVQuery *query = [AVQuery queryWithClassName:@"FM"];
    NSArray *arr = [query findObjects];
    int cou = 0;
    for (NSDictionary *dic in arr) {
        cou++;
        if ([dic[@"name" ] isEqualToString:self.txt4Name.text]) {
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"注册失败" contentText:@"用户名已被占用,请重新注册" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
            
            alter.rightBlock=^()
            {
                NSLog(@"右边按钮被点击");
            };
            alter.leftBlock=^()
            {
                
                NSLog(@"左边按钮被点击");
            };
            alter.dismissBlock=^()
            {
                self.view.alpha = 1;
                
                NSLog(@"窗口即将消失");
            };
            [alter show];
            break;
            
            
        }else if(cou == arr.count){
            [Post save];
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"注册成功" contentText:@"请重新登录?" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
            
            alter.rightBlock=^()
            {
                NSLog(@"右边按钮被点击");
            };
            alter.leftBlock=^()
            {
                [self.navigationController popViewControllerAnimated:YES];
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
