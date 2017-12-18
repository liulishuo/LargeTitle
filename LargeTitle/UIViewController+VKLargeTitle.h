//
//  UIViewController+VKLargeTitle.h
//
//  Created by liulishuo on 2017/11/28.
//  Copyright © 2017年 Vanke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (VKLargeTitle)<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *vkContentView;
@property (nonatomic, copy) NSString *vkLargeTitle;
@property (nonatomic, strong) UIView *vkTitleView;
@property (nonatomic, assign) CGFloat vkLargeTitleHeight;

- (void)showLargeTitle:(NSString *)title contentView:(UIScrollView *)contentView;
- (void)showLargeTitle:(NSString *)title titleView:(UIView *)titleView contentView:(UIScrollView *)contentView;

@end
