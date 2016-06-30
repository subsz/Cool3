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

@property (nonatomic, strong) BFPaperButton *countryCodeBtn;
@property (nonatomic, strong) CCLoginMobileInputField *phoneNumField;
@property (nonatomic, strong) UIView *mainLoginBtnContainerView;
@property (nonatomic, strong) BFPaperButton *mainLoginBtn;

@end

@implementation CCLoginMobileView

- (instancetype)init
{
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
}

- (void)updateConstraints {
  
  [self.countryCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.mas_equalTo(self.mas_leading).offset(-1);
    make.top.mas_equalTo(self.mas_top);
    make.height.equalTo(@70);
    make.width.equalTo(@100);
  }];
  
  [self.phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.mas_equalTo(self.countryCodeBtn.mas_trailing).offset(-1);
    make.trailing.mas_equalTo(self.mas_trailing).offset(1);
    make.top.mas_equalTo(self.countryCodeBtn.mas_top);
    make.bottom.mas_equalTo(self.countryCodeBtn.mas_bottom);
  }];
  
  [self.mainLoginBtnContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.mas_equalTo(self.mas_leading);
    make.trailing.mas_equalTo(self.mas_trailing);
    make.top.mas_equalTo(self.countryCodeBtn.mas_bottom);
    make.bottom.mas_equalTo(self.mas_bottom);
  }];
  
  [self.mainLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@50);
    make.leading.mas_equalTo(self.mainLoginBtnContainerView.mas_leading).offset(55);
    make.trailing.mas_equalTo(self.mainLoginBtnContainerView.mas_trailing).offset(-55);
    make.centerY.mas_equalTo(self.mainLoginBtnContainerView.mas_centerY);
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
  }
  return _phoneNumField;
}

- (UIView *)mainLoginBtnContainerView {
  if (!_mainLoginBtnContainerView) {
    _mainLoginBtnContainerView = [[UIView alloc] init];
    [_mainLoginBtnContainerView addSubview:self.mainLoginBtn];
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
  }
  return _mainLoginBtn;
}

@end
