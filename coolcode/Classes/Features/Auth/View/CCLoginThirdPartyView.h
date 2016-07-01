//
//  CCLoginThirdPartyView.h
//  coolcode
//
//  Created by 庄麓达 on 16/6/30.
//  Copyright © 2016年 奇迹科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCLoginThirdPartyButtonType) {
  CCLoginThirdPartyButtonTypeWechat = 1,
  CCLoginThirdPartyButtonTypeQQ   = 2,
  CCLoginThirdPartyButtonTypeFacebook  = 3,
  CCLoginThirdPartyButtonTypeTwitter   = 4,
};

@protocol CCLoginThirdPartyViewDelegate <NSObject>

@required

/**
 * 第三方登录按钮被点击后触发
 * @param buttonType 被点击的按钮类型
 */
- (void)thirdPartyLoginButtonClicked:(CCLoginThirdPartyButtonType)buttonType;

@end

@interface CCLoginThirdPartyView : UIView

@property (nonatomic, weak) id<CCLoginThirdPartyViewDelegate> delegate;

@end
