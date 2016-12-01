//
//  ShiBanEpisodeCollectionViewController.h
//  BiliBili
//
//  Created by apple-jd44 on 15/12/3.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class episodesModel;
@interface ShiBanEpisodeCollectionViewController : UICollectionViewController
@property (nonatomic, strong) NSArray<episodesModel*>* episodes;
@end
