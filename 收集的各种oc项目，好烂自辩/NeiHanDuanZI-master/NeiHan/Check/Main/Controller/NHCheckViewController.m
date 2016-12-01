//
//  NHCheckViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCheckViewController.h"
#import "NHCheckTableViewCell.h"
#import "NHHomeServiceDataModel.h"
#import "NHCheckViewCellFrame.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "NHDynamicDetailReportRequest.h"
#import "NHPublishDraftViewController.h"
#import "NSString+Size.h"
#import "NHCheckReportBottomView.h"
#import "NHCheckListRequest.h"
#import "NHHomeUserIconView.h"
#import "NHUserInfoManager.h"
#import "NHLoginViewController.h"
#import "NHPersonalCenterViewController.h"
#import "NHCheckActionRequest.h"

@interface NHCheckViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, NHCheckTableViewCellDelegate>
@property (nonatomic, weak) UICollectionView *colView;
/** 拖拽手势的判断条件*/
@property (nonatomic, assign) CGPoint preOffset;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cellFrameArray;
@end

static NSString *cellID = @"cellID";
@implementation NHCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加拖拽手势
    [self addPanGest];
    
    // 设置导航栏
    [self setUpItems];
    
    // 请求数据
    [self loadData];
}

// 个人中心
- (void)leftItemClick {
    if (![NHUserInfoManager sharedManager].isLogin) {
        NHLoginViewController *loginController = [[NHLoginViewController alloc] init];
        [self pushVc:loginController];
    } else {
        NHPersonalCenterViewController *personalCenter = [[NHPersonalCenterViewController alloc] initWithUserInfoModel:[[NHUserInfoManager sharedManager] currentUserInfo]];
        [self pushVc:personalCenter];
    }
}

// 设置导航栏
- (void)setUpItems {
    // 标题
    self.navigationItem.title = @"审核";
    
    // 个人中心
    WeakSelf(weakSelf);
    NHHomeUserIconView *iconView = [NHHomeUserIconView iconView];
    iconView.frame = CGRectMake(-10, 0, 35, 35);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconView];
    iconView.homeUserIconViewDidClickHandle = ^(NHHomeUserIconView *iconView) {
        [weakSelf leftItemClick];
    };
    if (![NHUserInfoManager sharedManager].isLogin) {
        iconView.image = [UIImage imageNamed:@"defaulthead"];
    } else {
        iconView.iconUrl = [NHUserInfoManager sharedManager].currentUserInfo.avatar_url;
    }
    
    // 投稿
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"submission"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

// 添加拖拽手势
- (void)addPanGest {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGest:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

// 请求数据
- (void)loadData {
    NHCheckListRequest *request = [NHCheckListRequest nh_request];
    request.nh_url = kNHCheckDynamicListAPI;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            // 当滑动到一定距离之后，需要重新请求数据，清掉一部分内存，重置所有条件
            [self.dataArray removeAllObjects];
            [self.cellFrameArray removeAllObjects];
            for (int i = 0; i < self.dataArray.count; i++) {
                [self.colView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            self.colView.contentOffset = CGPointZero;
            self.preOffset = CGPointZero;
            
            // 模型数组
            NSArray *newArray = [NHHomeServiceDataElement modelArrayWithDictArray:response];
            [self.dataArray addObjectsFromArray:newArray];
            // frame数组
            for (NHHomeServiceDataElement *element in newArray) {
                NHCheckViewCellFrame *cellFrame = [[NHCheckViewCellFrame alloc] init];
                cellFrame.model = element;
                [self.cellFrameArray addObject:cellFrame];
            }
            [self.colView reloadData];
        }
    }];
}

// 投稿
- (void)rightItemClick {
    NHPublishDraftViewController *publish = [[NHPublishDraftViewController alloc] init];
    [self pushVc:publish];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.colView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight - kTabBarHeight);
}

int transX = 0;
- (void)panGest:(UIPanGestureRecognizer *)gest {
   
    if (self.preOffset.x + kScreenWidth == self.colView.contentSize.width) return ;
    
    // 右滑的时候设置偏移量
    if (gest.state == UIGestureRecognizerStateBegan || gest.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gest translationInView:self.view];
            if (translation.x < 0) { // 右滑
            transX += (-translation.x);
            if (transX > 100) {
                if (self.colView.contentOffset.x - self.preOffset.x == kScreenWidth) return ;
                CGPoint offset = self.preOffset;
                offset.x += kScreenWidth;
                [self.colView setContentOffset:offset];
            }
        }
        // 重置滑动距离
        [gest setTranslation:CGPointZero inView:self.view];
        
    } else if (gest.state == UIGestureRecognizerStateEnded) { // 手势结束，重置所有判断条件
        transX = 0;
        self.preOffset = self.colView.contentOffset;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger index = contentOffsetX / kScreenWidth;
    // 预加载，重新设置数据
    if (index == self.dataArray.count - 1) {
        [self loadData];
    }
}

// 自动滑动
- (void)slide {
    if (self.colView.contentOffset.x - self.preOffset.x == kScreenWidth) return ;
    CGPoint offset = self.preOffset;
    offset.x += kScreenWidth;
    [self.colView setContentOffset:offset];
    self.preOffset = self.colView.contentOffset;
}

#pragma mark - NHCheckTableViewCell
// 查看大图
- (void)checkTableViewCell:(NHCheckTableViewCell *)cell didClickImageView:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray<NSURL *> *)urls {
    
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

// 举报
- (void)checkTableViewCell:(NHCheckTableViewCell *)cell didClickReport:(BOOL)didClickReport {
    NHCheckReportBottomView *bottomView = [[NHCheckReportBottomView alloc] init];
    [bottomView showInView:self.view];
    WeakSelf(weakSelf);
    bottomView.checkReportBottomViewDidClickReportReasonHandle = ^(NHCheckReportBottomView *bottomView, NSString *reportStr, NSInteger index) {
        NHDynamicDetailReportRequest *request = [NHDynamicDetailReportRequest nh_request];
        request.nh_url = kNHHomeReportDynamicAPI;
        [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
            if (success) { 
                [bottomView dismiss];
                [weakSelf performSelector:@selector(slide) withObject:nil afterDelay:0.2];
            }
        }];
    };
}

// 加载loading完毕
- (void)checkTableViewCell:(NHCheckTableViewCell *)cell didFinishLoadingHandleWithLikeFlag:(BOOL)likeFlag {
    NSInteger action = likeFlag ? 5 : 6;
    [MBProgressHUD showLoading:self.view];
    NSIndexPath *indexPath = [self.colView indexPathForCell:cell];
    NHHomeServiceDataElement *element = self.dataArray[indexPath.row];
    NHCheckActionRequest *request = [NHCheckActionRequest nh_request];
    request.nh_url = kNHCheckDynamicListAPI;
    request.group_id = element.group.ID;
    request.action = kIntegerToStr(action);
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        if (success) {
            [self slide];
        } else {
            // 即使请求不成功，也要滑动
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self slide];
            });
        }
    }];
}

#pragma mark - UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NHCheckTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.cellFrame = self.cellFrameArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.dataArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NHCheckViewCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
    return CGSizeMake(kScreenWidth, cellFrame.cellHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UIGestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
        return NO;
    }
    return YES;
}

- (UICollectionView *)colView {
    if (!_colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *col = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [self.view addSubview:col];
        _colView = col;
        
        [col registerClass:[NHCheckTableViewCell class] forCellWithReuseIdentifier:cellID];
        col.scrollEnabled = NO;
        col.pagingEnabled = YES;
        col.delegate = self;
        col.dataSource = self;
        col.backgroundColor = [UIColor whiteColor];
        col.bounces = NO;
    }
    return _colView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSMutableArray *)cellFrameArray {
    if (!_cellFrameArray) {
        _cellFrameArray = [NSMutableArray new];
    }
    return _cellFrameArray;
}
@end
