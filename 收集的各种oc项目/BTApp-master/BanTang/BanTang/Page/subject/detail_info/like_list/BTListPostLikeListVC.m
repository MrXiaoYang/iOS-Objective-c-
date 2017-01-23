//
//  BTListPostLikeListVC.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostLikeListVC.h"
#import "BTSubjectAuthor.h"
#import <UIImageView+WebCache.h>
#import "BTLikesUserCell.h"
#import "BTProductManager.h"
@interface BTListPostLikeListVC ()

@end

@implementation BTListPostLikeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"喜欢列表";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    if (self.extendID.length > 0) {
        [BTProductManager getProductLikesListWithObjectID:self.extendID success:^(NSArray *likesList) {
            self.likesUserArray = likesList;
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.likesUserArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTSubjectAuthor *author = self.likesUserArray[indexPath.row];
    BTLikesUserCell *cell = [BTLikesUserCell cellWithTableView:tableView];
    cell.author = author;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
