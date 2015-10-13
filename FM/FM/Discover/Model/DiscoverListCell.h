//
//  DiscoverListCell.h
//  FM
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverListCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lab4recordtitle;

@property (weak, nonatomic) IBOutlet UILabel *lab4userAcount;

@property (weak, nonatomic) IBOutlet UILabel *lab4fileDuration;

@property (weak, nonatomic) IBOutlet UILabel *Lab4recordCreated;

@property (nonatomic,strong)DiscoverListModel *discoverListModel;


@end
