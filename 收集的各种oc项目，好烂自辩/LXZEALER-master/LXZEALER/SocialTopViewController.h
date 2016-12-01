//
//  SocialTopViewController.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/3.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@interface SocialTopViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)moreButtonAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
