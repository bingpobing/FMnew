//
//  download.m
//  FM
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "download.h"
#import "downloadModel.h"
#import "PlayerController.h"

@implementation download

- (void)downloadWithUrl:(NSString *)url start:(TCBlobDownloadManager *)DownloadManager radioTitle:(NSString *)radioTitle nickname:(NSString *)nickname PicUrl:(NSString *)PicUrl playPathAacv224:(NSString *)playPathAacv224{
    // Blocks
    [DownloadManager startDownloadWithURL:[NSURL URLWithString:url]  customPath:[NSString pathWithComponents:@[NSTemporaryDirectory(), @"example"]]firstResponse:NULL progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
        if (remainingTime != -1) {
            //            [self.remaingTime setText:[NSString stringWithFormat:@"%lds", (long)remainingTime]];
        }
    }
                                    error:^(NSError *error) {
                                        NSLog(@"%@", error);
                                    }
                                 complete:^(BOOL downloadFinished, NSString *pathToFile) {
                                     //                                                NSString *str = downloadFinished ? @"Completed" : @"Cancelled";
                                    
                                     NSArray *arry = [pathToFile componentsSeparatedByString:@"example/"];
                                     NSLog(@"name:%@",arry[1]);
                                     
                                     NSLog(@"path:%@",pathToFile);
                                     
                                    
                                     [downloadModel creatTable];
                                    
                                     downloadModel *model = [downloadModel modelWithMusicName:radioTitle people:nickname imgUrl:PicUrl playPath:playPathAacv224 nameOfSave:arry[1]];
                                     
                                         [model insertToTable];
                                     
                                     //                                                [self.remaingTime setText:str];
                                 }];
    //    [self.urlField resignFirstResponder];
    
}
#pragma mark - TCBlobDownloaderDelegate


- (void)download:(TCBlobDownloader *)blobDownload didReceiveFirstResponse:(NSURLResponse *)response
{
    
}

- (void)download:(TCBlobDownloader *)blobDownload
  didReceiveData:(uint64_t)receivedLength
         onTotal:(uint64_t)totalLength
{
    
}

- (void)download:(TCBlobDownloader *)blobDownload didStopWithError:(NSError *)error
{
    
}

- (void)download:(TCBlobDownloader *)blobDownload didCancelRemovingFile:(BOOL)fileRemoved
{
    
}

- (void)download:(TCBlobDownloader *)blobDownload didFinishWithSuccess:(BOOL)downloadFinished atPath:(NSString *)pathToFile
{
    
}

@end
