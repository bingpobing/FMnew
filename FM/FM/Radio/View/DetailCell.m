//
//  DetailCell.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"

@implementation DetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self draw];
    }
    return self;
}

-(void)draw{
    _IMG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.contentView addSubview:_IMG];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 300, 30)];
    _title.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_title];
    
    _number = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 300, 30)];
    [self.contentView addSubview:_number];
    
}

-(void)setDetail:(DetailModel *)Detail{
    if (_Detail != Detail) {
        _Detail = Detail;
    }
    [self.IMG sd_setImageWithURL:Detail.picUrl];
    self.title.text = [NSString stringWithFormat:@"📀:%@",Detail.title];
    self.number.text = [NSString stringWithFormat:@"▷%@次", Detail.number];
}



@end
