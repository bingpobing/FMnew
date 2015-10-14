//
//  download.h
//  FM
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TCBlobDownload/TCBlobDownload.h>
@interface download : NSObject<TCBlobDownloaderDelegate>


@property (nonatomic,strong)NSString *string;
- (void)deleteFileWithFileName:(NSString *)name;
- (void)downloadWithUrl:(NSString *)url start:(TCBlobDownloadManager *)DownloadManager radioTitle:(NSString *)radioTitle nickname:(NSString *)nickname PicUrl:(NSString *)PicUrl playPathAacv224:(NSString *)playPathAacv224;

@end
