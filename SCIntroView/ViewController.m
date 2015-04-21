//
//  ViewController.m
//  SCIntroView
//
//  Created by 2014-763 on 15/4/12.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import "ViewController.h"
#import "SCIntroView.h"

@interface ViewController () <SCIntroViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置根控制器
    [self setUpRootVc];
    
    [SCIntroView showIntrolViewFromView:self.view dataSource:self];
}

- (void)setUpRootVc {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"rootViewController";
    label.font = [UIFont systemFontOfSize:22.0];
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}

#pragma mark - <SCGuideViewDataSource>
- (NSArray *)contentImagesInIntroView:(SCIntroView *)introView {
    return @[
             [UIImage imageNamed:@"Intro_1"],
             [UIImage imageNamed:@"Intro_2"],
             [UIImage imageNamed:@"Intro_3"]
             ];
}

- (UIImage *)backgroundImageInIntroView:(SCIntroView *)introView {
    return [UIImage imageNamed:@"IntroBackground"];
}

- (NSArray *)titlesInIntroView:(SCIntroView *)introView {
    return @[
             @"Page First",
             @"Page Second",
             @"Page Third",
             ];
}

- (NSArray *)descriptionTitlesInIntroView:(SCIntroView *)introView {
    return @[
             @"Description for First Screen.",
             @"Description for Second Screen.",
             @"Description for Third Screen.",
             ];
}

- (UIButton *)doneButtonInIntroView:(SCIntroView *)introView {
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:[UIImage imageNamed:@"IntroStart"] forState:UIControlStateNormal];
    return doneButton;
}

@end
