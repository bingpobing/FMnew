//
//  CarouselFingure.m
//  CarouselFingure-无重用版
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "CarouselFingure.h"

@interface CarouselFingure ()<UIScrollViewDelegate>

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)NSTimer *timer;





@end





@implementation CarouselFingure





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建timer
        _timer = [[NSTimer alloc]init];
        //设置轮播等待时间
        _duration =2;
        
        
    }
    return self;
}


#pragma mark --tap触发手势的方法--
-(void)tapAction:(UITapGestureRecognizer*)tap
{

    NSUInteger index = tap.view.tag-1000;
    
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(carouselFingureDidCarousel:atIndex:)]) {
        //将当前的轮播图和当前轮播图的下标传播给外界
        [_delegate carouselFingureDidCarousel:self atIndex:index];
    }

}






#pragma mark --代理方法--
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

//开始拖动,timer暂停
    [self.timer invalidate];
    


}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
 
    self.timer=nil;

    self.pageControl.currentPage = self.scrollView.contentOffset.x/self.frame.size.width;
    self.currentIndex = self.pageControl.currentPage;
    self.timer =[NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(carouselFromTimer:) userInfo:self repeats:YES];

}



#pragma mark --Timer驱动轮播方法--
-(void)carouselFromTimer:(id)sender
{
    self.currentIndex ++;
    if (self.currentIndex==self.imagesArray.count) {
        self.currentIndex =0;
    }
    
        self.pageControl.currentPage  =self.currentIndex;
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*self.currentIndex, 0)];

}

#pragma mark --赋值方法--
-(void)setImagesArray:(NSArray *)imagesArray
{

    //停止timer的操作
    [self.timer invalidate];
    
    self.timer = nil;
    
    if (_imagesArray !=imagesArray) {
        _imagesArray = [imagesArray mutableCopy];
  

    }

    
    //=========
    [self drawView];
     self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(carouselFromTimer:) userInfo:nil repeats:YES];//便利构造器


}






-(void)setDuration:(NSTimeInterval)duration
{

    [self.timer invalidate];
    self.timer = nil;
    _duration = duration;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(carouselFromTimer:) userInfo:self repeats:YES];
    

}








#pragma mark --绘制--

-(void)drawView
{

//将绘制好的视图添加在父视图上
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];


}


-(UIScrollView*)scrollView
{

    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.frame] ;
    }
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width*self.imagesArray.count, self.frame.size.height);
    for (int i=0; i<self.imagesArray.count; i++) {
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        imgview.userInteractionEnabled = YES;
        imgview.image = self.imagesArray[i];
        //添加手势
        imgview.tag = 1000+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imgview addGestureRecognizer:tap];
        
        
        [_scrollView addSubview:imgview];
        
        
    }

    return _scrollView;
}

-(UIPageControl*)pageControl
{

    if (_pageControl  ==nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 0)];
        _pageControl.numberOfPages = self.imagesArray.count;
    }
    return _pageControl;

}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
