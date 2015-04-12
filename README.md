![icon](http://img01.taobaocdn.com/imgextra/i1/135480037/TB2tv1ocpXXXXXrXpXXXXXXXXXX_!!135480037.gif)
![icon](http://img01.taobaocdn.com/imgextra/i1/135480037/TB2LIyjcpXXXXcbXpXXXXXXXXXX_!!135480037.gif)


####导入主头文件
    #import "SCIntroView.h"
    
####使用步骤

1.初始化方法

    /**
     *  初始化一个IntroView，如不指定contentImageMode和doneMode，默认为全屏展示图片和点击按钮的方式结束Intro
     *
     *  @param dataSource        IntroView的数据源（背景图，背景色，内容图，标题等）
     */
    - (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource;
也可以用这个初始化方法

    /**
     *  初始化一个IntroView
     *
     *  @param contentImageMode  内容图片的展示形式 （默认为全屏显示）
     *  @param doneMode          结束IntroView的方式 （默认为点击按钮结束）
     *  @param dataSource        IntroView的数据源（背景图，背景色，内容图，标题等）
     */
    - (instancetype)initWithFrame:(CGRect)frame contentImageMode:(SCIntroViewContentImageMode)contentImageMode doneMode:(SCIntroViewDoneMode)doneMode dataSource:(id)dataSource;


2.设置内容页展示形式contentImageMode，如不指定，默认为全屏展示

    // 内容图片展示的模式
    typedef enum{
        SCIntroViewContentImageModeDefault, // 全屏显示图片
        SCIntroViewContentImageModeCenter // 居中显示图片（图片最大为屏幕宽*0.8）
    } SCIntroViewContentImageMode;
    
3.设置Intro结束方式doneMode，如不指定，默认为点击按钮结束
    
    // 结束Intro的模式
    typedef enum{
        SCIntroViewDoneModeDefault, // 点击按钮结束Intro
        SCIntroViewDoneModePanGesture, // 拖拽结束Intro（默认隐藏完成按钮）
        SCIntroViewDoneModePanGestureWithAnimation // 拖拽结束Intro（带渐变动画，默认隐藏完成按钮）
    } SCIntroViewDoneMode;
    
4.添加至需要显示IntroView的视图上

5.实现一些数据源方法

####数据源方法

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
     *  返回pageControl在纵坐标上的位置（SCIntroViewDoneMode为SCIntroViewDoneModeDefault时默认为0.8，其他默认为0.95） 
    */
    - (CGFloat)pageControlLocationInIntroView:(SCIntroView *)introView;
