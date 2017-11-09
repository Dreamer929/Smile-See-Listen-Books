//
//  DreamerDefine.h
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#ifndef DreamerDefine_h
#define DreamerDefine_h



#define ECIMAGENAME(_name_) [UIImage imageNamed:_name_]

#define ECCOLOR(r, g, b, a)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define DREAMSCREEN          [[UIScreen mainScreen] bounds]
#define DREAMCSCREEN_W        [[UIScreen mainScreen]bounds].size.width
#define DREAMCSCREEN_H        [[UIScreen mainScreen]bounds].size.height


/**
 *  计算文本行高
 *
 *  @param _width_  文本宽
 *  @param _string_ 文本内容
 *  @param _fsize_  文本字体
 *
 *  @return 文本尺寸
 */
#define STRING_SIZE(_width_, _string_, _fsize_) [_string_ boundingRectWithSize:CGSizeMake(_width_, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_fsize_]} context:nil].size;


/**
 *  导入头文件
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "Masonry.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "YYCache.h"


#import "RootViewController.h"
#import "BaseViewController.h"
#import "MineViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "AddNotesViewController.h"
#import "SetDetialViewController.h"
#import "ShiciDetialViewController.h"
#import "ShiciSettingViewController.h"
#import "FMViewController.h"
#import "PlayerViewController.h"

#import "MXHttpRequestCache.h"
#import "MXHttpRequestUrl.h"
#import "MXHttpRequestManger.h"

#import "RootModel.h"


#import "ShiCiTableViewCell.h"

#import "MymxConfig.h"
#import "NSString+MXString.h"




#endif /* DreamerDefine_h */
