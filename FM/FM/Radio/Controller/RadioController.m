//
//  RadioController.m
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "RadioController.h"
#import "RadioViewCell.h"
#import "DetailViewController.h"
#import "Networking.h"
#import "PlayerModel.h"
#define url @"http://mobile.ximalaya.com/m/category_tag_list?category=radio&device=iPhone&type=album"

#define allURL @"http://mobile.ximalaya.com/m/explore_album_list?category_name=radio&condition=hot&device=iPhone&page=1&per_page=20&status=0&tag_name="

#define recentURL @"http://mobile.ximalaya.com/m/explore_album_list?category_name=radio&condition=recent&device=iPhone&page=1&per_page=20&status=0&tag_name="

@interface RadioController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic , strong) UICollectionView *CollectionView;

@property(nonatomic , strong) NSMutableArray *Array;

@property(nonatomic , strong) NSMutableDictionary *DIC;

@end

@implementation RadioController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.500 green:1.000 blue:0.709 alpha:1.000];
    self.navigationItem.title = @"电台";
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake((self.view.frame.size.width - 60) / 3, 80);
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //最小的上下间距
    flow.minimumLineSpacing = 10;
    //最小的左右间距
    flow.minimumInteritemSpacing = 20;
    _CollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flow];
    //colorWithRed:0.383 green:1.000 blue:0.801 alpha:1.000
    _CollectionView.backgroundColor = [UIColor colorWithRed:20/255.0 green:40/255.0 blue:120/255.0 alpha:1.000];
    [_CollectionView registerClass:[RadioViewCell class] forCellWithReuseIdentifier:@"cell"];
    _CollectionView.delegate = self;
    _CollectionView.dataSource = self;
    [self.view addSubview:_CollectionView];
    
    
    
    UIBarButtonItem *RightButton  = [[UIBarButtonItem alloc]initWithTitle:@"全部" style:UIBarButtonItemStyleDone target:self action:@selector(all)];
    self.navigationItem.rightBarButtonItem = RightButton;
    
    
    [self networking];
    
}

-(void)networking{
    _DIC = [NSMutableDictionary new];
    _Array = [NSMutableArray new];
    [Networking recivedDataWithURLString:url method:@"GET" body:nil block:^(id object) {
        NSDictionary *DataDic = (NSDictionary *)object;
        for (NSDictionary *dic in DataDic[@"list"]) {
            RadioModel *model = [RadioModel new];
            model.tname = dic[@"tname"];
            model.PicUrl = dic[@"cover_path"];
            [_Array addObject:model];
            [_DIC setObject:_Array forKey:DataDic[@"list"]];
      
        }
        [_CollectionView reloadData];
   
    }];
}

-(void)all{
    DetailViewController *detail = [DetailViewController new];
    detail.name = @"";
    [self.navigationController pushViewController:detail animated:YES];
   
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [DetailViewController new];
    NSString *key = _DIC.allKeys[indexPath.section];
    NSArray *arr = _DIC[key];
    RadioModel *mo = arr[indexPath.row];
    detail.name = mo.tname;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _Array.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _DIC.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RadioViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSString *key = _DIC.allKeys[indexPath.section];
    NSArray *arr = _DIC[key];
    RadioModel *mo = arr[indexPath.row];
    cell.RadioModel = mo;
    return  cell;
}
@end
