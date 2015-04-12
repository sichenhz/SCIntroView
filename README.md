### 如何使用-SCGuideView
![icon](http://img03.taobaocdn.com/imgextra/i3/135480037/TB25exvcpXXXXccXpXXXXXXXXXX_!!135480037.gif)

####导入主头文件
    #import "SCGuideView.h"
    
1.创建引导页视图

    SCGuideView *guideView = [[SCGuideView alloc] init];

2.设置引导页数据源

    guideView.dataSource = self;
    
3.设置frame
    
    guideView.frame = self.view.frame;
    
4.添加至跟控制器的view

    [self.view addSubview:guideView];

####数据源方法

    @required
    /**
     *  返回每一页需显示的主图
     */
    - (NSArray *)imagesInGuideView:(SCGuideView *)guideView;
    
    
    @optional
    /**
     *  返回背景图
     */
    - (UIImage *)backgroundImageInGuideView:(SCGuideView *)guideView;
    /**
     *  返回每一页需显示的标题
     */
    - (NSArray *)titlesInGuideView:(SCGuideView *)guideView;
    /**
     *  返回每一页需显示的子标题
     */
    - (NSArray *)subtitlesInGuideView:(SCGuideView *)guideView;
    /**
     *  返回完成按钮
     */
    - (UIButton *)doneButtonInGuideView:(SCGuideView *)guideView;    
