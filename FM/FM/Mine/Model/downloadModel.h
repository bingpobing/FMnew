//
//  downloadModel.h
//  FM
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface downloadModel : NSObject

@property (nonatomic,assign) NSInteger ID;
//作者
@property (nonatomic,strong) NSString *people;
//电台名
@property (nonatomic,strong) NSString *musicName;
//图片
@property (nonatomic,strong) NSString *imgUrl;
//电台地址
@property (nonatomic,strong)NSString *playPath;
//存储名称
@property (nonatomic,strong) NSString *nameOfSave;
//去数据库中创建表格
+ (void)creatTable;
//查找所有音乐
+ (NSMutableArray *)arrMusic;

+ (downloadModel *)modelWithMusicName: (NSString *)musicName people:(NSString*)people imgUrl: (NSString *)imgUrl playPath: (NSString *)playPath nameOfSave : (NSString *)nameOfSave;

//插入
- (void) insertToTable;
//删除
- (void) deleteToTable;
@end
