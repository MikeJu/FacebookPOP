//
//  PopView.m
//  FacebookPOP
//
//  Created by ciwong on 15/12/17.
//  Copyright (c) 2015年 ciwong. All rights reserved.
//

#import "PopView.h"
#import "POP.h"

#define THREE_BTN_START_X (SCREENWIDTH/2) //初始y
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define THREE_BTN_WIDTH 88.0      //btn大小
#define FREAD_START_Y 44.0       //初始x
#define THREE_BTN_PADDING  35.0 //间距
#define BtnTag 100

@implementation PopView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
    }
    return self;
}
- (void)initSubview
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgImageView.image = [UIImage imageNamed:@"followread_bakcground"];
    [self addSubview:bgImageView];
    
     NSArray *titleArr = @[@"绝命毒师",@"无耻之徒",@"行尸走肉"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(THREE_BTN_START_X, SCREENHEIGHT, 0, 0);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
    
        [btn setBackgroundImage:[UIImage imageNamed:@"three_btn_normal"] forState:UIControlStateNormal];
        btn.layer.cornerRadius = THREE_BTN_WIDTH / 2;
        btn.clipsToBounds = YES;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = BtnTag + i;
        [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        }
}
- (void)tapBtn:(UIButton *)sender
{
    if (self.popDelegate && [self.popDelegate respondsToSelector:@selector(pressedButtonIndex:)]) {
        [self.popDelegate pressedButtonIndex:sender.tag - BtnTag];
    }
    [self hide];
}
- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.2 animations:^{
        wself.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *btn=(UIButton *)view;
                    [wself setAlphaAnimationToBtn:btn];
                    [wself setFrameAnimationToBtn:btn];
                    [wself setPositionAnimationToBtn:btn];
                }
            }

        }
    }];
}
- (void)hideView
{
    [self hide];
}
- (void)hide
{
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.2 animations:^{
        wself.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [wself removeFromSuperview];
        }
    }];
}
-(void)setAlphaAnimationToBtn:(UIButton *)btn
{
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animation];
    alphaAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    alphaAnimation.fromValue = @(0);
    alphaAnimation.toValue = @(1);
    [btn pop_addAnimation:alphaAnimation forKey:@"slide"];
}
-(void)setFrameAnimationToBtn:(UIButton *)btn{
    POPSpringAnimation *basicAnimation = [POPSpringAnimation animation];
    basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewSize];
    basicAnimation.toValue=[NSValue valueWithCGSize:CGSizeMake(THREE_BTN_WIDTH, THREE_BTN_WIDTH)];
    [btn pop_addAnimation:basicAnimation forKey:@"size"];
    
}

-(void)setPositionAnimationToBtn:(UIButton *)btn{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(THREE_BTN_START_X, FREAD_START_Y+(THREE_BTN_WIDTH+THREE_BTN_PADDING)*(btn.tag - BtnTag + 1))];
    //弹性值
    springAnimation.springBounciness = 15.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    
    [btn pop_addAnimation:springAnimation forKey:@"position"];
}

@end
