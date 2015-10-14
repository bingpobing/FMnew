//
//  RecentlyViewController.m
//  FM
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "RecentlyViewController.h"
#import "FMmodel.h"
#import "RecentlyViewCell.h"
#import "PlayerController.h"
@interface RecentlyViewController ()
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) RecentlyViewCell *cell;
@property(nonatomic,strong) UIBarButtonItem *rightBtn;
@end

@implementation RecentlyViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //查询音乐
        NSMutableArray *arr =[FMmodel arrMusic];
        self.array = arr;
        
    }
    return self;
}
-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.title = @"最近收听";
    self.rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(deleteArr:)];
    self.navigationItem.rightBarButtonItem = self.rightBtn;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RecentlyViewCell" bundle:nil] forCellReuseIdentifier:@"rectcell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"rectcell" forIndexPath:indexPath];
    self.cell.model = self.array[indexPath.row];
 
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    PlayerController *palyVC = [PlayerController new];
   
    palyVC.playModel = self.array[indexPath.row];
   
    [self showDetailViewController:palyVC sender:nil];
}
//删除
-(void)deleteArr:(id)sender{
    static int n = 0;
    if ((n % 2) == 0) {
        self.rightBtn.title = @"完成";
        n++;
    }else{
        self.rightBtn.title = @"编辑";
        n++;
    }
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
}
//tableview删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FMmodel *moe = [FMmodel new];
    moe = self.array[indexPath.row];
    [moe deleteToTable];
    [self.array removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
   
}


@end
