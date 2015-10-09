//
//  CarouselFingure.h
//  CarouselFingure-无重用版
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarouselFingure;

@protocol CarouselFingureDelegate <NSObject>

@optional
//代理执行此方法
-(void)carouselFingureDidCarousel:(CarouselFingure*)carouselFingure atIndex:(NSUInteger)index;

@end





@interface CarouselFingure : UIView

//图片数组
@property(nonatomic,retain)NSArray *imagesArray;

//时间间隔
@property(nonatomic,assign)NSTimeInterval duration;

//当前下标
@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,assign)id<CarouselFingureDelegate>delegate;


@end
