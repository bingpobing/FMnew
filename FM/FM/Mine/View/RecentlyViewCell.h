//
//  RecentlyViewCell.h
//  FM
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMmodel;
@interface RecentlyViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img4Music;
@property (weak, nonatomic) IBOutlet UILabel *lab4Name;
@property (nonatomic,strong) FMmodel *model;
@end
