//
//  Common.h
//  coolcode
//
//  Created by 庄麓达 on 16/7/2.
//  Copyright © 2016年 奇迹科技. All rights reserved.
//

#ifndef Common_h
#define Common_h

//获取物理屏幕尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenHeightiPhone4 480
#define kScreenHeightiPhone5 568
#define kScreenHeightiPhone6 667
#define kScreenHeightiPhone6P 736

#define kScreenWidthiPhone4 320
#define kScreenWidthiPhone5 320
#define kScreenWidthiPhone6 375
#define kScreenWidthiPhone6P 414

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == kScreenHeightiPhone4)
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == kScreenHeightiPhone5)

#endif /* Common_h */
