//
//  CollectCell.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "CollectCell.h"
#import "SCModel.h"
#import "UIImageView+WebCache.h"
@implementation CollectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SCModel *)model{
    NSString *url = model.imgUrl;
    self.lab4Name.numberOfLines = 0;
    self.lab4Name.text = model.musicName;
    [self.img4Name sd_setImageWithURL:[NSURL URLWithString:url]];
}

@end
