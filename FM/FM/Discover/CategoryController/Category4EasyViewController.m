//
//  Category4EasyViewController.m
//  FM
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "Category4EasyViewController.h"

@interface Category4EasyViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,CarouselFingureDelegate>

@property (nonatomic,strong)UICollectionView *collection;

@property (nonatomic,strong)NSMutableDictionary *valuedict;



@end

@implementation Category4EasyViewController

- (instancetype)initWithNSInteger:(NSInteger)Nsmuber{
    if (self = [super init]) {
        [self requestWithNumber:Nsmuber];
    }
    return self;
}
#pragma mark ==============懒加载==============
- (UICollectionView *)collection{
    if (_collection == nil) {
        _collection = [UICollectionView new];
    }
    return _collection;
}
- (NSMutableDictionary *)valuedict{
    if (_valuedict == nil) {
        _valuedict = [NSMutableDictionary new];
    }
    return _valuedict;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //创建集合视图
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(120, 150);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    layout.headerReferenceSize = CGSizeMake(375, 30);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, self.view.frame.size.height) collectionViewLayout:layout];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    //自定义cell
    [self.collection registerNib:[UINib nibWithNibName:@"DiscoverCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //自定义header
    [self.collection registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //系统footer
    [self.collection registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.view addSubview:self.collection];
    
}
#pragma mark ==============Json网络请求=================

- (void)requestWithNumber:(NSInteger)number{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:allTypeURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //
        self.valuedict = [dict mutableCopy];

        //刷新
        [self.collection reloadData];
    }];
}


#pragma mark =============代理必须实现的方法=================

//分区的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSArray *array = self.valuedict[@"top"];
    return array.count;
}
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.valuedict[@"top"];
    NSDictionary *dict = array[section];
    NSArray *array1 = dict[@"top_info"];
    return array1.count;
}

//返回cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *array = self.valuedict[@"top"];
    NSDictionary *dict = array[indexPath.section];
    NSArray *array1 = dict[@"top_info"];
    NSDictionary *dict1 = array1[indexPath.row];
    NSString *urlImgStr = dict1[@"record_play_image_url"];
    NSString *nameStr = dict1[@"record_play_name"];
    NSString *summarizeStr = dict1[@"record_play_summarize"];
    [cell.img4play_url sd_setImageWithURL:[NSURL URLWithString:urlImgStr]];
    cell.lab4play_name.text = nameStr;
    cell.lab4play_summarize.text = summarizeStr;
    
    return cell;
    
}

#pragma mark ===============区头,区尾===========

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        NSArray *array = self.valuedict[@"top"];
        NSDictionary *dict = array[indexPath.section];
        NSString *headerStr = dict[@"top_name"];
        headerView.lab4headerName.text = headerStr;
        return headerView;
        
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        return footerView;
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(375, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverListController *discListVC = [[DiscoverListController alloc]init];
    
    NSArray *array = self.valuedict[@"top"];
    NSDictionary *dic = array[indexPath.section];
    NSArray *arr = dic[@"top_info"];
    NSDictionary *dic1 = arr[indexPath.row];
    NSString *nameStr = dic1[@"record_play_name"];
    
    NSString *keyStr = dic1[@"record_play_key"];
    
    discListVC.keyString = keyStr;
    discListVC.string = nameStr;
    
    
    [self showViewController:discListVC sender:nil];
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
