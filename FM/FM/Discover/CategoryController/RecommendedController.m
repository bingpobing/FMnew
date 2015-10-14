//
//  RecommendedController.m
//  FM
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "RecommendedController.h"


@interface RecommendedController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,CarouselFingureDelegate>

@property (nonatomic,strong)NSMutableDictionary *valuedict;
//轮播图~
@property (nonatomic,strong)NSMutableArray *imageArray;


@property (nonatomic,strong)UICollectionView *collection;

@end

@implementation RecommendedController

#pragma mark ===============懒加载====================

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableDictionary *)valuedict
{
    if (_valuedict== nil) {
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
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 180, kScreenWidth, kScreenHeight - 335) collectionViewLayout:layout];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    [self.collection registerNib:[UINib nibWithNibName:@"DiscoverCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //[self.collection registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //自定义header
    [self.collection registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    [self.collection registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    
    
    
    
    [self.view addSubview:self.collection];
    
    
    [self request];
    
}

#pragma mark ============json网络请求==================
- (void)request{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:chooseURL]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        //
        self.valuedict  = [dict mutableCopy];
        //轮播图片请求
        NSArray *array = dict[@"banner"];
        
        for (NSDictionary *bannerDict in array) {
            
            DiscoverModel *model = [[DiscoverModel alloc]init];
            [model setValuesForKeysWithDictionary:bannerDict];
            
            //调用图片请求的方法
            UIImage *img = [self requestImageWithUrl:model.banner_image_url];
            [self.imageArray addObject:img];
            
            
        }
        CarouselFingure *cView = [[CarouselFingure alloc]initWithFrame:CGRectMake(0, 0, 375, 180)];
        cView.imagesArray = self.imageArray;
        cView.duration=2;
        cView.delegate = self;
        cView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:cView];
        
        [self.collection reloadData];
    }];
    
}

//图片请求
-(UIImage *)requestImageWithUrl:(NSString *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    UIImage *img = [UIImage imageWithData:data];
    return img;
}

#pragma mark ========= 代理必须实现的方法=======

//分区的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSArray *array = self.valuedict[@"top"];
    return array.count;
}

//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *array = self.valuedict[@"top"];
    NSDictionary *dic = array[section];
    NSArray *arr = dic[@"top_info"];
    return arr.count;
    
}
//item

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DiscoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *array = self.valuedict[@"top"];
    NSDictionary *dic = array[indexPath.section];
    NSArray *arr = dic[@"top_info"];
    NSDictionary *dic1 = arr[indexPath.row];
    NSString *urlImgStr = dic1[@"record_play_image_url"];
    NSString *nameStr = dic1[@"record_play_name"];
    NSString *summarizeStr = dic1[@"record_play_summarize"];
    [cell.img4play_url sd_setImageWithURL:[NSURL URLWithString:urlImgStr]];
    cell.lab4play_name.text =nameStr;
    cell.lab4play_summarize.text =summarizeStr;
    
    return cell;
    
}


#pragma mark ===================区头和区尾========================
//返回一个头或者尾

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeaderView * header =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        
        NSArray *array = self.valuedict[@"top"];
        NSDictionary *dic = array[indexPath.section];
        NSString *headerStr = dic[@"top_name"];
        header.lab4headerName.text = headerStr;
        
        return header;
        
    } else {
        
        UICollectionReusableView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor greenColor];
        return footer;
        
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(375, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscoverListController *disListVC = [DiscoverListController new];
    
    
    NSArray *array = self.valuedict[@"top"];
    NSDictionary *dic = array[indexPath.section];
    NSArray *arr = dic[@"top_info"];
    NSDictionary *dic1 = arr[indexPath.row];
    NSString *nameStr = dic1[@"record_play_name"];
    
    NSString *keyStr = dic1[@"record_play_key"];
    
    disListVC.keyString = keyStr;
    disListVC.string = nameStr;
    
    
    
    
    [self showViewController:disListVC sender:nil];
    
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
