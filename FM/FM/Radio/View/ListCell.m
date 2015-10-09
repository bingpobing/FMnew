//
//  ListCell.m
//  FM
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "ListCell.h"
#import "UIImageView+WebCache.h"

@implementation ListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self draw];
    }
    return self;
}

-(void)draw{
    _albumImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    _albumImage.layer.masksToBounds = YES;
    _albumImage.layer.cornerRadius = 30;
    [self.contentView addSubview:_albumImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0,295 , 40)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 33, 200, 20)];
    _nicknameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_nicknameLabel];
    
    _playtimesLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 60, 80, 20)];
    _playtimesLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_playtimesLabel];
    
    _likesLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 60, 80, 20)];
    _likesLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_likesLabel];
    
    _durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 60, 100, 20)];
    _durationLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_durationLabel];
    
    
}

-(void)setModel:(ListModel *)model{
    if (_model != model) {
        _model = model;
    }
    [_albumImage sd_setImageWithURL:model.PicUrl];
    _titleLabel.text = model.title;
    _nicknameLabel.text = [NSString stringWithFormat:@"By  %@",model.nickname];
    _playtimesLabel.text = [NSString stringWithFormat:@"▷ %@",model.playtime];
    _likesLabel.text = [NSString stringWithFormat:@"❤︎  %@",model.likes];
    NSInteger time = [model.duration floatValue];
    NSInteger time2 = time / 3600;
    NSInteger time3 = (time - time2 * 3600) / 60 ;
    NSInteger time4 = time - time2 * 3600 - time3 * 60 ;
   
    _durationLabel.text = [NSString stringWithFormat:@"🕒 %ld:%02ld:%02ld",time2,time3,time4];
 
    
    
    

}


@end
