# LargeTitle
类似iOS11大标题的效果

![image](https://github.com/liulishuo/LargeTitle/blob/master/Demo.gif)


使用：
==============
```objc
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
```

注意：
==============
```objc
本分类实现了
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
 两个UIScrollViewDelegate代理方法
 所以当你的viewcontroller也实现同样的方法时请先调用super的该方法
 
 例如：
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
}
```
