//
//  DatabaseManager.h
//  FM
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DatabaseManager : NSObject
+ (DatabaseManager *)sharedManager;

//打开数据库,并且返回一个数据库句柄
- (sqlite3 *)openDB;

- (void)closeDB;

@end
