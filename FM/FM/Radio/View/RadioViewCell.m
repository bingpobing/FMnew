//
//  RadioViewCell.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "RadioViewCell.h"
#import "UIImageView+WebCache.h"

@implementation RadioViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self draw];
    }
    return self;
}
-(void)draw{
    
    _Pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 20)];
    [self.contentView addSubview:_Pic];

    _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.contentView.frame.size.height - 20 ,self.contentView.frame.size.width , 20)];
    _NameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_NameLabel];
    
    
}

-(void)setRadioModel:(RadioModel *)RadioModel{
    if (_RadioModel != RadioModel) {
        _RadioModel = RadioModel;
    }
    [_Pic sd_setImageWithURL:RadioModel.PicUrl];
    _NameLabel.text = RadioModel.tname;
    
    
}


@end
