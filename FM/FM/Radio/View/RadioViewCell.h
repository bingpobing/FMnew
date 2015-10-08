//
//  RadioViewCell.h
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioModel.h"

@interface RadioViewCell : UICollectionViewCell

@property(nonatomic , strong) UILabel *NameLabel;

@property(nonatomic , strong) UIImageView *Pic;


@property(nonatomic , strong) RadioModel *RadioModel;


@end
