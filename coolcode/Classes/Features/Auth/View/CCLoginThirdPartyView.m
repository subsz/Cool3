//
//  CCLoginThirdPartyView.m
//  coolcode
//
//  Created by 庄麓达 on 16/6/30.
//  Copyright © 2016年 奇迹科技. All rights reserved.
//

#import "CCLoginThirdPartyView.h"

// 第三方登录按钮相对于屏幕宽度的比例（含透明边界）
CGFloat const kThirdPartyLoginBtnWithEdgeWidthRatio = 0.155;
// 第三方登录按钮相对于屏幕宽度的比例（不含透明边界）
CGFloat const kThirdPartyLoginBtnWithoutEdgeWidthRatio = 0.133;
// 第三方登录按钮的最大宽度（含透明边界）
CGFloat const kThirdPartyLoginBtnMaxWidth = 85;

@interface CCLoginThirdPartyView()

// 内容容器，用于垂直居中
@property (nonatomic, strong) UIView   *contentContainerView;
// 社交账号登录文字标签
@property (nonatomic, strong) UILabel  *textLabel;
// 微信按钮
@property (nonatomic, strong) UIButton *wechatBtn;
// QQ 按钮
@property (nonatomic, strong) UIButton *qqBtn;
// Facebook 按钮
@property (nonatomic, strong) UIButton *facebookBtn;
// Twitter 按钮
@property (nonatomic, strong) UIButton *twitterBtn;

@end

@implementation CCLoginThirdPartyView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setupView];
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#FAFAFA"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

- (void)setupView {
  [self addSubview:self.contentContainerView];
  [self.contentContainerView addSubview:self.textLabel];
  [self.contentContainerView addSubview:self.wechatBtn];
  [self.contentContainerView addSubview:self.qqBtn];
  [self.contentContainerView addSubview:self.wechatBtn];
  [self.contentContainerView addSubview:self.facebookBtn];
  [self.contentContainerView addSubview:self.twitterBtn];
}

- (void)updateConstraints {
  
  // 第三方登录按钮的切图四周有透明边界，
  // 在这里进行一些额外的计算以尽可能的去除这些透明边界的影响。
  CGFloat btnWidthWithoutEdge = kScreenWidth * kThirdPartyLoginBtnWithoutEdgeWidthRatio;
  btnWidthWithoutEdge = btnWidthWithoutEdge > kThirdPartyLoginBtnMaxWidth ? kThirdPartyLoginBtnMaxWidth : btnWidthWithoutEdge;
  CGFloat btnTransparentEdgeWidth = (btnWidthWithoutEdge * (kThirdPartyLoginBtnWithEdgeWidthRatio / kThirdPartyLoginBtnWithoutEdgeWidthRatio) - btnWidthWithoutEdge) * 0.5;
  
  [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.mas_equalTo(self);
    make.trailing.mas_equalTo(self);
    make.centerY.mas_equalTo(self);
    make.height.mas_equalTo(btnWidthWithoutEdge * 1.5 + 35);
  }];
  
  [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.contentContainerView);
    make.top.mas_equalTo(self.contentContainerView);
  }];
  
  [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.qqBtn.mas_left).offset(btnWidthWithoutEdge * -0.5 + btnTransparentEdgeWidth * 2);
    make.centerY.mas_equalTo(self.qqBtn);
    make.size.mas_equalTo(self.qqBtn);
  }];
  
  [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.contentContainerView.mas_centerX).offset(btnWidthWithoutEdge * -0.25 + btnTransparentEdgeWidth);
    make.top.mas_equalTo(self.textLabel.mas_bottom).offset(btnWidthWithoutEdge * 0.5 - btnTransparentEdgeWidth);
    make.width.mas_equalTo(self.contentContainerView).multipliedBy(kThirdPartyLoginBtnWithEdgeWidthRatio).priority(950);
    make.width.mas_lessThanOrEqualTo(kThirdPartyLoginBtnMaxWidth);
    make.height.mas_equalTo(self.qqBtn.mas_width);
  }];
  
  [self.facebookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.contentContainerView.mas_centerX).offset(btnWidthWithoutEdge * 0.25 - btnTransparentEdgeWidth);
    make.centerY.mas_equalTo(self.qqBtn);
    make.size.mas_equalTo(self.qqBtn);
  }];
  
  [self.twitterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.facebookBtn.mas_right).offset(btnWidthWithoutEdge * 0.5 - btnTransparentEdgeWidth * 2);
    make.centerY.mas_equalTo(self.qqBtn);
    make.size.mas_equalTo(self.qqBtn);
  }];
  
  [super updateConstraints];
}

#pragma mark - SubViews

- (UIView *)contentContainerView {
  if (!_contentContainerView) {
    _contentContainerView = [[UIView alloc] init];
  }
  return _contentContainerView;
}

- (UILabel *)textLabel {
  if (!_textLabel) {
    _textLabel = [[UILabel alloc] init];
    _textLabel.text = @"社交账号登录";
    _textLabel.font = [UIFont systemFontOfSize:[self fontSizeForTextLabel]];
    _textLabel.textColor = [UIColor hx_colorWithHexString:@"646464"];
    _textLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _textLabel;
}

- (UIButton *)wechatBtn {
  if (!_wechatBtn) {
    _wechatBtn = [[UIButton alloc] init];
    _wechatBtn.layer.cornerRadius = 60/2;
    _wechatBtn.clipsToBounds = YES;
    _wechatBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _wechatBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_wechatBtn setImage:[UIImage imageNamed:@"ic_social_wechat.pdf"] forState:UIControlStateNormal];
    [_wechatBtn addTarget:self action:@selector(wechatBtnClicked) forControlEvents:UIControlEventTouchUpInside];
  }
  return _wechatBtn;
}

- (UIButton *)qqBtn {
  if (!_qqBtn) {
    _qqBtn = [[UIButton alloc] init];
    _qqBtn.layer.cornerRadius = 60/2;
    _qqBtn.clipsToBounds = YES;
    _qqBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _qqBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_qqBtn setImage:[UIImage imageNamed:@"ic_social_qq.pdf"] forState:UIControlStateNormal];
    [_qqBtn addTarget:self action:@selector(qqBtnClicked) forControlEvents:UIControlEventTouchUpInside];
  }
  return _qqBtn;
}

- (UIButton *)facebookBtn {
  if (!_facebookBtn) {
    _facebookBtn = [[UIButton alloc] init];
    _facebookBtn.layer.cornerRadius = 60/2;
    _facebookBtn.clipsToBounds = YES;
    _facebookBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _facebookBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_facebookBtn setImage:[UIImage imageNamed:@"ic_social_facebook.pdf"] forState:UIControlStateNormal];
    [_facebookBtn addTarget:self action:@selector(facebookBtnClicked) forControlEvents:UIControlEventTouchUpInside];
  }
  return _facebookBtn;
}

- (UIButton *)twitterBtn {
  if (!_twitterBtn) {
    _twitterBtn = [[UIButton alloc] init];
    _twitterBtn.layer.cornerRadius = 60/2;
    _twitterBtn.clipsToBounds = YES;
    _twitterBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _twitterBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_twitterBtn setImage:[UIImage imageNamed:@"ic_social_twitter.pdf"] forState:UIControlStateNormal];
    [_twitterBtn addTarget:self action:@selector(twitterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
  }
  return _twitterBtn;
}

#pragma mark - Subviews Font Size

- (CGFloat)fontSizeForTextLabel {
  if (kScreenWidth <= kScreenWidthiPhone5) {
    return 14;
  }
  return 17;
}

#pragma mark - Events

- (void)wechatBtnClicked {
  if (self.delegate && [self.delegate respondsToSelector:@selector(thirdPartyLoginButtonClicked:)]) {
    [self.delegate thirdPartyLoginButtonClicked:CCLoginThirdPartyButtonTypeWechat];
  }
}

- (void)qqBtnClicked {
  if (self.delegate && [self.delegate respondsToSelector:@selector(thirdPartyLoginButtonClicked:)]) {
    [self.delegate thirdPartyLoginButtonClicked:CCLoginThirdPartyButtonTypeQQ];
  }
}

- (void)facebookBtnClicked {
  if (self.delegate && [self.delegate respondsToSelector:@selector(thirdPartyLoginButtonClicked:)]) {
    [self.delegate thirdPartyLoginButtonClicked:CCLoginThirdPartyButtonTypeFacebook];
  }
}

- (void)twitterBtnClicked {
  if (self.delegate && [self.delegate respondsToSelector:@selector(thirdPartyLoginButtonClicked:)]) {
    [self.delegate thirdPartyLoginButtonClicked:CCLoginThirdPartyButtonTypeTwitter];
  }
}

@end
