//
//  PAODemoView.m
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAODemoView.h"
#import "PAOLeftView.h"

@interface PAODemoView()

@property (nonatomic, strong) PAOLeftView *leftView;
@property (nonatomic, strong) UIView *maskView;//浮层

@property (nonatomic, assign) BOOL itemListIsOpen;
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation PAODemoView

//创建视图
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMaskPanTarget:)];
        [self addGestureRecognizer:panRecognizer];
        [self addSubview:self.maskView];
        self.maskView.alpha = 0;
        [self addSubview:self.leftView];
    }
    return self;
}

- (void)setDelegate:(id)delegate {
    
    //自己不保存，直接给leftView代理
    self.leftView.delegate = delegate;
}

- (void)insertImageView:(UIImageView *)imageView {
    [self insertSubview:imageView belowSubview:self.maskView];
}

#pragma mark - action
- (void)handleMaskPanTarget:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.startPoint = [pan translationInView:self];
            if (self.leftView.originX < 0) {
                self.itemListIsOpen = NO;
            } else {
                self.itemListIsOpen = YES;
            }
        }
            break;
 
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [pan translationInView:self];
            point.x -= self.startPoint.x;
            NSLog(@"point is %@",[NSValue valueWithCGPoint:point]);
            
            //当左边视图是关闭的，并且向右滑
            if (point.x > 0 && !self.itemListIsOpen) {
                if (point.x >= self.leftView.width) {
                    self.leftView.originX = 0;
                    self.maskView.alpha = 1;
                    
                } else {
                    self.leftView.originX = point.x - self.leftView.width;
                    CGFloat alph = (self.leftView.width - fabs(self.leftView.originX)) / self.leftView.width;
                    self.maskView.alpha = alph;
                }
            }
            //当左边视图是打开的，并且向左滑
            else if (point.x < 0 && self.itemListIsOpen) {
                if (fabs(point.x) > self.leftView.width) {
                    self.leftView.originX = -self.leftView.width;
                    self.maskView.alpha = 0.;
                } else {
                    self.leftView.originX =  point.x;
                    CGFloat alph = (self.leftView.width - fabs(self.leftView.originX)) / self.leftView.width;
                    self.maskView.alpha = alph;
                }
            }
            
        }
            break;
        default:
        {
            //这儿处理其余的情况
            CGFloat width = self.leftView.width / 2.0;
            
            if ((self.leftView.width - fabs(self.leftView.originX)) >= width) {
                self.itemListIsOpen = YES;
                [UIView animateWithDuration:0.2 animations:^{
                    self.leftView.originX = 0;
                    self.maskView.alpha = 1.0;
                }];
            } else {
                self.itemListIsOpen = NO;
                [UIView animateWithDuration:0.2 animations:^{
                    self.leftView.originX = - self.leftView.width;
                    self.maskView.alpha = 0.0;
                }];
            }
        }
            break;
    }
}

- (void)missLeftItemView {
    self.itemListIsOpen = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.leftView.originX = - self.leftView.width;
        self.maskView.alpha = 0.0;
    }];
}

#pragma mark - lazy
- (PAOLeftView *)leftView {
    if (!_leftView) {
        //左视图控件大小    宽度和那个什么保持一致！
        _leftView = [[PAOLeftView alloc] initWithFrame:CGRectMake(-100, 0, 100, self.height)];
    }
    return _leftView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return _maskView;
}
@end
