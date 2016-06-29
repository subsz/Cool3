//
// Created by 杨玉刚 on 6/29/16.
// Copyright (c) 2016 奇迹科技. All rights reserved.
//

#import "UIColor+CC.h"

#import <HexColors/HexColors.h>

@implementation UIColor (CC)

+ (UIColor *)cc_backgroundColor {
  return [UIColor hx_colorWithHexString:@"#f7f6f6"];
}

+ (UIColor *)cc_primaryColor {
  return [UIColor hx_colorWithHexString:@"#ec3258"];
}

+ (UIColor *)cc_accentColor {
  return [UIColor hx_colorWithHexString:@"#ffb063"];
}

+ (UIColor *)cc_textColorPrimary {
  return [UIColor hx_colorWithHexString:@"#1a1a1a"];
}

+ (UIColor *)cc_textColorPrimaryInverse {
  return [UIColor hx_colorWithHexString:@"#fffefe"];
}

+ (UIColor *)cc_textColorSecondary {
  return [UIColor hx_colorWithHexString:@"#1a1a1a"];
}

+ (UIColor *)cc_textGrayColor {
  return [UIColor hx_colorWithHexString:@"#9b9b9b"];
}

@end