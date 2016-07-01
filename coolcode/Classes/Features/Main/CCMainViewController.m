//
// Created by 杨玉刚 on 6/29/16.
// Copyright (c) 2016 奇迹科技. All rights reserved.
//

#import "CCMainViewController.h"
#import "CCLoginViewController.h"

@interface CCMainViewController ()

@end

@implementation CCMainViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if (![self hasLogin]) {
    CCLoginViewController *loginViewController = [[CCLoginViewController alloc] init];
    [self presentViewController:loginViewController animated:NO completion:nil];
  }
}

- (BOOL)hasLogin {
  return NO;
}

@end