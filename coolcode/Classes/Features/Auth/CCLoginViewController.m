//
// Created by 杨玉刚 on 6/29/16.
// Copyright (c) 2016 奇迹科技. All rights reserved.
//
#import <PromiseKit/AnyPromise.h>
#import "CCLoginViewController.h"
#import "CCLoginThirdPartyView.h"
#import "CCLoginMobileView.h"
#import "CCLoginLogoView.h"
#import "UIColor+CC.h"
#import "Masonry.h"
#import <StarterKit/SKToastUtil.h>
#import <StarterKit/SKErrorResponseModel.h>
#import <Overcoat/Overcoat.h>
#import "CCNetworkClient.h"


@interface CCLoginViewController () <CCLoginMobileViewDelegate>

@property (nonatomic, strong) CCLoginLogoView *logoView;
@property (nonatomic, strong) CCLoginMobileView *mobileView;
@property (nonatomic, strong) CCLoginThirdPartyView *thirdPartyView;

@property (nonatomic, strong) SKHTTPSessionManager *sessionManager;

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

#pragma mark - Property Getters

- (SKHTTPSessionManager *)sessionManager {
  if (!_sessionManager) {
    _sessionManager = [[SKHTTPSessionManager alloc] init];
  }
  return _sessionManager;
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
    _mobileView.delegate = self;
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

- (void)mainLoginBtnClicked:(UIButton *)mainLoginBtn phoneNum:(NSString *)phoneNum{
  // 键盘不收起的话会挡住下面的 Toast, 暂时先这么写
  [self.view endEditing:YES];
  if (phoneNum.length != 11) {
    [SKToastUtil toastWithText:@"手机号码不合要求"];
    return;
  }

  [self.sessionManager sendCaptcha:phoneNum].then(^(OVCResponse * response) {
//    SKErrorResponseModel *model = response.result;
    
  }).catch(^(NSError *error) {
    
  }).finally(^{
  
  });
}

@end