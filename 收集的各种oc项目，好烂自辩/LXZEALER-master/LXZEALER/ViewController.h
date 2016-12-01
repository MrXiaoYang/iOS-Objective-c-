//
//  ViewController.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

