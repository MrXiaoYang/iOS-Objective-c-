//
//  BTSearchVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTMessageVC.h"
#import "BTOptionCell.h"
#import "BTOption.h"
#import "BTUserManager.h"
#import "BTRedSopt.h"
#import "BTFirstpageElement.h"
#import "BTMessageOpeartionCell.h"
#import "BTSubjectVC.h"
#import "BTMessageListVC.h"

@interface BTMessageVC()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) BTRedSpot *redSpot;

@end


@implementation BTMessageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    
    [self setupTableView];
}

- (void)loadData
{
    [BTUserManager getRedSpotSuccessHandler:^(BTRedSpot *spot) {
        self.redSpot =  spot;
        [self.dataSource addObjectsFromArray:spot.element];
        [self.tableView reloadData];
    } failureHandler:nil];
}

- (void)setupTableView
{
	self.tableView.backgroundColor = kUIColorFromRGB(0xeeeeee);
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <5) {
        return 50.0f;
    }else if (indexPath.row == 5){
        return 55.0f;
    }else{
        return 153.0f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<5) {
        BTOptionCell *cell = [BTOptionCell cellWithTableView:tableView];
        cell.option = self.dataSource[indexPath.row];
        [cell hideSpeatorLine:indexPath.row == 4];
        return cell;
    }else if (indexPath.row == 5){
        BTMessageDiverLabelCell *cell = [BTMessageDiverLabelCell cellWithTableView:tableView];
        cell.title = @"热门活动";
        return cell;
    }else{
        BTMessageOpeartionCell *cell = [BTMessageOpeartionCell cellWithTableView:tableView];
        cell.element = self.redSpot.element[indexPath.row - 6];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 5) {
        BTFirstpageElement *element = self.redSpot.element[indexPath.row - 6];
        BTSubjectVC *subjectVC = [[BTSubjectVC alloc] init];
        if (element.extend.length) {
            subjectVC.extendId = [element.extend integerValue];
            [self.navigationController pushViewController:subjectVC animated:YES];
        }
    }else if (indexPath.row <= 4){
        BTMessageListVC *messageListVC = [[BTMessageListVC alloc] init];
        messageListVC.messageType = [self typeWithIndexPathRow:indexPath.row];
        [self.navigationController pushViewController:messageListVC animated:YES];
    }
}

- (BTMessageType)typeWithIndexPathRow:(NSInteger)indexPathRow
{
    switch (indexPathRow) {
        case 0:
            return BTMessageTypeNewFans;
            break;
        case 1:
            return BTMessageTypeNewComment;
            break;
        case 2:
            return BTMessageTypeNewLike;
            break;
        case 3:
            return BTMessageTypeNewReward;
            break;
        case 4:
            return BTMessageTypeNotification;
            break;
        default:
            break;
    }
    return 0;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        BTOption *fansOption = [[BTOption alloc] initWithName:@"新的粉丝"
                                                     icon:@"icon_message_user"
                                              pushVCClass:[UIViewController class]];
        
        BTOption *commentOption = [[BTOption alloc] initWithName:@"新的评论"
                                                     icon:@"icon_message_comment"
                                              pushVCClass:[UIViewController class]];
        
        BTOption *likeOption = [[BTOption alloc] initWithName:@"新的喜欢"
                                                     icon:@"icon_message_like"
                                              pushVCClass:[UIViewController class]];
        
        BTOption *rewardOption = [[BTOption alloc] initWithName:@"新的奖励"
                                                     icon:@"icon_message_reward"
                                              pushVCClass:[UIViewController class]];
        
        BTOption *notiOption = [[BTOption alloc] initWithName:@"新的通知"
														 icon:@"icon_message_notification"
												  pushVCClass:[UIViewController class]];
        
        [_dataSource addObject:fansOption];
        [_dataSource addObject:commentOption];
        [_dataSource addObject:likeOption];
        [_dataSource addObject:rewardOption];
        [_dataSource addObject:notiOption];
    }
    return _dataSource;
}
@end
