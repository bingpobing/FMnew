//
//  DiscoverListController.m
//  FM
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "DiscoverListController.h"
#import "PlayerController.h"

@interface DiscoverListController ()

@property (nonatomic,strong)NSMutableDictionary *valueDict;
@property (nonatomic,strong)NSMutableArray *valueArr;
@property (nonatomic,strong)NSMutableArray *valueArr_play;

//TableHeaderView左视图
@property (nonatomic,strong)UIImageView *imgViewUrl;
//主持
@property (nonatomic,strong)UILabel *lab4play_dj;
//电台
@property (nonatomic,strong)UILabel *lab4channel_name;
//简介
@property (nonatomic,strong)UILabel *lab4play_decription;


//刷新的当前页面
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation DiscoverListController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
    }
    return self;
}

#pragma mark ==============懒加载================

- (NSMutableDictionary *)valueDict{
    if (_valueDict == nil) {
        _valueDict = [NSMutableDictionary dictionary];
    }
    return _valueDict;
}

- (NSMutableArray *)valueArr{
    if (_valueArr == nil) {
        _valueArr = [NSMutableArray array];
    }
    return _valueArr;
}

- (NSMutableArray *)value_play{
    if (_valueArr_play
        == nil) {
        _valueArr_play = [NSMutableArray array];
    }
    return _valueArr_play;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self myTableHeaderViewDidLoad];
    
//    //返回按钮
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return32"] style:UIBarButtonItemStylePlain target:self action:@selector(returnPage)];
//    //收藏按钮
    //UIBarButtonItem *collectBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collect1"] style:UIBarButtonItemStylePlain target:self action:nil];
//    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:nil];
   // self.navigationItem.rightBarButtonItems = @[collectBtn];
    
    
    self.title = self.string;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscoverListCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    _currentPage = 0;
    [self requestDateCell];
    [self requestDateHeader];
    //下拉刷新
    __weak typeof (self)weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.tableView.frame = CGRectMake(0, 64, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height - 50);
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    }];
    //上拉加载
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        weakSelf.currentPage++;
        [weakSelf requestDateCell];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    
    }];
    

    
}

//返回

//- (void)returnPage{
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (void)myTableHeaderViewDidLoad{
    //TableHeaderView背景图片
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headerView02"]];
    imgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.3);
    //TableHeaderView左图片
    self.imgViewUrl = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.04, kScreenHeight * 0.06, kScreenWidth * 0.267, kScreenHeight * 0.15)];
    self.imgViewUrl.backgroundColor = [UIColor redColor];
    self.imgViewUrl.layer.cornerRadius = 3;
    self.imgViewUrl.layer.masksToBounds = YES;
    self.imgViewUrl.layer.borderWidth = 3;
    self.imgViewUrl.layer.borderColor = [UIColor blackColor].CGColor;
    [imgView addSubview:self.imgViewUrl];
    //主持
    self.lab4play_dj = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.4, kScreenHeight * 0.06, kScreenWidth * 0.4, kScreenHeight * 0.045)];
    self.lab4play_dj.font = [UIFont systemFontOfSize:15];
    [imgView addSubview:self.lab4play_dj];
    //电台
    self.lab4channel_name = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.4, kScreenHeight *0.097, kScreenWidth * 0.4, kScreenHeight * 0.045)];
    self.lab4channel_name.font = [UIFont systemFontOfSize:15];
    [imgView addSubview:self.lab4channel_name];
    
    //简介
    self.lab4play_decription = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.4, kScreenHeight * 0.135, kScreenWidth * 0.4, kScreenHeight * 0.12)];
    self.lab4play_decription.font = [UIFont systemFontOfSize:15];
    self.lab4play_decription.numberOfLines = 0;
    [imgView addSubview:self.lab4play_decription];
    
    
    
    self.tableView.tableHeaderView = imgView;

    
}
#pragma mark ================网路请求==================

- (void)requestDateCell{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://fmlive.shuoba.org/v3/playback/record_play/%@/detail_info?page_size=20&page_index=%ld",self.keyString,_currentPage]]];
    NSLog(@"%@",self.keyString);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict1 = dict[@"records_info"];
        NSArray *array = dict1[@"records"];
        for (NSDictionary *dict2 in array) {
            DiscoverListModel *model = [DiscoverListModel new];
            [model setValuesForKeysWithDictionary:dict2];
            [self.valueArr addObject:model];
            NSLog(@"%@",model);
        }
        
        [self.tableView reloadData];
    }];
    
}

- (void)requestDateHeader{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://fmlive.shuoba.org/v3/playback/record_play/%@/detail_info?page_size=20&page_index=0",self.keyString]]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict1 = dict[@"record_play_info"];
        
        DiscoverListModel *model = [DiscoverListModel new];
        [model setValuesForKeysWithDictionary:dict1];
        [self.valueArr_play addObject:model];
        
        NSLog(@"1111111图片111111:%@",model.record_play_image_url);
        
        //请求到图片
        [self.imgViewUrl sd_setImageWithURL:[NSURL URLWithString:model.record_play_image_url]];
        //主持
        self.lab4play_dj.text = [NSString stringWithFormat:@"主持: %@",model.record_play_dj];
        //电台
        self.lab4channel_name.text = [NSString stringWithFormat:@"电台: %@",model.channel_name];
        //简介
        self.lab4play_decription.text = [NSString stringWithFormat:@"简介: %@",model.record_play_decription];
        
        
        [self.tableView reloadData];
    }];
    

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.valueArr.count;
}
//cell区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
//区头上headerView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//系统区头设置添加

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headerView2"]];
    
    //添加左播放按钮
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    playBtn.frame = CGRectMake(15, 5, 35, 35);
    
    [playBtn setImage:[UIImage imageNamed:@"play48"] forState:UIControlStateNormal];
    
    //[playBtn setImage:[UIImage imageNamed:@"stop48"] forState:UIControlStateHighlighted];
    
    [imgView addSubview:playBtn];
    //添加文本
    UILabel *playCountLab = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, 150, 30)];
    
    playCountLab.text = [NSString stringWithFormat:@"播放全部(%ld期)",self.valueArr.count];
    
    [imgView addSubview:playCountLab];
//    //添加下载和排序按钮
//    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    downloadBtn.frame = CGRectMake(250, 10, 50, 30);
//    
//    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
//    
//    [downloadBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
//    
//    [imgView addSubview:downloadBtn];
//    
//    UIButton *rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    rankBtn.frame = CGRectMake(310,10, 50, 30);
//    
//    [rankBtn setTitle:@"排序" forState:UIControlStateNormal];
//    
//    [rankBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
//    
//    [imgView addSubview:rankBtn];
    
    
    
    return imgView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DiscoverListModel *model = self.valueArr[indexPath.row];
    
    cell.discoverListModel = model;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayerController *playerVC = [[PlayerController alloc]init];
    
    DiscoverListModel *model = self.valueArr[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:model.record_image_url];
    playerVC.PicUrl = url;
    playerVC.radioTitle = model.record_title;
    playerVC.nickname = model.record_name;
    playerVC.duration = model.record_file_duration;
    playerVC.playPathAacv224 = model.record_file_url;
    playerVC.file_m4a_url = model.file_m4a_url;
    playerVC.file_low_url = model.file_low_url;
    playerVC.musicArray = [self.valueArr mutableCopy];
    playerVC.str = (int)indexPath.row;
    playerVC.tag = @"1000";
    [self showDetailViewController:playerVC sender:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
