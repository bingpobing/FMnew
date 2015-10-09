//
//  DatabaseManager.m
//  FM
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager
//创建单例,用来操作数据库
static DatabaseManager *manager = nil;
+ (DatabaseManager *)sharedManager{
    if (nil == manager) {
        manager = [[DatabaseManager alloc] init];
    }
    return manager;
}

static sqlite3 *db = nil;
//打开数据库
- (sqlite3 *)openDB{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingString:@"FM.sqlite"];
    NSLog(@"%@",path);
    int result = sqlite3_open(path.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    return db;
}
//关闭数据库
- (void)closeDB{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
    db = nil;
}
@end
