![icon](http://img01.taobaocdn.com/imgextra/i1/135480037/TB2tv1ocpXXXXXrXpXXXXXXXXXX_!!135480037.gif)
![icon](http://img01.taobaocdn.com/imgextra/i1/135480037/TB2LIyjcpXXXXcbXpXXXXXXXXXX_!!135480037.gif)

####Introduction
1. 自动存储版本号，自动识别是否有新版本
2. 自动识别用户是否点击完成按钮，如没有点击过，始终会展示introView
3. 更多功能请参考demo

####导入主头文件
    #import "SCIntroView.h"
    
####使用步骤

1.调用show方法

    [SCIntroView showIntrolViewFromView:self.view dataSource:self];

2.设置数据源

    @required
    /**
     *  返回每一页需显示的内容图
     */
    - (NSArray *)contentImagesInIntroView:(SCIntroView *)introView;
    
    
    @optional
    /**
     *  返回背景图
     */
    - (UIImage *)backgroundImageInIntroView:(SCIntroView *)introView;
    /**
     *  返回每一页需显示的标题
     */
    - (NSArray *)titlesInIntroView:(SCIntroView *)introView;
    /**
     *  返回每一页需显示的子标题
     */
    - (NSArray *)descriptionTitlesInIntroView:(SCIntroView *)introView;
    /**
     *  返回完成按钮
     */
    - (UIButton *)doneButtonInIntroView:(SCIntroView *)introView;    
    /** 
     *  返回pageControl在纵坐标上的位置 
     */
    - (CGFloat)pageControlLocationInIntroView:(SCIntroView *)introView;
    /**
     *  返回完成按钮在纵坐标上的位置
     */
    - (CGFloat)doneButtonLocationInIntroView:(SCIntroView *)introView;
    