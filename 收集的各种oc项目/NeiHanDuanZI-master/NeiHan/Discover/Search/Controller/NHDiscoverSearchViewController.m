//
//  NHDiscoverSearchViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverSearchViewController.h"
#import "NHDiscoverSearchTextField.h"
#import "UIView+Layer.h"
#import "NHDiscoverSearchRequest.h"
#import "NHHomeAttentionListSectionHeaderView.h"
#import "NHDiscoverSearchFriendCell.h"
#import "NHNeiHanUserInfoModel.h"
#import "UIViewController+Loading.h"
#import "NHDiscoverModel.h"
#import "NHHomeServiceDataModel.h"
#import "NHHomeTableViewCell.h"
#import "NHDiscoverTableViewCell.h"
#import "NHDiscoverSearchCommonCellFrame.h"
#import "NHDiscoverTopicViewController.h"
#import "NHDynamicDetailViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "NHPersonalCenterViewController.h"
#import "NHDiscoverSearchFriendUserCell.h"
#import "NHCustomCommonEmptyView.h"
#import "NHHomeDynamicRequest.h"
#import "NHHomeNeiHanShareView.h"
#import "WMPlayer.h"
#import "NHDynamicDetailReportViewController.h"
#import "NHBaseNavigationViewController.h"

@interface NHDiscoverSearchViewController () <UITextFieldDelegate, NHHomeTableViewCellDelegate, WMPlayerDelegate>
@property (nonatomic, strong) NHDiscoverSearchTextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *hotCategoryArray;
@property (nonatomic, strong) NSMutableArray *imageGroupArray;
@property (nonatomic, strong) NSMutableArray *textGroupArray;
@property (nonatomic, strong) NSMutableArray *videoGroupArray;
@property (nonatomic, strong) NSMutableArray *imageGroupCellFrameArray;
@property (nonatomic, strong) NSMutableArray *textGroupCellFrameArray;
@property (nonatomic, strong) NSMutableArray *videoGroupCellFramesArray;
@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic, weak) NHCustomCommonEmptyView *emptyView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) NHBaseImageView *imageView;
@property (nonatomic, assign) BOOL isSmallScreen;
/** 寻找更多段友*/
@property (nonatomic, assign) BOOL isFindMoreFriendsFlag;
@end

@implementation NHDiscoverSearchViewController {
    dispatch_group_t _group;
    NSInteger _currentOffet;
    WMPlayer *wmPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView: self.searchTextField];
    WeakSelf(weakSelf);
    [self nh_setUpNavRightItemTitle:@"取消" handle:^(NSString *rightItemTitle) {
        [weakSelf pop];
    }];
    
    [self.emptyView showInView:self.view];
    
}

- (void)pop {
    if (self.isFindMoreFriendsFlag) {
        self.isFindMoreFriendsFlag = NO;
        [self.tableView reloadData];
    } else {
        [super pop];
    }
}

- (void)searchWithText:(NSString *)text {
    
    [self.tableView setContentOffset:CGPointZero animated:YES];
    
    self.emptyView.hidden = YES;
    
    [self showLoadingViewWithFrame:CGRectMake(0, 0, 44, 44)];
    _group = dispatch_group_create();
    // user
    dispatch_group_enter(_group);
    NHDiscoverSearchRequest *userRequest = [NHDiscoverSearchRequest nh_request];
    userRequest.nh_url = kNHDiscoverSearchUserListAPI;
    userRequest.keyword = text;
    [userRequest nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            [self.dataArray removeAllObjects];
            self.dataArray = [NHNeiHanUserInfoModel modelArrayWithDictArray:response];
            dispatch_group_leave(_group);
        }
    }];
    
    // content
    dispatch_group_enter(_group);
    NHDiscoverSearchRequest *contentRequest = [NHDiscoverSearchRequest nh_request];
    contentRequest.nh_url = kNHDiscoverSearchDynamicListAPI;
    contentRequest.keyword = text;
    [contentRequest nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            
            [self clearAllData];
            self.textGroupArray = [NHHomeServiceDataElementGroup modelArrayWithDictArray:response[@"text"]];
            self.imageGroupArray = [NHHomeServiceDataElementGroup modelArrayWithDictArray:response[@"image"]];
            self.videoGroupArray = [NHHomeServiceDataElementGroup modelArrayWithDictArray:response[@"video"]];
            for (NHHomeServiceDataElementGroup *group in self.textGroupArray) {
                NHDiscoverSearchCommonCellFrame *cellFrame = [[NHDiscoverSearchCommonCellFrame alloc] init];
                cellFrame.group = group;
                [self.textGroupCellFrameArray addObject:cellFrame];
            }
            for (NHHomeServiceDataElementGroup *group in self.imageGroupArray) {
                NHDiscoverSearchCommonCellFrame *cellFrame = [[NHDiscoverSearchCommonCellFrame alloc] init];
                cellFrame.group = group;
                [self.imageGroupCellFrameArray addObject:cellFrame];
            }
            
            for (NHHomeServiceDataElementGroup *group in self.videoGroupArray) {
                NHDiscoverSearchCommonCellFrame *cellFrame = [[NHDiscoverSearchCommonCellFrame alloc] init];
                cellFrame.group = group;
                [self.videoGroupCellFramesArray addObject:cellFrame];
            }
            dispatch_group_leave(_group);
        }
    }];
    
    // category
    dispatch_group_enter(_group);
    NHDiscoverSearchRequest *cetegoryRequest = [NHDiscoverSearchRequest nh_request];
    cetegoryRequest.nh_url = kNHDiscoverSearchHotDraftListAPI;
    cetegoryRequest.keyword = text;
    [cetegoryRequest nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            [self.hotCategoryArray removeAllObjects];
            self.hotCategoryArray = [NHDiscoverCategoryElement modelArrayWithDictArray:response];
            dispatch_group_leave(_group);
        }
    }];
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        if (self.hotCategoryArray.count == 0 && self.textGroupArray.count == 0 && self.imageGroupArray.count ==0 && self.videoGroupArray.count == 0) {
            self.emptyView.hidden = NO;
            self.emptyView.topTipImageView.image = [UIImage imageNamed:@"searchresults"];
            self.emptyView.firstL.text = @"居然没有结果";
            self.emptyView.secondL.text = @"换个词再试试";
        } else {
            self.emptyView.hidden = YES;
        }
        
//        self.refreshType = NHBaseTableVcRefreshTypeOnlyCanLoadMore;
        [self hideLoadingView];
        [self nh_reloadData];
    });
}

- (void)nh_loadMore {
    [super nh_loadMore];
//    if (self.isFindMoreFriendsFlag) {
//        // user
//        NHDiscoverSearchRequest *userRequest = [NHDiscoverSearchRequest nh_request];
//        userRequest.nh_url = kNHDiscoverSearchUserListAPI;
//        userRequest.keyword = self.keyWord;
//        userRequest.offset = (_currentOffet += 10);
//        [userRequest nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
//            [self nh_endLoadMore];
//            if (success) {
//                NSArray *newModels = [NHNeiHanUserInfoModel modelArrayWithDictArray:response];
//                [self.dataArray addObject:newModels];
//                if (newModels.count == 0) {
//                    [self nh_noticeNoMoreData];
//                }
//                [self nh_reloadData];
//            }
//        }];
//    } else {
//        [self nh_noticeNoMoreData];
//    }
}

- (void)clearAllData {
    [self.textGroupArray removeAllObjects];
    [self.imageGroupArray removeAllObjects];
    [self.videoGroupArray removeAllObjects];
    [self.textGroupCellFrameArray removeAllObjects];
    [self.imageGroupCellFrameArray removeAllObjects];
    [self.videoGroupCellFramesArray removeAllObjects];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSString *searchText = textField.text;
    if (searchText.length) {
        self.keyWord = searchText;
        [self searchWithText:searchText];
    }
    return YES;
}

#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    if (self.isFindMoreFriendsFlag) {
        return 1;
    }
    NSInteger number = (self.dataArray.count > 0 ? 1 : 0) + (self.textGroupArray.count > 0 ? 1 : 0) + (self.videoGroupArray.count > 0 ? 1 : 0) + (self.imageGroupArray.count > 0 ? 1 : 0) + (self.hotCategoryArray.count > 0 ? 1 : 0);
    return number;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    
    if (self.isFindMoreFriendsFlag) {
        return self.dataArray.count;
    }
    if (section == 0) {
        return self.hotCategoryArray.count ;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return self.textGroupArray.count  ;
    } else if (section == 3) {
        return self.videoGroupArray.count  ;
    } else if (section == 4) {
        return self.imageGroupArray.count ;
    }
    return 0;
}

- (UIView *)nh_headerAtSection:(NSInteger)section {
    
    NHHomeAttentionListSectionHeaderView *view = [NHHomeAttentionListSectionHeaderView headerFooterViewWithTableView:self.tableView];
    
    if (self.isFindMoreFriendsFlag) {
        view.tipText = @"段友搜索";
        return view;
    }
    NSString *text = @"";
    if (section == 0) {
        text = self.hotCategoryArray.count ? @"热吧" : @"";
    } else if (section == 1) {
        text = self.dataArray.count ? @"段友" : @"";
    } else if (section == 2) {
        text = self.textGroupArray.count ? @"文字" : @"";
    } else if (section == 3) {
        text = self.videoGroupArray.count ? @"视频" : @"";
    }  else if (section == 4) {
        text = self.imageGroupArray.count ? @"图片" : @"";
    }
    view.tipText = text;
    return view;
}

- (CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section {
    if (self.isFindMoreFriendsFlag) {
        return 44;
    }
    if (section == 0) {
        return self.hotCategoryArray.count ? 44 : 0;
    } else if (section == 1) {
        return self.dataArray.count ? 44 : 0;
    } else if (section == 2) {
        return self.textGroupArray.count ? 44 : 0;
    } else if (section == 3) {
        return self.videoGroupArray.count ? 44 : 0;
    } else if (section == 4) {
        return self.imageGroupArray.count ? 44 : 0;
    }
    return 0;
}

- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isFindMoreFriendsFlag) {
        NHDiscoverSearchFriendUserCell *cell = [NHDiscoverSearchFriendUserCell cellWithTableView:self.tableView];
        cell.userInfoModel = self.dataArray[indexPath.row];
        return cell;
    }
    // 1. 热吧
    // 2. 段友
    // 3. 文字
    // 4. 视频
    // 5. 图片
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        NHDiscoverTableViewCell *cell = [NHDiscoverTableViewCell cellWithTableView:self.tableView];
        [cell setElementModel:self.hotCategoryArray[indexPath.row] keyWord:self.keyWord];
        return cell;
    } else if (section == 1) {
        WeakSelf(weakSelf);
        NHDiscoverSearchFriendCell *cell = [NHDiscoverSearchFriendCell cellWithTableView:self.tableView];
        cell.keyWord = self.keyWord;
        cell.models = self.dataArray;
        cell.discoverSearchFriendCellGotoPersonalCenter = ^(NSInteger user_id) {
            NHPersonalCenterViewController *controller = [[NHPersonalCenterViewController alloc] initWithUserId:user_id];
            [weakSelf pushVc:controller];
        };
        cell.discoverSearchFriendCellMoreFriends = ^() {
            weakSelf.isFindMoreFriendsFlag = YES;
            [weakSelf.tableView reloadData];
        };
        return cell;
    } else {
        NHDiscoverSearchCommonCellFrame *searchCellFrame = nil;
        if (section == 2) {
            searchCellFrame = self.textGroupCellFrameArray[indexPath.row];
        } else if (section == 3) {
            searchCellFrame = self.videoGroupCellFramesArray[indexPath.row];
        } else if (section == 4) {
            searchCellFrame = self.imageGroupCellFrameArray[indexPath.row];
        }
        NHHomeTableViewCell *cell = [NHHomeTableViewCell cellWithTableView:self.tableView];
        [cell setSearchCellFrame:searchCellFrame keyWord:self.keyWord];
        cell.delegate = self;
        return cell;
    }
    return [[NHBaseTableViewCell alloc] init];
    
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isFindMoreFriendsFlag) {
        return 75;
    }
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 75;
    } else if (section == 1) {
        return 150;
    } else {
        NHDiscoverSearchCommonCellFrame *searchCellFrame = nil;
        if (section == 2) {
            searchCellFrame = self.textGroupCellFrameArray[indexPath.row];
        } else if (section == 3) {
            searchCellFrame = self.videoGroupCellFramesArray[indexPath.row];
        } else if (section == 4) {
            searchCellFrame = self.imageGroupCellFrameArray[indexPath.row];
        }
        return searchCellFrame.cellHeight;
    }
    return 0;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell {
    if (self.isFindMoreFriendsFlag) {
        NHNeiHanUserInfoModel *userInfo = self.dataArray[indexPath.row];
        NHPersonalCenterViewController *controller = [[NHPersonalCenterViewController alloc] initWithUserInfoModel:userInfo];
        [self pushVc:controller];
        return ;
    }
    NSInteger section = indexPath.section;
    if (section == 0) {
        NHDiscoverTopicViewController *topic = [[NHDiscoverTopicViewController alloc] initWithCategoryElement:self.hotCategoryArray[indexPath.row]];
        [self pushVc:topic];
    } else if (section == 1) {
        
    } else {
        NHDiscoverSearchCommonCellFrame *searchCellFrame = nil;
        if (section == 2) {
            searchCellFrame = self.textGroupCellFrameArray[indexPath.row];
        } else if (section == 3) {
            searchCellFrame = self.videoGroupCellFramesArray[indexPath.row];
        } else if (section == 4) {
            searchCellFrame = self.imageGroupCellFrameArray[indexPath.row];
        }
        NHDynamicDetailViewController *controller = [[NHDynamicDetailViewController alloc] initWithSearchCellFrame:searchCellFrame];
        [self pushVc:controller];
    }
    
}

#pragma mark - NHHomeTableViewCellDelegate
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickImageView:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray<NSURL *> *)urls {
    
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
    NSMutableArray *photoArray = [NSMutableArray new];
    for (NSURL *imageURL in urls) {
        MJPhoto *photo = ({
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = imageURL;
            photo.srcImageView = imageView;
            photo;
        });
        [photoArray addObject:photo];
    }
    photoBrowser.photos = photoArray;
    photoBrowser.currentPhotoIndex = currentIndex;
    [photoBrowser show];
}

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NHDiscoverSearchCommonCellFrame *cellFrame = nil;
    NSInteger section = indexPath.section;
    if (section == 2) {
        cellFrame = self.textGroupCellFrameArray[indexPath.row];
    } else if (section == 3) {
        cellFrame = self.videoGroupCellFramesArray[indexPath.row];
    } else if (section == 4) {
        cellFrame = self.imageGroupCellFrameArray[indexPath.row];
    }
    WeakSelf(weakSelf);
    switch (itemType) {
            
        case NHHomeTableViewCellItemTypeLike: {
            [self requestActionWithActionname:@"digg" indexPath:indexPath];
        } break;
            
        case NHHomeTableViewCellItemTypeDontLike: {
            [self requestActionWithActionname:@"bury" indexPath:indexPath];
        } break;
            
        case NHHomeTableViewCellItemTypeComment: {
            
            // 跳转
            NHDynamicDetailViewController *controller = [[NHDynamicDetailViewController alloc] initWithSearchCellFrame:cellFrame];
            [self pushVc:controller];
        } break;
            
        case NHHomeTableViewCellItemTypeShare: {
            NHHomeNeiHanShareView *share = [NHHomeNeiHanShareView shareViewWithType:NHHomeNeiHanShareViewTypeShowCopyAndCollect hasRepinFlag:cellFrame.group.user_repin];
            [share showInView:self.view];
            [share setUpItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index, NHNeiHanShareType shareType) {
                [[NHNeiHanShareManager sharedManager] shareWithSharedType:shareType image:nil url:@"www.baidu.com" content:@"不错" controller:weakSelf];
            }];
            WeakSelf(weakSelf);
            [share setUpBottomItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index) {
                
                switch (index) {
                    case 0: {
                        NSString *shareUrl = cellFrame.group.share_url;
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        pasteboard.string = shareUrl;
                        [MBProgressHUD showSuccess:@"已复制" toView:self.view];
                    } break;
                        
                    case 1: {
                        [weakSelf requestActionWithActionname:cellFrame.group.user_repin ? @"unrepin" : @"repin" indexPath:indexPath];
                    } break;
                        
                    case 2: {
                        NHDynamicDetailReportViewController *controller = [[NHDynamicDetailReportViewController alloc] init];
                        NHBaseNavigationViewController *nav = [[NHBaseNavigationViewController alloc] initWithRootViewController:controller];
                        [weakSelf presentVc:nav];
                    } break;
                        
                    default:
                        break;
                }
            }];
            
        } break;
            
        default:
            break;
    }
}

- (void)requestActionWithActionname:(NSString *)actionname indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2) {
        return ;
    }
    NHDiscoverSearchCommonCellFrame *cellFrame = nil;
    NSInteger section = indexPath.section;
    if (section == 2) {
        cellFrame = self.textGroupCellFrameArray[indexPath.row];
    } else if (section == 3) {
        cellFrame = self.videoGroupCellFramesArray[indexPath.row];
    } else if (section == 4) {
        cellFrame = self.imageGroupCellFrameArray[indexPath.row];
    }
    NHHomeDynamicRequest *request = [NHHomeDynamicRequest nh_request];
    request.group_id = cellFrame.group.ID;
    request.nh_url = kNHHomeDynamicLikeAPI;
    request.action = actionname;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            // 指针不变，只需要更换值
            NHHomeTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([actionname isEqualToString:@"digg"]) {
                if (cellFrame.group.user_digg) return ;
                cellFrame.group.user_digg = 1;
                cellFrame.group.digg_count += 1;
                [cell didDigg];
            } else if ([actionname isEqualToString:@"bury"]) {
                if (cellFrame.group.user_bury) return ;
                cellFrame.group.user_bury = 1;
                cellFrame.group.bury_count += 1;
                [cell didBury];
            } else if ([actionname isEqualToString:@"repin"]) { // 收藏
                cellFrame.group.user_repin = 1;
            } else if ([actionname isEqualToString:@"unrepin"]) { // 取消收藏
                cellFrame.group.user_repin = 0;
            }
        }
    }];
    
}

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickVideoWithVideoUrl:(NSString *)videoUrl videoCover:(NHBaseImageView *)baseImageView {
    
    self.indexPath = [self.tableView indexPathForCell:cell];
    self.imageView = baseImageView;
    
    wmPlayer = [[WMPlayer alloc]initWithFrame:baseImageView.bounds];
    wmPlayer.delegate = self;
    wmPlayer.closeBtnStyle = CloseBtnStyleClose;
    wmPlayer.URLString = videoUrl;
    [baseImageView addSubview:wmPlayer];
    [wmPlayer play];
}

- (void)homeTableViewCellDidClickCategory:(NHHomeTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NHHomeServiceDataElementGroup *elementGroup = nil;
    NSInteger section = indexPath.section;
    if (section == 2) {
        elementGroup = self.textGroupArray[indexPath.row];
    } else if (section == 3) {
        elementGroup = self.videoGroupArray[indexPath.row];
    } else if (section == 4) {
        elementGroup = self.imageGroupArray[indexPath.row];
    }
    NHDiscoverTopicViewController *controller = [[NHDiscoverTopicViewController alloc] initWithCatogoryId:elementGroup.category_id];
    controller.navigationItem.title = elementGroup.category_name;
    [self pushVc:controller];
}

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(NHNeiHanUserInfoModel *)userInfoModel {
    NHPersonalCenterViewController *controller = [[NHPersonalCenterViewController alloc] initWithUserInfoModel:userInfoModel];
    [self pushVc:controller];
}

#pragma mark - WMPlayerDelegate
- (BOOL)prefersStatusBarHidden {
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)toCell {
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = self.imageView.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [self.imageView addSubview:wmPlayer];
        [self.imageView bringSubviewToFront:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        self.isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
    
    
}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation {
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    } else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kScreenWidth-40);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-kScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    
    [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer.topView).with.offset(45);
        make.right.equalTo(wmPlayer.topView).with.offset(-45);
        make.center.equalTo(wmPlayer.topView);
        make.top.equalTo(wmPlayer.topView).with.offset(0);
    }];
    
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    
    [wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-37, -(kScreenWidth/2-37)));
    }];
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}

- (void)toSmallScreen {
    // 放widow上
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.3f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake(kScreenWidth/2,kScreenHeight-kTabBarHeight-(kScreenWidth/2)*0.75, kScreenWidth/2, (kScreenWidth/2)*0.75);
        wmPlayer.playerLayer.frame = wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
        
    } completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wmPlayer.fullScreenBtn.selected = NO;
        self.isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
    }];
}

// 播放器事件
- (void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn {
    if (wmplayer.isFullscreen) {
        wmplayer.isFullscreen = NO;
        [self toCell];
    } else {
        [self releaseWMPlayer];
    }
    
}

- (void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn {
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
        if (self.isSmallScreen) {
            // 放widow上,小屏显示
            [self toSmallScreen];
        } else {
            [self toCell];
        }
    }
}

- (void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}

- (void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

///播放状态
- (void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state {
    NSLog(@"wmplayerDidFailedPlay");
}

- (void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state {
    NSLog(@"wmplayerDidReadyToPlay");
}

- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer {
    [self releaseWMPlayer];
}

- (void)releaseWMPlayer {
    [wmPlayer pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self releaseWMPlayer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (wmPlayer.superview) {
        CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:self.indexPath];
        CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
        if (rectInSuperview.origin.y < -self.imageView.frame.size.height || rectInSuperview.origin.y>kScreenHeight-kTopBarHeight-kTabBarHeight) {//往上拖动
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&self.isSmallScreen) {
                self.isSmallScreen = YES;
            } else {
                [self releaseWMPlayer];
            }
        } else {
            if ([self.imageView.subviews containsObject:wmPlayer]) {
                
            } else {
                [self releaseWMPlayer];
            }
        }
    }
}

- (NSMutableArray *)imageGroupCellFrameArray {
    if (!_imageGroupCellFrameArray) {
        _imageGroupCellFrameArray = [NSMutableArray new];
    }
    return _imageGroupCellFrameArray;
}

- (NSMutableArray *)textGroupCellFrameArray {
    if (!_textGroupCellFrameArray) {
        _textGroupCellFrameArray = [NSMutableArray new];
    }
    return _textGroupCellFrameArray;
}

- (NSMutableArray *)videoGroupCellFramesArray {
    if (!_videoGroupCellFramesArray) {
        _videoGroupCellFramesArray = [NSMutableArray new];
    }
    return _videoGroupCellFramesArray;
}

- (NHDiscoverSearchTextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[NHDiscoverSearchTextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, 28)
                                                             leftViewMargin:10
                                                                  textColor:kCommonBlackColor
                                                                    bgColor:[UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f]
                                                                 holdertext:@"请输入您要搜索的内容"
                                                              leftViewimage:@"searchicon"
                                                             rightViewimage:@"deleteinput"];
        _searchTextField.delegate = self;
        _searchTextField.layerCornerRadius = 5.0f;
        _searchTextField.placeHolderColor = [UIColor lightGrayColor];
    }
    return _searchTextField;
}

- (NHCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        NHCustomCommonEmptyView *empty = [[NHCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"动动麒麟臂，搜段友，搜更多内容" iconname:@"searchmore"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

@end
