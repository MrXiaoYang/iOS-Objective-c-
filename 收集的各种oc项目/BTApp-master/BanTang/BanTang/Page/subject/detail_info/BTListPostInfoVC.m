//
//  BTListPostInfoVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostInfoVC.h"
#import "BTListPostBottomView.h"
#import "BTListPost.h"
#import "BTListPostDynamic.h"
#import "BTListPostInfoCell.h"
#import "BTListPostProductCell.h"
#import "BTHomePageManager.h"
#import "BTWebViewVC.h"
#import "BTNavigationController.h"
#import "BTProduct.h"
#import "BTListPostLikesUsersCell.h"
#import "BTListPostLikeListVC.h"
#import "BTSubjectAuthor.h"
#import "BTUserManager.h"
#import "BTListPostInfoView.h"
#import <NVActivityIndicatorView.h>
#import "BTLoadingView.h"
#import "BTCommentVC.h"
@interface BTListPostInfoVC () <BTListPostInfoCellDelegate,BTListPostBottomViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BTListPostBottomView *bottomView;

@property (nonatomic, strong) BTListPost *listPost;

@property (nonatomic, strong) NVActivityIndicatorView *indicatorView;

@property (nonatomic, strong) BTLoadingView *loadingView;

@property (nonatomic, assign) CGFloat height;

@end

@implementation BTListPostInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItem];

    [self setupSubViews];
    
    [self loadData];
}

- (void)setupNavItem
{
    self.view.backgroundColor = kUIColorFromRGB(0xf8f8f8);
    
    self.title = @"好物详情";
    
    UIBarButtonItem *shareItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"share_item_icon"
                                                                hltImg:@"share_item_icon"
                                                                target:self
                                                                action:@selector(shareItemDidClick)];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)setupSubViews
{
    [self.view addSubview:self.loadingView];
    [self.view addSubview:self.bottomView];
}

- (void)loadData
{
    [BTHomePageManager getListPostInfoWithId:self.extendId successHandler:^(BTListPost *listPost) {
        self.listPost = listPost;
        [self.view addSubview:self.tableView];
        [self.loadingView hideAnimation];
        // 496 + W
        CGFloat height = 496 + [listPost.content titleSizeWithfontSize:14
                                                               maxSize:CGSizeMake(kScreen_Width - 2 *18, MAXFLOAT)].height;
        self.height = height;
        
        [self.tableView reloadData];

    } failureHandler:^(NSError *error) {
        NSLog(@"%@",error);
        [self.loadingView hideAnimation];
    }];
}

- (void)shareItemDidClick
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *likesUserArray = self.listPost.dynamic.likesUsers;
    NSArray *productArray = self.listPost.product;
    if (likesUserArray.count > 0 && productArray.count > 0) {
        return 3;
    }else if (likesUserArray.count > 0){
        return 2;
    }else if (productArray.count > 0){
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *likesUserArray = self.listPost.dynamic.likesUsers;
    NSArray *productArray = self.listPost.product;
    BOOL both = likesUserArray.count > 0 && productArray.count > 0;
    
    if (indexPath.row == 0) {
        BTListPostInfoCell *cell = [BTListPostInfoCell cellWithTableView:tableView];
        cell.listPost = self.listPost;
        cell.delegate = self;
        return cell;
    }
    
    if (both) {
        if (indexPath.row == 1)
        {
            BTListPostProductCell *cell = [BTListPostProductCell cellWithTableView:tableView];
            cell.product = self.listPost.product[0];
            cell.backgroundColor = kUIColorFromRGB(0xf4f4f4);
            return cell;
        }else if (indexPath.row == 2){
            BTListPostLikesUsersCell *cell = [BTListPostLikesUsersCell cellWithTableView:tableView];
            cell.likesUsers = self.listPost.dynamic.likesUsers;
            cell.clickIconBlock = ^(NSInteger index)
            {
                NSLog(@"点击了第%zd个头像",index);
            };
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }
    }else{
        if (productArray.count > 0){
            if (indexPath.row == 1)
            {
                BTListPostProductCell *cell = [BTListPostProductCell cellWithTableView:tableView];
                cell.product = self.listPost.product[0];
                cell.backgroundColor = kUIColorFromRGB(0xf4f4f4);
                return cell;
            }
        }else if (likesUserArray.count > 0) {
            if (indexPath.row == 1){
                BTListPostLikesUsersCell *cell = [BTListPostLikesUsersCell cellWithTableView:tableView];
                cell.likesUsers = self.listPost.dynamic.likesUsers;
                cell.clickIconBlock = ^(NSInteger index)
                {
                    NSLog(@"点击了第%zd个头像",index);
                };
                [cell hideTopDiverLine:NO];
                cell.backgroundColor = [UIColor whiteColor];
                return cell;
            }
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *likesUserArray = self.listPost.dynamic.likesUsers;
    NSArray *productArray = self.listPost.product;
    BOOL both = likesUserArray.count > 0 && productArray.count > 0;
    
    if (both) {
            if (indexPath.row == 1) {
                [self pushWebViewVC];
            }else if (indexPath.row == 2){
                [self pushLikesListVC];
            }
    }else{
        if (productArray.count > 0){
            if (indexPath.row == 1) [self pushWebViewVC];
        }else if(likesUserArray.count>0) {
            if (indexPath.row == 1) [self pushLikesListVC];
        }
    }
}

- (void)pushWebViewVC
{
    BTProduct *product = self.listPost.product[0];
    BTWebViewVC *webViewVC = [[BTWebViewVC alloc] init];
    webViewVC.title = @"宝贝详情";
    webViewVC.url = product.url;
    webViewVC.isModalStyle = YES;
    BTNavigationController *nav = [[BTNavigationController alloc] initWithRootViewController:webViewVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)pushLikesListVC
{
    BTListPostLikeListVC *listVC = [[BTListPostLikeListVC alloc] init];
    listVC.likesUserArray = self.listPost.dynamic.likesUsers;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *likesUserArray = self.listPost.dynamic.likesUsers;
    NSArray *productArray = self.listPost.product;
    BOOL both = likesUserArray.count > 0 && productArray.count > 0;

    if (indexPath.row == 0) {
        return self.height;
    }
    else if (both){
        if (indexPath.row == 1){
            return 123;
        }else if (indexPath.row == 2){
            return 76;
        }
    }else if(productArray.count > 0){
        if (indexPath.row == 1) return 123;
    }else if (likesUserArray.count > 0){
        if (indexPath.row == 1) return 76;
    }
    
    return 0.0f;
}

- (void)listPostInfoCell:(BTListPostInfoCell *)listPostInfoCell didClickTag:(BTTag *)tag
{
    
}

- (void)listPostInfoCell:(BTListPostInfoCell *)listPostInfoCell didClickIconButtonWithListPost:(BTListPost *)listPost
{
    
}

- (void)listPostInfoCell:(BTListPostInfoCell *)listPostInfoCell didClickAttentionButtonWithListPost:(BTListPost *)listPost
{
    if (listPost.author.attentionType == 0) { // 未关注状态,需要调用关注接口
        [BTUserManager followUserWithFriendId:listPost.authorId success:^{
            //关注成功,更新按钮的图片
            [listPostInfoCell.infoView setAttention:YES];
            listPost.author.attentionType = 1;
        } failure:nil];
    }else if (listPost.author.attentionType == 1){ // 关注状态,需要调用取消关注接口
        [BTUserManager unfollowUserWithFriendId:listPost.authorId success:^(BOOL success) {
            if (success) { // 取消关注成功
                [listPostInfoCell.infoView setAttention:NO];
                listPost.author.attentionType = 0;
            }
        } failure:nil];
    }
}

- (void)listPostBottomViewDidClickLikeButton:(BTListPostBottomView *)bottomView
{
    BOOL boolean = !self.dynamic.isCollect;
    [bottomView setCollect:boolean];
    
    if (!self.dynamic.isCollect) {
        [BTUserManager unlikeSubjectWithID:[self.extendId integerValue] successHandler:^(BOOL result) {
            if (result) {
                NSLog(@"取消收藏成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_UPDATE_SUBJECT_VC_DATA
                                                                    object:@(self.indexPathRow)];
            }
        } failureHandler:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        [BTUserManager likeSubjectWithID:[self.extendId integerValue] boxID:0 categoryID:0  successHandler:^(BOOL result) {
            if (result) {
                NSLog(@"收藏成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_UPDATE_SUBJECT_VC_DATA
                                                                    object:@(self.indexPathRow)];
            }
        } failureHandler:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)listPostBottomViewDidClickCommentButton:(BTListPostBottomView *)bottomView
{
    BTCommentVC *commentVC = [[BTCommentVC alloc] init];
    commentVC.objectID = self.listPost.ID;
    BTNavigationController *nav = [[BTNavigationController alloc] initWithRootViewController:commentVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - getter method
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.height -= 64;
    }
    return _tableView;
}

- (BTListPostBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BTListPostBottomView alloc] init];
        [_bottomView setDynamic:self.dynamic];
        _bottomView.backgroundColor = kUIColorFromRGB(0xffffff);
        _bottomView.delegate = self;
        CGFloat H = 64;
        _bottomView.frame = CGRectMake(0, kScreen_Height - 64 - H, kScreen_Width, H);
    }
    return _bottomView;
}

- (BTLoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [BTLoadingView loadingViewToView:self.view];
        [_loadingView startAnimation];
    }
    return _loadingView;
}
@end
