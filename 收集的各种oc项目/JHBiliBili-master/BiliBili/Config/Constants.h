//
//  Constants.h
//  BaseProject
//
//  Created by JimHuang on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//通过RGB设置颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define kRGBAColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度


//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}\

/**
 *  Docment文件夹目录
 */
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

/**
 *  cache文件夹目录
 */
#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

/**
 *  离线缓存文件路径
 */
#define kArchiverCachePath [kCachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/src.arch",[[NSBundle mainBundle] bundleIdentifier]]]
/**
 *  下载文件夹目录
 */
#define kDownloadPath [kDocumentPath stringByAppendingPathComponent: @"download"]
/**
 *  VideoModel归档文件夹目录
 */
#define kArchPath [kDocumentPath stringByAppendingPathComponent: @"arch"]

/**
 *  appkey
 */
#define APPKEY @""

/**
 *  appsec
 */
#define APPSEC @""

/**
 *  默认网络错误信息
 */
#define kerrorMessage @"网络连接出错_(:3 」∠)_"


#endif /* Constants_h */
