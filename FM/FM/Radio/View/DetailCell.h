//
//  DetailCell.h
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface DetailCell : UITableViewCell

@property(nonatomic , strong) UILabel *title;

@property(nonatomic , strong) UILabel *number;

@property(nonatomic , strong) UIImageView *IMG;

@property(nonatomic , strong) DetailModel *Detail;

@end
