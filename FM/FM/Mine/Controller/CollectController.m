//
//  CollectController.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "CollectController.h"
#import "CollectCell.h"
#import "FMmodel.h"
#import <AVOSCloud/AVOSCloud.h>
@interface CollectController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *array;
@property(nonatomic,strong) NSArray *nameArr;
@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[CollectCell class] forCellReuseIdentifier:@"cell"];
    //防止tableview上面有空白
    self.edgesForExtendedLayout = UIRectEdgeNone;
   
    //查询音乐
    AVQuery *query = [AVQuery queryWithClassName:@"FM"];
    AVObject *post = [query getObjectWithId:self.temID];

    self.nameArr = [post objectForKey:@"musicName"];
    

    
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---tableview---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArr.count;
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
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell *cell = [[CollectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.lab4Name.text = self.nameArr[indexPath.row];
//    cell.lab4Name.text = @"1";
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
    if (_array == nil) {
        _array = [NSArray array];
    }
    return _array;
}
-(NSArray *)nameArr{
    if (_nameArr ==nil) {
        _nameArr = [NSArray array];
    }
    return _nameArr;
}
@end
