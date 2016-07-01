//
//  CCLoginMobileView.m
//  coolcode
//
//  Created by 庄麓达 on 16/6/30.
//  Copyright © 2016年 奇迹科技. All rights reserved.
//

#import "CCLoginMobileView.h"
#import "CCLoginMobileInputField.h"
#import "UIColor+CC.h"
#import <HexColors/HexColors.h>
#import "Masonry.h"
#import <BFPaperButton/BFPaperButton.h>

@interface CCLoginMobileView ()

// 国家代码按钮
@property (nonatomic, strong) BFPaperButton *countryCodeBtn;
// 手机号码输入框
@property (nonatomic, strong) CCLoginMobileInputField *phoneNumField;
// 登录按钮容器，用于垂直居中登录按钮
@property (nonatomic, strong) UIView *mainLoginBtnContainerView;
// 登录按钮
@property (nonatomic, strong) BFPaperButton *mainLoginBtn;

@end

@implementation CCLoginMobileView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setupView];
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

- (void)setupView {
  [self addSubview:self.countryCodeBtn];
  [self addSubview:self.phoneNumField];
  [self addSubview:self.mainLoginBtnContainerView];
  [self.mainLoginBtnContainerView addSubview:self.mainLoginBtn];
}

- (void)updateConstraints {
  
  [self.countryCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.mas_equalTo(self).offset(-1);
    make.top.mas_equalTo(self);
    make.height.equalTo(@70);
    make.width.equalTo(@100);
  }];
  
  [self.phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.mas_equalTo(self.countryCodeBtn.mas_trailing).offset(-1);
    make.trailing.mas_equalTo(self).offset(1);
    make.top.mas_equalTo(self.countryCodeBtn);
    make.bottom.mas_equalTo(self.countryCodeBtn);
  }];
  
  [self.mainLoginBtnContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.mas_equalTo(self);
    make.trailing.mas_equalTo(self);
    make.top.mas_equalTo(self.countryCodeBtn.mas_bottom);
    make.bottom.mas_equalTo(self);
  }];
  
  [self.mainLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@50);
    make.leading.mas_equalTo(self.mainLoginBtnContainerView).offset(55);
    make.trailing.mas_equalTo(self.mainLoginBtnContainerView).offset(-55);
    make.centerY.mas_equalTo(self.mainLoginBtnContainerView);
  }];
  
  [super updateConstraints];
}

#pragma mark - Subviews

- (BFPaperButton *)countryCodeBtn {
  if (!_countryCodeBtn) {
    _countryCodeBtn = [[BFPaperButton alloc] init];
    _countryCodeBtn.layer.masksToBounds = YES;
    _countryCodeBtn.shadowColor = [UIColor clearColor];
    [_countryCodeBtn setTitle:@"+86" forState:UIControlStateNormal];
    
    [_countryCodeBtn setTitleFont:[UIFont systemFontOfSize:18]];
    [_countryCodeBtn setTitleColor:[UIColor hx_colorWithHexString:@"#787878"] forState:UIControlStateNormal];
    [_countryCodeBtn setTitleColor:[UIColor hx_colorWithHexString:@"#787878"] forState:UIControlStateHighlighted];
    _countryCodeBtn.layer.borderColor = [[UIColor hx_colorWithHexString:@"#F5F5F5"] CGColor];
    _countryCodeBtn.layer.borderWidth = 1;
  }
  return _countryCodeBtn;
}

- (CCLoginMobileInputField *)phoneNumField {
  if (!_phoneNumField) {
    _phoneNumField = [[CCLoginMobileInputField alloc] init];
    _phoneNumField.placeholder = @"输入手机号";
    _phoneNumField.font = [UIFont systemFontOfSize:18];
    _phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumField.layer.borderColor = [[UIColor hx_colorWithHexString:@"#F5F5F5"] CGColor];
    _phoneNumField.layer.borderWidth = 1;
    [_phoneNumField addTarget:self action:@selector(phoneNumFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
  }
  return _phoneNumField;
}

- (UIView *)mainLoginBtnContainerView {
  if (!_mainLoginBtnContainerView) {
    _mainLoginBtnContainerView = [[UIView alloc] init];
  }
  return _mainLoginBtnContainerView;
}

- (BFPaperButton *)mainLoginBtn {
  if (!_mainLoginBtn) {
    _mainLoginBtn = [[BFPaperButton alloc] init];
    _mainLoginBtn.layer.masksToBounds = YES;
    _mainLoginBtn.layer.cornerRadius = 48 * 0.5;
    _mainLoginBtn.shadowColor = [UIColor clearColor];
    [_mainLoginBtn setTitleFont:[UIFont systemFontOfSize:16 weight:500]];
    _mainLoginBtn.backgroundColor = [UIColor hx_colorWithHexString:@"#DCDCDC"];
    _mainLoginBtn.userInteractionEnabled = NO; //登录按钮默认不能点击
    [_mainLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mainLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_mainLoginBtn setTitle:@"无需注册，快速登录" forState:UIControlStateNormal];
    [_mainLoginBtn addTarget:self action:@selector(mainLoginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
  }
  return _mainLoginBtn;
}

#pragma mark - Events

- (void)phoneNumFieldEditingChanged {
  if (self.phoneNumField.text.length == 11) {
    self.mainLoginBtn.userInteractionEnabled = YES;
    [self.mainLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mainLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.mainLoginBtn.backgroundColor = [UIColor grayColor];
  } else {
    self.mainLoginBtn.userInteractionEnabled = NO;
    [self.mainLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mainLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.mainLoginBtn.backgroundColor = [UIColor hx_colorWithHexString:@"#DCDCDC"];
  }
}

- (void)mainLoginBtnClicked {
  if (self.delegate && [self.delegate respondsToSelector:@selector(mainLoginBtnClicked:phoneNum:)]) {
    [self.delegate mainLoginBtnClicked:self.mainLoginBtn phoneNum:self.phoneNumField.text];
  }
}

@end
