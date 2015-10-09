//
//  ListCell.h
//  FM
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface ListCell : UITableViewCell

@property(nonatomic , strong) UIImageView *albumImage;

@property(nonatomic , strong) UILabel *titleLabel;

@property(nonatomic , strong) UILabel *nicknameLabel;

@property(nonatomic , strong) UILabel *playtimesLabel;

@property(nonatomic , strong) UILabel *likesLabel;

@property(nonatomic , strong) UILabel *durationLabel;

@property(nonatomic , strong) ListModel *model;


@end
