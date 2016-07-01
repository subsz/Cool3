//
//  CCLoginMobileView.h
//  coolcode
//
//  Created by 庄麓达 on 16/6/30.
//  Copyright © 2016年 奇迹科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCLoginMobileViewDelegate <NSObject>

@required

/**
 * 登陆页登录按钮被点击
 * @param mainLoginBtn 登录按钮
 * @param phoneNum 用户输入的手机号码
 */
- (void)mainLoginBtnClicked:(UIButton *)mainLoginBtn phoneNum:(NSString *)phoneNum;

@end

@interface CCLoginMobileView : UIView

@property (nonatomic, weak) id<CCLoginMobileViewDelegate> delegate;

@end
