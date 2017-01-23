//
//  TuWanListCell.h
//  BaseProject
//
//  Created by tarena-ZeRO on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRImageView.h"
@interface TuWanListCell : UITableViewCell
//* 左侧图片 */
@property(nonatomic,strong)TRImageView *iconIV;
//* 题目标签 */
@property(nonatomic,strong)UILabel *titleLb;
//* 长题目标签 */
@property(nonatomic,strong)UILabel *longTitleLb;
//* 点击数标签 */
//* laben for clicks number */
@property(nonatomic,strong)UILabel *clicksNumLb;
@end
