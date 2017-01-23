//
//  MyViewController.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    __weak IBOutlet UIImageView *headBackgroundImage;
    
    BOOL isLogin;
}

/**
 *  个人页面里的九个功能按钮,用collectionView来实现
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end
