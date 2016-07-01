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
#import <MBProgressHUD/MBProgressHUD.h>


@interface CCLoginViewController () <CCLoginMobileViewDelegate, CCLoginThirdPartyViewDelegate>

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

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  //监听键盘弹入弹出事件
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  //取消监听键盘弹入弹出事件
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)updateViewConstraints {
  UIView *superView = self.view;
  
  [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(superView);
    make.leading.mas_equalTo(superView);
    make.trailing.mas_equalTo(superView);
    make.height.equalTo(@250).priority(250);
    make.height.mas_greaterThanOrEqualTo(superView).multipliedBy(0.4).priority(750);
  }];
  
  [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.logoView.mas_bottom);
    make.leading.mas_equalTo(superView);
    make.trailing.mas_equalTo(superView);
    make.bottom.mas_equalTo(self.thirdPartyView.mas_top);
    make.height.mas_greaterThanOrEqualTo(superView).multipliedBy(0.3).priority(750);
  }];
  
  [self.thirdPartyView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    make.leading.mas_equalTo(superView);
    make.trailing.mas_equalTo(superView);
    make.top.mas_equalTo(self.mobileView.mas_bottom);
    make.height.mas_greaterThanOrEqualTo(@120);
    make.height.mas_greaterThanOrEqualTo(superView).multipliedBy(0.3).priority(750);
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
    _thirdPartyView.delegate = self;
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

#pragma mark Notification

- (void)handleKeyboardNotification: (NSNotification *)notification {
  NSDictionary* userInfo = notification.userInfo;

  // 获取键盘弹出动画的时间
  NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationOptions animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  
  // 获取键盘弹出到的位置 Frame
  CGRect keyboardScreenEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  
  // 更新Constraint
  [self.mobileView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.top.mas_lessThanOrEqualTo(self.mas_bottomLayoutGuide).offset(-70 - keyboardScreenEndFrame.size.height);
  }];
  [self.view setNeedsUpdateConstraints];
  
  //动画效果
  UIViewAnimationOptions animationOptions = animationCurve | UIViewAnimationOptionBeginFromCurrentState;
  [UIView animateWithDuration:animationDuration delay:0 options:animationOptions animations:^{
    [self.view layoutIfNeeded];
  } completion:nil];
}

#pragma mark - <CCLoginMobileViewDelegate>

// 登录按钮响应方法
- (void)mainLoginBtnClicked:(UIButton *)mainLoginBtn phoneNum:(NSString *)phoneNum{
  // 键盘不收起的话会挡住下面的 Toast, 暂时先这么写
  [self.view endEditing:YES];
  if (phoneNum.length != 11) {
    [SKToastUtil toastWithText:@"手机号码不合要求"];
    return;
  }
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [self.sessionManager sendCaptcha:phoneNum].then(^(OVCResponse * response) {
    SKErrorResponseModel *model = response.result;
    [SKToastUtil toastWithText:model.message];
    
  }).catch(^(NSError *error) {
    [SKToastUtil toastWithText:[SKErrorResponseModel buildMessageWithNetworkError:error]];
  }).finally(^{
    [hud hide:YES];
  });
}

#pragma mark - <CCLoginThirdPartyViewDelegate>

- (void)thirdPartyLoginButtonClicked:(CCLoginThirdPartyButtonType)buttonType {
  switch (buttonType) {
    case CCLoginThirdPartyButtonTypeWechat:
      [SKToastUtil toastWithText:@"Button: Wechat Clicked"];
      break;
    case CCLoginThirdPartyButtonTypeQQ:
      [SKToastUtil toastWithText:@"Button: QQ Clicked"];
      break;
    case CCLoginThirdPartyButtonTypeFacebook:
      [SKToastUtil toastWithText:@"Button: Facebook Clicked"];
      break;
    case CCLoginThirdPartyButtonTypeTwitter:
      [SKToastUtil toastWithText:@"Button: Twitter Clicked"];
      break;
    default:
      break;
  }
}

@end