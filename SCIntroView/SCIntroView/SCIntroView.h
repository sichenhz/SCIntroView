//
//  SCIntroView.h
//  Intro引导页
//
//  Created by Jason on 14/11/22.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCIntroView;

// 内容图片展示的模式
typedef enum{
    SCIntroViewContentImageModeDefault, // 全屏显示图片
    SCIntroViewContentImageModeCenter // 居中显示图片（图片最大为屏幕宽*0.8）
} SCIntroViewContentImageMode;

// 结束Intro的模式
typedef enum{
    SCIntroViewDoneModeDefault, // 点击按钮结束Intro
    SCIntroViewDoneModePanGesture, // 拖拽结束Intro（默认隐藏完成按钮）
    SCIntroViewDoneModePanGestureWithAnimation // 拖拽结束Intro（带渐变动画，默认隐藏完成按钮）
} SCIntroViewDoneMode;

@protocol SCIntroViewDataSource <NSObject>

@required
/**
 *  返回每一页需显示的内容图
 */
- (NSArray *)contentImagesInIntroView:(SCIntroView *)introView;

@optional
/** 返回背景图 */
- (UIImage *)backgroundImageInIntroView:(SCIntroView *)introView;
/** 返回每一页需显示的标题*/
- (NSArray *)titlesInIntroView:(SCIntroView *)introView;
/** 返回每一页需显示的子标题*/
- (NSArray *)descriptionTitlesInIntroView:(SCIntroView *)introView;
/** 返回完成按钮 */
- (UIButton *)doneButtonInIntroView:(SCIntroView *)introView;

/** 返回pageControl在纵坐标上的位置（SCIntroViewDoneMode为SCIntroViewDoneModeDefault时默认为0.8，其他默认为0.95） */
- (CGFloat)pageControlLocationInIntroView:(SCIntroView *)introView;
/** 返回完成按钮在纵坐标上的位置 */
- (CGFloat)doneButtonLocationInIntroView:(SCIntroView *)introView;

@end

@interface SCIntroView : UIView

@property (nonatomic, weak) id<SCIntroViewDataSource> dataSource;
/** 内容图片展示模式 */
@property (nonatomic, assign) SCIntroViewContentImageMode introViewContentImageMode;
/** 移除Intro的模式 */
@property (nonatomic, assign) SCIntroViewDoneMode introViewDoneMode;
/** 翻页指示器，默认hidden为YES */
@property (nonatomic, strong) UIPageControl *introViewPageControl;

/**
 *  快速展示introView，默认全屏展示图片和点击按钮的方式结束Intro
 *
 *  @param fromView          （必须）展示在哪个view之上
 *  @param dataSource        （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 */
+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource;

/**
 *  快速展示introView，默认点击按钮的方式结束Intro，按钮可用数据源方法返回
 *
 *  @param fromView                  （必须）展示在哪个view之上
 *  @param dataSource                （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 *  @param introViewContentImageMode （可选）内容图片的展示形式 （如为空，默认为全屏显示）
 */
+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode;

/**
 *  快速展示introView，默认为全屏展示图片
 *
 *  @param fromView                  （必须）展示在哪个view之上
 *  @param dataSource                （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 *  @param introViewDoneMode         （可选）结束IntroView的方式 （默认为点击按钮结束）
 */
+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode;

/**
 *  快速展示introView
 *
 *  @param fromView                  （必须）展示在哪个view之上
 *  @param dataSource                （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 *  @param introViewContentImageMode （可选）内容图片的展示形式 （如为空，默认为全屏显示）
 *  @param introViewDoneMode         （可选）结束IntroView的方式 （默认为点击按钮结束）
 */
+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode;

/**
 *  初始化一个IntroView，如不指定contentImageMode和doneMode，默认为全屏展示图片和点击按钮的方式结束Intro
 *
 *  @param frame             （必须）
 *  @param dataSource        （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource;

/**
 *  初始化一个IntroView，如不指定doneMode，默认为点击按钮的方式结束Intro
 *
 *  @param frame             （必须）
 *  @param contentImageMode  （可选）内容图片的展示形式 （如为空，默认为全屏显示）
 *  @param dataSource        （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 */
- (instancetype)initWithFrame:(CGRect)frame introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode dataSource:(id)dataSource;

/**
 *  初始化一个IntroView，如不指定contentImageMode和doneMode，默认为全屏展示图片
 *
 *  @param frame             （必须）
 *  @param doneMode          （可选）结束IntroView的方式 （如为空，默认为点击按钮结束）
 *  @param dataSource        （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 */
- (instancetype)initWithFrame:(CGRect)frame introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode dataSource:(id)dataSource;

/**
 *  初始化一个IntroView
 *
 *  @param frame             （必须）
 *  @param contentImageMode  （可选）内容图片的展示形式 （如为空，默认为全屏显示）
 *  @param doneMode          （可选）结束IntroView的方式 （默认为点击按钮结束）
 *  @param dataSource        （必须）IntroView的数据源（背景图，背景色，内容图，标题等）
 */
- (instancetype)initWithFrame:(CGRect)frame introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode dataSource:(id)dataSource;

@end

