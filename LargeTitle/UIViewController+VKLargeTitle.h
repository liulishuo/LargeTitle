//
//  UIViewController+VKLargeTitle.h
//
//  Created by liulishuo on 2017/11/28.
//  Copyright © 2017年 Vanke. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 注意 本分类实现了
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
 两个UIScrollViewDelegate代理方法
 所以当你的viewcontroller也实现同样的方法时请先调用super的该方法
 */
@interface UIViewController (VKLargeTitle)<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *vkContentView;
@property (nonatomic, copy) NSString *vkLargeTitle;
@property (nonatomic, strong) UIView *vkTitleView;
@property (nonatomic, assign) CGFloat vkLargeTitleHeight;


/**
 展示大标题效果

 @param title 大标题文本
 @param contentView 滚动视图
 */
- (void)showLargeTitle:(NSString *)title contentView:(UIScrollView *)contentView;


/**
 展示大标题效果

 @param title 大标题文本
 @param titleView 自定义大标题视图
 @param contentView 滚动视图
 */
- (void)showLargeTitle:(NSString *)title titleView:(UIView *)titleView contentView:(UIScrollView *)contentView;

@end
