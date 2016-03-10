//
//  PopView.h
//  FacebookPOP
//
//  Created by ciwong on 15/12/17.
//  Copyright (c) 2015年 ciwong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PopViewProtocol <NSObject>

- (void)pressedButtonIndex:(NSInteger)index;
@end

@interface PopView : UIView

@property (nonatomic, weak)id<PopViewProtocol>popDelegate;

- (void)showInView:(UIView *)view;

@end
