//
//  ListViewController.m
//  FM
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "ListViewController.h"
#import "AFNetworking.h"
#import "ListCell.h"
#import "ListModel.h"
#import "PlayerController.h"


#define URL @"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/1/30?device=iPhone"

@interface ListViewController ()

@property(nonatomic , strong) NSMutableArray *Array;

@property(nonatomic , strong) NSMutableDictionary *DIC;

@end


@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self networking];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.separatorColor = [UIColor whiteColor];
    [self.tableView registerClass:[ListCell class] forCellReuseIdentifier:@"cell"];
  
 
}

-(void)networking{
    _DIC = [NSMutableDictionary new];
    _Array = [NSMutableArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:[NSString stringWithFormat:URL,_ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *Dic in responseObject[@"tracks"][@"list"]) {
            ListModel *model = [ListModel new];
            model.PicUrl = Dic[@"coverLarge"];
            model.title = Dic[@"title"];
            model.nickname = Dic[@"nickname"];
            model.playtime = [NSString stringWithFormat:@"%@",Dic[@"playtimes"]];
            model.likes = [NSString stringWithFormat:@"%@",Dic[@"likes"]];
            model.duration = [NSString stringWithFormat:@"%@",Dic[@"duration"]];
            
            model.playPathAacv224 = Dic[@"playPathAacv224"];//电台地址
            model.downloadUrl = Dic[@"downloadUrl"];//电台下载地址
            
            [_Array addObject:model];
            [_DIC setObject:_Array forKey:responseObject[@"tracks"][@"list"]];
              [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
    }];
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _DIC.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _Array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *key = _DIC.allKeys[indexPath.section];
    NSArray *arr = _DIC[key];
    ListModel *model = arr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:0.234 green:0.560 blue:1.000 alpha:1.000];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *key = self.DIC.allKeys[indexPath.section];
    NSArray *array =self.DIC[key];
    
    ListModel *model = array[indexPath.row];
    
    PlayerController *playerVC = [[PlayerController alloc]init];
    
    playerVC.PicUrl = model.PicUrl;
    playerVC.radioTitle = model.title;
    playerVC.nickname = model.nickname;
    playerVC.duration = model.duration;
    playerVC.playPathAacv224 = model.playPathAacv224;
    playerVC.file_m4a_url = model.downloadUrl;
    
    playerVC.str = (int)indexPath.row;
    playerVC.musicArray = [self.DIC[self.DIC.allKeys[indexPath.section]] mutableCopy];
    playerVC.tag = @"2000";
    
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
