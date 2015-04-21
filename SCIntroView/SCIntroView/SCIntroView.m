//
//  SCIntroView.m
//  Intro引导页
//
//  Created by Jason on 14/11/22.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SCIntroView.h"

#define kApplicationHasShowIntroViewKey @"ApplicationHasShowIntroViewKey"
#define kApplicationVersion @"ApplicationVersion"

@interface SCIntroView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *background_Image;
@property (nonatomic, strong) NSArray *contentImages;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *descriptionTitles;
@property (nonatomic, weak) UIButton *doneButton;
@property (nonatomic, assign) CGFloat pageControlLocation;
@property (nonatomic, assign) CGFloat doneButtonLocation;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *lastPageView;
@property UIView *holeView;
@property UIView *circleView;

@end

@implementation SCIntroView

- (instancetype)init {
    if ([self shouldShowIntroView]) {
        if (self = [super init]) {
            // 这里还没有设置frame和dataSource，无需setUp
        }
        return self;
    } else {
        return nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([self shouldShowIntroView]) {
        if (self = [super initWithFrame:frame]) {
            // 这里没有设置dataSource，无需setUp
        }
        return self;
    } else {
        return nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource {
    if ([self shouldShowIntroView]) {
        if (self = [super initWithFrame:frame]) {
            _dataSource = dataSource;
            [self setUp];
        }
        return self;
    } else {
        return nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode dataSource:(id)dataSource {
    if ([self shouldShowIntroView]) {
        if (self = [super initWithFrame:frame]) {
            _dataSource = dataSource;
            _introViewDoneMode = introViewDoneMode;
            [self setUp];
        }
        return self;
    } else {
        return nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode dataSource:(id)dataSource {
    if ([self shouldShowIntroView]) {
        if (self = [super initWithFrame:frame]) {
            _dataSource = dataSource;
            _introViewContentImageMode = introViewContentImageMode;
            _introViewDoneMode = introViewDoneMode;
            [self setUp];
        }
        return self;
    } else {
        return nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode dataSource:(id)dataSource {
    if ([self shouldShowIntroView]) {
        if (self = [super initWithFrame:frame]) {
            _dataSource = dataSource;
            _introViewContentImageMode = introViewContentImageMode;
            [self setUp];
        }
        return self;
    } else {
        return nil;
    }
}

+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource {
    CGRect frame = [UIScreen mainScreen].bounds;
    SCIntroView *introView = [[self alloc] initWithFrame:frame dataSource:dataSource];
    [fromView addSubview:introView];
}

+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource
     introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode {
    CGRect frame = [UIScreen mainScreen].bounds;
    SCIntroView *introView = [[self alloc] initWithFrame:frame introViewContentImageMode:introViewContentImageMode dataSource:self];
    [fromView addSubview:introView];
}

+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode {
    CGRect frame = [UIScreen mainScreen].bounds;
    SCIntroView *introView = [[self alloc] initWithFrame:frame introViewDoneMode:introViewDoneMode dataSource:self];
    [fromView addSubview:introView];
}

+ (void)showIntrolViewFromView:(UIView *)fromView dataSource:(id)dataSource
     introViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode introViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode {
    CGRect frame = [UIScreen mainScreen].bounds;
    SCIntroView *introView = [[self alloc] initWithFrame:frame introViewContentImageMode:introViewContentImageMode introViewDoneMode:introViewDoneMode dataSource:self];
    [fromView addSubview:introView];
}

- (BOOL)shouldShowIntroView {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    // 获取当前版本
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 获取之前存储版本
    NSString *lastVersion = [userDefault objectForKey:kApplicationVersion];
    if (![curVersion isEqualToString:lastVersion]) { // 有新版本, 需要显示引导页
        [userDefault setBool:NO forKey:kApplicationHasShowIntroViewKey];
        [userDefault setObject:[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forKey:kApplicationVersion];
    }
    return ![userDefault boolForKey:kApplicationHasShowIntroViewKey];
}

- (void)setDataSource:(id<SCIntroViewDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        if (!CGRectEqualToRect(self.frame, CGRectZero)) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self setUp];
        }
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (!CGRectEqualToRect(self.frame, frame)) {
        if (self.dataSource) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self setUp];
        }
    }
}

- (void)setIntroViewContentImageMode:(SCIntroViewContentImageMode)introViewContentImageMode {
    if (_introViewContentImageMode != introViewContentImageMode) {
        _introViewContentImageMode = introViewContentImageMode;
        if (!CGRectEqualToRect(self.frame, CGRectZero) && self.dataSource) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self setUp];
        }
    }
}

- (void)setIntroViewDoneMode:(SCIntroViewDoneMode)introViewDoneMode {
    if (_introViewDoneMode != introViewDoneMode) {
        _introViewDoneMode = introViewDoneMode;
        if (!CGRectEqualToRect(self.frame, CGRectZero) && self.dataSource) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self setUp];
        }
    }
}

- (void)setUp {
        
    // Background Image
    if (self.background_Image) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.image = self.background_Image;
        [self addSubview:backgroundImageView];
    }
    
    // scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    switch (self.introViewDoneMode) {
        case SCIntroViewDoneModePanGesture:
        case SCIntroViewDoneModePanGestureWithAnimation:
            self.scrollView.contentSize = CGSizeMake(self.frame.size.width*(self.contentImages.count+1), self.scrollView.frame.size.height);
            break;
        default:
            self.scrollView.contentSize = CGSizeMake(self.frame.size.width*self.contentImages.count, self.scrollView.frame.size.height);
            break;
    }
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    // contentView
    [self createContentView];

    // pageControl
    if (self.introViewPageControl.hidden == NO) {
        self.introViewPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height*self.pageControlLocation, self.frame.size.width, 10)];
        self.introViewPageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        self.introViewPageControl.numberOfPages = self.contentImages.count;
        [self addSubview:self.introViewPageControl];
    }
    
    //Done Button
    switch (self.introViewDoneMode) {
        case SCIntroViewDoneModePanGesture:
        case SCIntroViewDoneModePanGestureWithAnimation:
            break;
        default:
            [self addSubview:self.doneButton];
            break;
    }
    
    //This is the starting point of the ScrollView
    CGPoint scrollPoint = CGPointMake(0, 0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)createContentView {
    
    for (int i = 0; i < self.contentImages.count; i++) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*i, 0, originWidth, originHeight)];
        if (i == self.contentImages.count - 1) {
            self.lastPageView = view;
        }
        // 内容图
        UIImageView *imageview;
        switch (self.introViewContentImageMode) {
            case SCIntroViewContentImageModeCenter:
                imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.1, self.frame.size.width*.8, self.frame.size.width)];
                break;
            default:
                imageview = [[UIImageView alloc] initWithFrame:view.bounds];
                break;
        }
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = self.contentImages[i];
        [view addSubview:imageview];
        
        // 标题
        if (self.titles) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
            titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
            titleLabel.text = self.titles.count > i ? self.titles[i] : nil;
            titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.textAlignment =  NSTextAlignmentCenter;
            titleLabel.numberOfLines = 0;
            [view addSubview:titleLabel];
        }
        
        // 子标题
        if (self.descriptionTitles) {
            UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
            descriptionLabel.text = self.descriptionTitles.count > i ? self.descriptionTitles[i] : nil;
            descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
            descriptionLabel.textColor = [UIColor whiteColor];
            descriptionLabel.textAlignment =  NSTextAlignmentCenter;
            descriptionLabel.numberOfLines = 0;
            [descriptionLabel sizeToFit];
            [view addSubview:descriptionLabel];
            CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
            descriptionLabel.center = labelCenter;
        }
        
        [self.scrollView addSubview:view];
    }
}

- (void)onFinishedIntroButtonPressed:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:kApplicationHasShowIntroViewKey];
    [userDefault synchronize];
    
    [self removeIntroViewWithAnimation];
}

- (void)removeIntroViewWithAnimation {
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.introViewPageControl.currentPage = roundf(pageFraction);
    
    switch (self.introViewDoneMode) {
        case SCIntroViewDoneModePanGesture: {
            CGFloat pageWidth = CGRectGetWidth(self.bounds);
            if ((self.scrollView.contentOffset.x / pageWidth) >= self.contentImages.count) {
                [self removeIntroViewWithAnimation];
            }
        }
            break;
        case SCIntroViewDoneModePanGestureWithAnimation: {
            CGFloat pageWidth = CGRectGetWidth(self.bounds);
            if ((self.scrollView.contentOffset.x / pageWidth) >= (self.contentImages.count-1)) {
                float alpha = 1-((self.scrollView.contentOffset.x/pageWidth)-(self.contentImages.count-1));
                self.lastPageView.alpha = alpha;
            }
            if ((self.scrollView.contentOffset.x / pageWidth) >= self.contentImages.count) {
                [self removeIntroViewWithAnimation];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - 私有方法(获得代理返回的数据源)
- (NSArray *)contentImages {
    if ([self.dataSource respondsToSelector:@selector(contentImagesInIntroView:)]) {
        return [self.dataSource contentImagesInIntroView:self];
    }
    return nil;
}

- (UIImage *)background_Image {
    if ([self.dataSource respondsToSelector:@selector(backgroundImageInIntroView:)]) {
        return [self.dataSource backgroundImageInIntroView:self];
    }
    return nil;
}

- (NSArray *)titles {
    if ([self.dataSource respondsToSelector:@selector(titlesInIntroView:)]) {
        return [self.dataSource titlesInIntroView:self];
    }
    return nil;
}

- (NSArray *)descriptionTitles {
    if ([self.dataSource respondsToSelector:@selector(descriptionTitlesInIntroView:)]) {
        return [self.dataSource descriptionTitlesInIntroView:self];
    }
    return nil;
}

- (CGFloat)pageControlLocation {
    if ([self.dataSource respondsToSelector:@selector(pageControlLocationInIntroView:)]) {
        return [self.dataSource pageControlLocationInIntroView:self];
    }
    switch (self.introViewDoneMode) {
        case SCIntroViewDoneModePanGesture:
        case SCIntroViewDoneModePanGestureWithAnimation:
            return 0.95;
            break;
        default:
            return 0.8;
            break;
    }
}

- (CGFloat)doneButtonLocation {
    if ([self.dataSource respondsToSelector:@selector(doneButtonLocationInIntroView:)]) {
        return [self.dataSource doneButtonLocationInIntroView:self];
    }
    return 0.85;
}

- (UIButton *)doneButton {
    if ([self.dataSource respondsToSelector:@selector(doneButtonInIntroView:)]) {
        UIButton *doneButton = [self.dataSource doneButtonInIntroView:self];
        if (CGPointEqualToPoint(doneButton.frame.origin, CGPointZero)) {
            doneButton.frame = CGRectMake(self.frame.size.width*0.1, self.frame.size.height*self.doneButtonLocation, self.frame.size.width*0.8, 50);
        }
        [doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        return doneButton;
    }
    return [self defaultDoneButton];
}

- (UIButton *)defaultDoneButton {
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*0.1, self.frame.size.height*self.doneButtonLocation, self.frame.size.width*0.8, 50)];
    [doneButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
    doneButton.backgroundColor = [UIColor colorWithRed:0.941 green:0.471 blue:0.529 alpha:1.000];
    doneButton.layer.cornerRadius = 5;
    [doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return doneButton;
}

@end
