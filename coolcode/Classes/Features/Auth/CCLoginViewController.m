//
// Created by 杨玉刚 on 6/29/16.
// Copyright (c) 2016 奇迹科技. All rights reserved.
//

#import "CCLoginViewController.h"
#import "CCLoginThirdPartyView.h"
#import "CCLoginMobileView.h"
#import "CCLoginLogoView.h"
#import "UIColor+CC.h"
#import "Masonry.h"

@interface CCLoginViewController ()

@property (nonatomic, strong) CCLoginLogoView *logoView;
@property (nonatomic, strong) CCLoginMobileView *mobileView;
@property (nonatomic, strong) CCLoginThirdPartyView *thirdPartyView;

@end

@implementation CCLoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view addSubview:self.logoView];
  [self.view addSubview:self.mobileView];
  [self.view addSubview:self.thirdPartyView];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
  UIView *superView = self.view;
  
  [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(superView.mas_top);
    make.leading.mas_equalTo(superView.mas_leading);
    make.trailing.mas_equalTo(superView.mas_trailing);
    make.height.equalTo(@250).priority(250);
  }];
  
  [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.logoView.mas_bottom);
    make.leading.mas_equalTo(superView.mas_leading);
    make.trailing.mas_equalTo(superView.mas_trailing);
    make.bottom.mas_equalTo(self.thirdPartyView.mas_top);
    make.height.equalTo(superView).multipliedBy(0.3);
  }];
  
  [self.thirdPartyView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    make.leading.mas_equalTo(superView.mas_leading);
    make.trailing.mas_equalTo(superView.mas_trailing);
    make.top.mas_equalTo(self.mobileView.mas_bottom);
    make.height.mas_greaterThanOrEqualTo(@120);
  }];
  
  [super updateViewConstraints];
}

#pragma mark - Subviews

- (CCLoginLogoView *)logoView {
  if (!_logoView) {
    _logoView = [[CCLoginLogoView alloc] init];
  }
  return _logoView;
}

- (CCLoginMobileView *)mobileView {
  if (!_mobileView) {
    _mobileView = [[CCLoginMobileView alloc] init];
  }
  return _mobileView;
}

- (CCLoginThirdPartyView *)thirdPartyView {
  if (!_thirdPartyView) {
    _thirdPartyView = [[CCLoginThirdPartyView alloc] init];
  }
  return _thirdPartyView;
}

#pragma mark - Events

/**
 *  收起键盘
 *
 *  @param touches touchesEnded
 *  @param event   UIEvent *
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}

@end