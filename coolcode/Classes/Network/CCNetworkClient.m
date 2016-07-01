//
// Created by 杨玉刚 on 6/29/16.
// Copyright (c) 2016 奇迹科技. All rights reserved.
//

#import "CCNetworkClient.h"
#import <StarterKit/SKErrorResponseModel.h>

@implementation SKHTTPSessionManager (NetworkClient)

- (AnyPromise *)sendCaptcha:(NSString *)mobile {
  return [self pmk_POST:@"/captcha/send/mobile" parameters:@{@"mobile" : mobile}];
}

+ (NSDictionary *)modelClassesByResourcePath {
  return @{
           @"captcha/send/mobile" : [SKErrorResponseModel class],
           };
}

@end