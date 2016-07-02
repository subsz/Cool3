//
//  CCLoginLogoView.m
//  coolcode
//
//  Created by 庄麓达 on 16/6/30.
//  Copyright © 2016年 奇迹科技. All rights reserved.
//

#import "CCLoginLogoView.h"
#import <BFPaperButton/BFPaperButton.h>

@interface CCLoginLogoView ()

// Logo
@property (nonatomic, strong) UIImageView *logoImageView;
// App 名称
@property (nonatomic, strong) UILabel *appNameLabel;
// 提示信息容器
@property (nonatomic, strong) UIView *noticeContainerView;
// 同意条款提示文字
@property (nonatomic, strong) UILabel *agreeLabel;
// 隐私条款按钮
@property (nonatomic, strong) BFPaperButton *declarationBtn;

@end

@implementation CCLoginLogoView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setupView];
    self.backgroundColor = [UIColor whiteColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

- (void)setupView {
  [self addSubview:self.logoImageView];
  [self addSubview:self.noticeContainerView];
  [self addSubview:self.appNameLabel];
  
  [self.noticeContainerView addSubview:self.agreeLabel];
  [self.noticeContainerView addSubview:self.declarationBtn];
}

- (void)updateConstraints {
  
  [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self);
    make.top.mas_equalTo(self).offset(50).priority(250);
    make.top.mas_greaterThanOrEqualTo(self).offset(10).priority(250);
    make.width.mas_equalTo(self).multipliedBy(0.27).priority(750);
    make.width.mas_lessThanOrEqualTo(150);
    make.height.mas_equalTo(self.logoImageView.mas_width).multipliedBy(0.9);
  }];
  
  [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self);
    make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(20).priority(250);
    make.top.mas_greaterThanOrEqualTo(self.logoImageView.mas_bottom).offset(10);
  }];
  
  [self.noticeContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self);
    make.height.equalTo(@16);
    make.bottom.mas_equalTo(self).offset(-13).priority(250);
    make.bottom.mas_lessThanOrEqualTo(self).offset(-5);
    make.top.mas_greaterThanOrEqualTo(self.appNameLabel.mas_bottom).offset(10);
  }];
  
  [self.agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(self.noticeContainerView);
    make.leading.mas_equalTo(self.noticeContainerView);
  }];
  
  [self.declarationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(self.noticeContainerView);
    make.leading.mas_equalTo(self.agreeLabel.mas_trailing);
    make.trailing.mas_equalTo(self.noticeContainerView);
  }];
  
  [super updateConstraints];
}

#pragma mark - Subviews

- (UIImageView *)logoImageView {
  if (!_logoImageView) {
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.image = [UIImage imageNamed:@"logo.pdf"];
  }
  return _logoImageView;
}

- (UILabel *)appNameLabel {
  if (!_appNameLabel) {
    _appNameLabel = [[UILabel alloc] init];
    _appNameLabel.text = @"词记";
    _appNameLabel.textColor = [UIColor hx_colorWithHexString:@"#86CD3E"];
    
    _appNameLabel.font = [UIFont systemFontOfSize:[self fontSizeForAppName] weight:500];
  }
  return _appNameLabel;
}

- (UIView *)noticeContainerView {
  if (!_noticeContainerView) {
    _noticeContainerView = [[UIView alloc] init];
  }
  return _noticeContainerView;
}

- (UILabel *)agreeLabel {
  if (!_agreeLabel) {
    _agreeLabel = [[UILabel alloc] init];
    _agreeLabel.text = @"点击登录，即表示你同意";
    _agreeLabel.textColor = [UIColor hx_colorWithHexString:@"#B4B4B4"];
    _agreeLabel.font = [UIFont systemFontOfSize:[self fontSizeForNotice]];
    _agreeLabel.textAlignment = NSTextAlignmentRight;
  }
  return _agreeLabel;
}

- (BFPaperButton *)declarationBtn {
  if (!_declarationBtn) {
    _declarationBtn = [[BFPaperButton alloc] init];
    _declarationBtn.layer.masksToBounds = YES;
    _declarationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _declarationBtn.shadowColor = [UIColor clearColor];
    [_declarationBtn setTitleFont:[UIFont systemFontOfSize:[self fontSizeForNotice]]];
    [_declarationBtn setTitleColor:[UIColor hx_colorWithHexString:@"#86CD3E"] forState:UIControlStateNormal];
    [_declarationBtn setTitleColor:[UIColor hx_colorWithHexString:@"#86CD3E"] forState:UIControlStateHighlighted];
    [_declarationBtn setTitle:@"《法律声明及隐私政策》" forState:UIControlStateNormal];
  }
  return _declarationBtn;
}

#pragma mark - Subviews Font Size

- (CGFloat)fontSizeForAppName {
  if (kScreenWidth <= kScreenWidthiPhone5) {
    return 21;
  }
  return 23;
}

- (CGFloat)fontSizeForNotice {
  if (kScreenWidth <= kScreenWidthiPhone5) {
    return 12;
  }
  return 13;
}

@end
