//
//  UIViewController+VKLargeTitle.m
//
//  Created by liulishuo on 2017/11/28.
//  Copyright © 2017年 Vanke. All rights reserved.
//

#import "UIViewController+VKLargeTitle.h"
#import <Masonry.h>
#import <objc/runtime.h>
#import "MTKObserving.h"

static char vkContentViewKey;
static char vkLargeTitleKey;
static char vkTitleViewKey;
static char vkLargeTitleHeightKey;

static CGFloat const kLargeTitleHeight = 72;
static CGFloat const kLargeTitleMargin = 20;
static CGFloat const kLargeTitleFontSize = 28;
static NSUInteger const kLargeTitleLabelTag = 1987;

@implementation UIViewController (VKLargeTitle)

- (void)showLargeTitle:(NSString *)title titleView:(UIView *)titleView contentView:(UIScrollView *)contentView {
    self.vkContentView = contentView;
    self.vkLargeTitle = title;
    self.vkTitleView = titleView;
    [self.vkContentView addSubview:self.vkTitleView];
}

- (void)showLargeTitle:(NSString *)title contentView:(UIScrollView *)contentView {
    self.vkContentView = contentView;
    self.vkLargeTitle = title;
    [self setupLargeTitleLabel];
}

#pragma mark - Methods
- (void)resetContentInset {
    CGFloat bottomInset = self.vkContentView.bounds.size.height - self.vkContentView.contentSize.height;
    if (bottomInset < 0) {
        bottomInset = 0;
    }
    self.vkContentView.contentInset = UIEdgeInsetsMake(self.vkLargeTitleHeight, 0, bottomInset, 0);
    self.vkContentView.contentOffset = CGPointMake(self.vkContentView.contentOffset.x, -self.vkLargeTitleHeight);
}

- (void)setupLargeTitleLabel {
    if (self.vkLargeTitle.length == 0) {
        return;
    }
        
    UILabel *titleLabel = [self.vkContentView viewWithTag:kLargeTitleLabelTag];
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -self.vkLargeTitleHeight, self.vkContentView.frame.size.width, self.vkLargeTitleHeight)];
        [self.vkContentView addSubview:titleLabel];
        titleLabel.tag = kLargeTitleLabelTag;
        titleLabel.backgroundColor = [UIColor redColor];
        
        titleLabel.font = [UIFont boldSystemFontOfSize:kLargeTitleFontSize];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.superview).offset(-self.vkLargeTitleHeight);
            make.left.equalTo(titleLabel.superview).offset(kLargeTitleMargin);
            make.right.equalTo(titleLabel.superview).offset(-kLargeTitleMargin);
            make.height.equalTo(@(self.vkLargeTitleHeight));
        }];
    }
    
    titleLabel.text = self.vkLargeTitle;
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset {
    CGFloat thresholdHeight = self.vkLargeTitleHeight / 2;
    if (offset.y < - thresholdHeight) {
        return CGPointMake(offset.x, -self.vkLargeTitleHeight);
    } else if (offset.y >= - thresholdHeight && offset.y < 0){
        return CGPointMake(offset.x, 0);
    }
    return offset;
}

#pragma mark - Setter and Getter

- (CGFloat)vkLargeTitleHeight {
    NSNumber *height = objc_getAssociatedObject(self, &vkLargeTitleHeightKey);
    CGFloat largeTitleHeight = height.floatValue;
    if (largeTitleHeight == 0) {
        return kLargeTitleHeight;
    }
    return largeTitleHeight;
}

- (void)setVkLargeTitleHeight:(CGFloat)vkLargeTitleHeight {
    objc_setAssociatedObject(self, &vkLargeTitleHeightKey, @(vkLargeTitleHeight), OBJC_ASSOCIATION_ASSIGN);
    self.vkContentView.contentInset = UIEdgeInsetsMake(self.vkLargeTitleHeight, 0, 0, 0);
    [self.vkContentView addSubview:self.vkTitleView];
}

- (UIScrollView *)vkContentView {
    UIScrollView *contentView = objc_getAssociatedObject(self, &vkContentViewKey);
    return contentView;
}

- (void)setVkContentView:(UIScrollView *)contentView {
    objc_setAssociatedObject(self, &vkContentViewKey, contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    contentView.delegate = self;
    
    contentView.contentOffset = CGPointMake(contentView.contentOffset.x, -self.vkLargeTitleHeight);
    
    [self observeObject:contentView property:@"contentSize" withBlock:^(id self, id object, id oldValue, id newValue) {
        CGSize sizeNew =  ((NSValue *)newValue).CGSizeValue;
        CGSize sizeOld =  ((NSValue *)oldValue).CGSizeValue;
        if (sizeNew.height != sizeOld.height) {
            [self resetContentInset];
            //        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(resetContentInset) object:nil];
            //        [self performSelector:@selector(resetContentInset) withObject:nil afterDelay:0.01];
        }
    }];

    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
}

- (UIView *)vkTitleView {
    UIView *titleView = objc_getAssociatedObject(self, &vkTitleViewKey);
    if (!titleView) {
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, -self.vkLargeTitleHeight, self.view.frame.size.width, self.vkLargeTitleHeight)];
    } else {
        titleView.frame = CGRectMake(0, -self.vkLargeTitleHeight, self.view.frame.size.width, self.vkLargeTitleHeight);
    }
    
    return titleView;
}

- (void)setVkTitleView:(UIView *)vkTitleView {
    objc_setAssociatedObject(self, &vkTitleViewKey, vkTitleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addConstraintsToTitleView {
    [self.vkTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vkTitleView.superview).offset(-self.vkLargeTitleHeight);
        make.left.equalTo(self.vkTitleView.superview).offset(0);
        make.right.equalTo(self.vkTitleView.superview).offset(0);
        make.height.equalTo(@(self.vkLargeTitleHeight));
    }];
}

- (NSString *)vkLargeTitle {
    NSString *largeTitle = objc_getAssociatedObject(self, &vkLargeTitleKey);
    return largeTitle;
}

- (void)setVkLargeTitle:(NSString *)largeTitle {
    objc_setAssociatedObject(self, &vkLargeTitleKey, largeTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.vkContentView) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offset: %lf",offsetY);
    
    if (offsetY < 0) {
        self.title = @"";
    } else {
        self.title = self.vkLargeTitle;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView != self.vkContentView) {
        return;
    }
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
    
    targetContentOffset->x = targetOffset.x;
    targetContentOffset->y = targetOffset.y;
}

@end
