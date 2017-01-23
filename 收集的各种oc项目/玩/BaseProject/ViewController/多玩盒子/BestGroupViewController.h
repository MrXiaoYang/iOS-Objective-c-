//
//  BestGroupViewController.h
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

/*
 可以安装 多玩饭盒-首页-百科-最佳阵容查看效果
 制作步骤:
 1.创建BestGroupViewModel 
    只需要实现getData就可以了，没有分页问题
    model只提供了英雄英文名，需要拼入英雄头像链接地址才可以
 http://img.lolbox.duowan.com/champions/Annie_120x120.jpg
 2.创建BestGroupCell，继承UITableViewCell
    头像的大小固定，间距使用 (window宽-5*图片宽) /6获得
    Cell中题目最多一行， 详情简介 最多两行
    选择以后显示浅黄色
 3.BestGroupViewController制作
对于cell高度：只需要实现estimatedHeightForRow协议即可自动适应
 4.在BaiKeViewController的cell点击事件中判断 vm层的tag值是 best_group， 则跳转
 */

#import <UIKit/UIKit.h>

@interface BestGroupViewController : UIViewController

@end











