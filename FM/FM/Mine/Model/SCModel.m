//
//  SCModel.m
//  FM
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "SCModel.h"
#import "DataManager.h"
#import <sqlite3.h>
@implementation SCModel
+(void)creatTable{
    //拿到数据柄
    sqlite3 *db = [[DataManager sharedManager] openDB];
    
    //设置主键:id
    NSString *sqlstr = @"create table SC (id integer primary key autoincrement not null,musicName text,people text ,imgUrl text,playPath text);";
    
    int result = sqlite3_exec(db, sqlstr.UTF8String, nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"创建SC表成功");
    }else{
        NSLog(@"创建SC表失败");
    }
    //关闭数据库
    [[DataManager sharedManager] closeDB];
}
+(SCModel *)modelWithMusicName:(NSString *)musicName  people:(NSString *)people imgUrl:(NSString *)imgUrl playPath: (NSString *)playPath {
    SCModel *model = [[SCModel alloc]init];
    model.musicName = musicName;
    model.people = people;
    model.imgUrl = imgUrl;
    model.playPath = playPath;
    
    return model;
}
+(NSMutableArray *)arrMusic{
    sqlite3 *db = [[DataManager sharedManager] openDB];
    NSString *sqlstr = @"select * from SC";
    //用户存放获取的数据
    NSMutableArray *arr = [NSMutableArray array];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, sqlstr.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        NSLog(@"sql语句转stmt成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int ID = sqlite3_column_int(stmt, 0);//第一列
            
            NSString *strname =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];//第二列
            NSString *strpeople = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];//第三列
            NSString *strimg = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];//第四列
            NSString *strplayPath =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            
            //构造FM
            SCModel *model = [SCModel modelWithMusicName:strname people:strpeople imgUrl:strimg playPath:strplayPath];
            model.ID = ID;
            //将FM装到数组中去
            [arr addObject:model];
        }
    }
    //释放stmt
    sqlite3_finalize(stmt);
    [[DataManager sharedManager] closeDB];
    return arr;
}
//插入
-(void)insertToTable{
    sqlite3 *db = [[DataManager sharedManager] openDB];
    NSString *sqlstr = [NSString stringWithFormat:@"insert into SC (musicName,people,imgUrl,playPath) values ('%@','%@','%@','%@');",self.musicName,self.people,self.imgUrl,self.playPath];
    //执行语句
    int result = sqlite3_exec(db, sqlstr.UTF8String, nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"%@ 插入成功",self.musicName);
    }else{
        NSLog(@"%@ 插入失败",self.musicName);
    }
    [[DataManager sharedManager] closeDB];
    
}
- (void)deleteToTable{
    sqlite3 *db = [[DataManager sharedManager] openDB];
    NSString *sqlstr = [NSString stringWithFormat:@"delete from SC where musicName = '%@'",self.musicName];
    int result = sqlite3_exec(db, sqlstr.UTF8String, nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"%@ 删除成功",self.musicName);
    }else{
        NSLog(@"%@ 删除失败",self.musicName);
    }
    [[DataManager sharedManager] closeDB];
}
- (NSString *)description
{
    
    return [NSString stringWithFormat:@"name: %@,people:%@ imgUrl:%@ playPath:%@", self.musicName,self.people,self.imgUrl,self.playPath];
}

@end
