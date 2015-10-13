//
//  DiscoverListCell.m
//  FM
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "DiscoverListCell.h"

@implementation DiscoverListCell

- (void)awakeFromNib {
    // Initialization code
}




- (void)setDiscoverListModel:(DiscoverListModel *)discoverListModel{
    
    self.lab4recordtitle.text = discoverListModel.record_title;
    
    NSString *str = [NSString stringWithFormat:@"%ld",discoverListModel.user_acount];
    self.lab4userAcount.text = str;
    
    self.lab4fileDuration.text = discoverListModel.record_file_duration;
    
    self.Lab4recordCreated.text = discoverListModel.record_created_at;
}

@end
