//
//  BTListPostInfoView.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTListPost,BTListPostInfoView,BTTag;
@protocol BTListPostInfoViewDelegate <NSObject>

/** 点击了头像 */
- (void)listInfoView:(BTListPostInfoView *)listInfoView didClickIconButtonWithListPost:(BTListPost *)listPost;

/** 点击了关注 */
- (void)listInfoView:(BTListPostInfoView *)listInfoView didClickAttentionButtonWithListPost:(BTListPost *)listPost;

/** 点击了tag标签 */
- (void)listInfoView:(BTListPostInfoView *)listInfoView didClickTag:(BTTag *)tag;

@end

@interface BTListPostInfoView : UIView

@property (nonatomic, weak)id <BTListPostInfoViewDelegate> delegate;

@property (nonatomic, strong) BTListPost *listPost;

@property (nonatomic, assign, getter=isAttention) BOOL attention;

@end
