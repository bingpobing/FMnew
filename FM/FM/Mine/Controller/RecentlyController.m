//
//  RecentlyController.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "RecentlyController.h"
#import "CollectCell.h"
#import "RecentlyViewCell.h"
#import "FMmodel.h"
@interface RecentlyController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *array;
@end

@implementation RecentlyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最近收听";
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[RecentlyViewCell class] forCellReuseIdentifier:@"icell"];
    //防止tableview上面有空白
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //查询音乐
    self.array = [FMmodel arrMusic];
    
    [self.view addSubview:tableview];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---tableview---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return @"电台";
//    }else{
//        return @"节目";
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecentlyViewCell *cell = [[RecentlyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"icell"];
    cell.lab4Name.text = self.array[indexPath.row];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSArray *)array{
    if (_array) {
        _array = [NSArray array];
    }
    return _array;
}
@end
