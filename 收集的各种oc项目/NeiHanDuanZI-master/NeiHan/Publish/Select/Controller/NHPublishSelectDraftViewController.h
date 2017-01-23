//
//  NHPublishSelectDraftViewController.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableViewController.h"

@interface NHPublishSelectDraftViewController : NHBaseTableViewController
/** 点击回调*/
@property (nonatomic, copy) void(^publishSelectDraftSelectNameHandle)(NHPublishSelectDraftViewController *controller, NSString *name, NSInteger cateogry_id);

@end
