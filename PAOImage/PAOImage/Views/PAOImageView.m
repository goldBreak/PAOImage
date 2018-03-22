//
//  PAOImageView.m
//  test
//
//  Created by xsd on 2018/3/21.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOImageView.h"


@interface PAOImageView()
{
    BOOL _isOpen;
}

@property (nonatomic, strong) UIImageView *helpImageView;

//添加拖动手势
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

//添加双击手势
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

//捏合手势
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;

//记录上一次的中心点
@property (nonatomic, assign) CGPoint lazyPoint;

//记录上一次的frame
@property (nonatomic, assign) CGRect lazyFrame;

@property (nonatomic, assign) CGAffineTransform atransform;

@end


@implementation PAOImageView

#pragma mark - handle UITapGestureRecognizer
//双击手势
- (void)handleTapGesture:(UITapGestureRecognizer *)recogizer {
    
    //只有双击的时候，触发这个事件
    _isOpen = !_isOpen;
    if (_isOpen) {
        //放大
        self.lazyFrame = self.frame;
        self.lazyPoint = self.center;
        CGPoint point = [recogizer locationInView:self];
        CGRect frame = self.frame;
        
        CGFloat width = point.x - frame.origin.x;
        CGFloat height = point.y - frame.origin.y;
        
        frame.origin.x -= width;
        frame.origin.y -= height;
        
        frame.size.width *= 2;
        frame.size.height *= 2;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
        }];
    } else {
        //缩小
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = self.lazyFrame;
        }];
    }

}

#pragma mark - handle UIPanGestureRecognizer
//拖动手势
- (void)hanldePanGesture:(UIPanGestureRecognizer *)recogizer {
    
    //拖动手势！ 手势中暂时不让滑动到超出边界！
    
    if (recogizer.state == UIGestureRecognizerStateChanged) {
        //
        CGPoint offset = [recogizer translationInView:self];
        
        CGRect frame = self.lazyFrame;
        frame.origin.x += offset.x;
        frame.origin.y += offset.y;
        
        if (offset.x > 0) {
            //右滑,需要保证x 不能大于之前的位置
            if (frame.origin.x > 0) {

                frame.origin.x = 0;
            }
        } else {
            //左滑,需要保证x 不能小于之前的位置
            if (CGRectGetMaxX(frame) < kScreenWidth) {
                if (frame.origin.x < 0) {
                    //这种情况下去做特殊处理
                    CGFloat preOriginX = frame.size.width - kScreenWidth;
                    if (preOriginX < 0) {
                        frame.origin.x = 0;
                    } else {
                        frame.origin.x = -preOriginX;
                    }
                }
            }
        }
       
        if (offset.y > 0) {
            //向下滑动 ，需要保证最大值不能超过之前的位置
            if (frame.origin.y > 0) {

                frame.origin.y = 0;
            }
        } else {
            //向上滑动，需要保证最小值不能超过之前的位置
            if (CGRectGetMaxY(frame) < kScreenHeight) {
                if (frame.origin.y < 0) {
                    //这种情况下去做特殊处理
                    CGFloat preOriginY = frame.size.height - kScreenHeight;
                    if (preOriginY < 0) {
                        frame.origin.y = 0;
                    } else {
                        frame.origin.y = -preOriginY;
                    }
                }
            }
        }
        
        self.frame = frame;
        
    } else {
        self.lazyFrame = self.frame;
    }
}

#pragma mark - UIPinchGestureRecognizer
- (void)handlePichGesture:(UIPinchGestureRecognizer *)recogizer {
    //捏合手势！
    switch (recogizer.state) {
        case UIGestureRecognizerStateChanged:
            //
        {
            CGRect frame = self.lazyFrame;
            frame.size.width *= recogizer.scale;
            frame.size.height *= recogizer.scale;
            
            frame.origin.x += (-frame.size.width + self.lazyFrame.size.width) / 2.;
            frame.origin.y += (-frame.size.height + self.lazyFrame.size.height) / 2.;
            
            self.frame = frame;
        }
            break;
            
        default:
            self.lazyFrame = self.frame;
            break;
    }
    
}


#pragma mark - setImage
- (instancetype)initWithImage:(UIImage *)image {
    
    CGRect frame = CGRectZero;
    frame.size = image.size;
    
    if (self = [super initWithFrame:frame]) {
        self.image = image;
        self.layer.contents = (__bridge id)image.CGImage;
        [self addGestureRecognizer:self.tapGesture];
        [self addGestureRecognizer:self.panGesture];
        [self addGestureRecognizer:self.pinchGesture];
    }
    return self;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        _tapGesture.numberOfTapsRequired = 2;
    }
    return _tapGesture;
}
- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hanldePanGesture:)];
    }
    return _panGesture;
}

- (UIPinchGestureRecognizer *)pinchGesture {
    if (!_pinchGesture) {
        _pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePichGesture:)];
    }
    return _pinchGesture;
}

@end
