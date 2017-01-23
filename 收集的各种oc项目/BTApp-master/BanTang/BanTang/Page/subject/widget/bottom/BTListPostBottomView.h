//
//  BTListPostBottomView.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTListPostDynamic,BTListPostBottomView;
@protocol BTListPostBottomViewDelegate <NSObject>

- (void)listPostBottomViewDidClickLikeButton:(BTListPostBottomView *)bottomView;

- (void)listPostBottomViewDidClickCommentButton:(BTListPostBottomView *)bottomView;

@end

@interface BTListPostBottomView : UIView

@property (nonatomic, weak) id <BTListPostBottomViewDelegate> delegate;

@property (nonatomic, strong) BTListPostDynamic *dynamic;

@property (nonatomic, assign) BOOL collect;

@end
