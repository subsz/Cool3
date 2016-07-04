//
//  CCLoginMobileInputField.m
//  coolcode
//
//  Created by 庄麓达 on 16/6/30.
//  Copyright © 2016年 奇迹科技. All rights reserved.
//

#import "CCLoginMobileInputField.h"

@implementation CCLoginMobileInputField

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
  return CGRectInset(bounds, 15, 2);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
  return CGRectInset(bounds, 15, 2);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  return CGRectInset(bounds, 15, 2);
}

@end
