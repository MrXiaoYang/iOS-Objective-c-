//
//  NHPublishDraftViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPublishDraftViewController.h"
#import "NHPublishSelectDraftViewController.h"
#import "NHCustomPlaceHolderTextView.h"
#import "NHPublishDraftTopView.h"
#import "NHPublishDraftBottomView.h"
#import "NHPublishDraftPictureView.h"
#import "NSNotificationCenter+Addition.h"
#import "UIBarButtonItem+Addition.h"
#import "TZImagePickerController.h"
#import "NHPublishDraftRequest.h"
#import "NHUserInfoManager.h"
#import "NHCustomAlertView.h"

#define kMaxInputLimitLength 300
#define kBottomViewH 80
#define kMaxImageCount 9
@interface NHPublishDraftViewController () <NHCustomPlaceHolderTextViewDelegate, NHPublishDraftBottomViewDelegate, TZImagePickerControllerDelegate, NHPublishDraftPictureViewDelegate>
/** 输入框*/
@property (nonatomic, weak) NHCustomPlaceHolderTextView *placeHolderTextView;
/** 顶部视图*/
@property (nonatomic, weak) NHPublishDraftTopView *topView;
/** 底部视图*/
@property (nonatomic, weak) NHPublishDraftBottomView *bottomView;
@property (nonatomic, weak) NHPublishDraftPictureView *pictureView;
/** bottomView的y值*/
@property (nonatomic, assign) CGFloat bottomViewY;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *picArray;
/** 是否为匿名*/
@property (nonatomic, assign) BOOL isAnonymous;
@property (nonatomic, assign) NSInteger category_id;
@end

@implementation NHPublishDraftViewController {
    dispatch_group_t _group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 设置导航栏
    [self setUpItems];
    
    // 2. 设置子视图
    [self setUpViews];
    
    // 3. 添加通知
    [self setUpNotis];
    
}

// 设置导航栏
- (void)setUpItems {
    // 标题
    self.navigationItem.title = @"投稿";
    
    // 发表
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

// 设置子视图
- (void)setUpViews {
    // 设置占位文字
    self.placeHolderTextView.placehoder = @"您的投稿经过段友审核才能发布哦！我们的目标是：专注内涵，拒绝黄反！可以矫情，不要煽情！敬告：发布色情敏感内容会被封号处理";
    self.placeHolderTextView.placeholderFont = kFont(13);
    
    // 设置底部视图
    self.bottomViewY = kScreenHeight - kTopBarHeight - kBottomViewH;
    self.bottomView.limitCount = kMaxInputLimitLength;
    self.bottomView.backgroundColor = kWhiteColor;
}

// 添加通知
- (void)setUpNotis {
    [NSNotificationCenter addObserver:self action:@selector(keyBoardWillHiddenNoti:) name:UIKeyboardWillHideNotification];
    [NSNotificationCenter addObserver:self action:@selector(keyBoardWillShowNoti:) name:UIKeyboardWillShowNotification];
}

// 发表
- (void)rightItemClick {
    
    [self.placeHolderTextView resignFirstResponder];
    
    if (self.placeHolderTextView.text.length == 0) {
        NHCustomAlertView *alert = [[NHCustomAlertView alloc] initWithTitle:@"文本内容不能为空" cancel:nil sure:@"确定"];
        [alert showInView:self.view.window];
        return ;
    }
    [MBProgressHUD showLoading:self.view.window];
   __block BOOL successFlag = NO;
    
    _group = dispatch_group_create();
    
    dispatch_group_enter(_group);
    NHPublishDraftRequest *request = [NHPublishDraftRequest nh_request];
    request.nh_isPost = YES;
    request.nh_url = kNHUserPublishDraftAPI;
    // 只有图片默认是category_id = 2
    if (self.picArray.count && self.placeHolderTextView.text.length == 0) {
        request.category_id = 2;
    } else {
        request.category_id = self.category_id;
    }
    request.text = self.placeHolderTextView.text;
    request.is_anonymous = self.isAnonymous;
    request.user_id = [NHUserInfoManager sharedManager].currentUserInfo.user_id;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            successFlag = YES;
        }
        dispatch_group_leave(_group);
    }];
     
    
    dispatch_group_enter(_group);
    NHPublishDraftRequest *imageRequest = [NHPublishDraftRequest nh_request];
    imageRequest.nh_isPost = YES;
    imageRequest.nh_url = @"http://lf.snssdk.com/neihan/file/upload/v1/image/";
    // 只有图片默认是category_id = 2
    if (self.picArray.count && self.placeHolderTextView.text.length == 0) {
        imageRequest.category_id = 2;
    } else {
        imageRequest.category_id = self.category_id;
    }
    imageRequest.user_id = [NHUserInfoManager sharedManager].currentUserInfo.user_id;
    imageRequest.nh_imageArray = self.picArray;
    imageRequest.text = self.placeHolderTextView.text;
    imageRequest.is_anonymous = self.isAnonymous;
    [imageRequest nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            successFlag = YES;
        }
        dispatch_group_leave(_group);
    }];
    
    // 上传图片接口，暂时不确定是不是与发布接口分离的，所以两者满足其一即成功
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideAllHUDsInView:self.view.window];
        if (successFlag) {
            [self pop];
        }
    });

    
}

// 键盘下落
- (void)keyBoardWillHiddenNoti:(NSNotification *)noti {
    [self configKeyBoardWithHidden:YES userInfo:noti.userInfo];
}

// 键盘生起
- (void)keyBoardWillShowNoti:(NSNotification *)noti {
    [self configKeyBoardWithHidden:NO userInfo:noti.userInfo];
}

- (void)configKeyBoardWithHidden:(BOOL)hidden userInfo:(id)userInfo {
    if (userInfo == nil) return ;
    CGRect endRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomViewY = kScreenHeight - kTopBarHeight - kBottomViewH - (hidden ? 0 : endRect.size.height);
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(kBottomViewH);
        make.top.mas_equalTo(weakSelf.bottomViewY);
    }];
}

// 前往选择
- (void)gotoSelectClick {
    NHPublishSelectDraftViewController *selectController = [[NHPublishSelectDraftViewController alloc] init];
    WeakSelf(weakSelf);
    selectController.publishSelectDraftSelectNameHandle = ^(NHPublishSelectDraftViewController *selectController, NSString *name, NSInteger category_id) {
        weakSelf.topView.topicName = name;
        weakSelf.category_id = category_id;
    };
    [self pushVc:selectController];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.picArray.count == 0) {
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.placeHolderTextView.bottom + 10);
    } else {
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.pictureView.bottom + 10);
    }
}

#pragma mark - NHCustomPlaceHolderTextViewDelegate
- (void)customPlaceHolderTextViewTextDidChange:(NHCustomPlaceHolderTextView *)textView {
    NSString *text = textView.text;
    
    if (text.length > kMaxInputLimitLength) {
        textView.text = [textView.text substringToIndex:kMaxInputLimitLength];
        self.bottomView.limitCount = 0;
    } else {
        self.bottomView.limitCount = kMaxInputLimitLength - text.length;
    }
}

#pragma mark - NHPublishDraftBottomViewDelegate
- (void)publishDraftBottomView:(NHPublishDraftBottomView *)bottomView didClickItemWithType:(NHPublishDraftBottomViewItemType)type {
    
    switch (type) {
        case NHPublishDraftBottomViewItemTypePicture: { // 添加图片
            [self.placeHolderTextView resignFirstResponder];
            [self addImage];
        }
            break;
            
        case NHPublishDraftBottomViewItemTypeVideo: { // 添加视频
            [self.placeHolderTextView resignFirstResponder];
            [self addVideo];
        }
            break;
            // 匿名
        case NHPublishDraftBottomViewItemTypeAnonymous: {
            self.isAnonymous = self.isAnonymous;
        }
            break;
        default:
            break;
    }
}

#pragma mark - NHPublishDraftPictureViewDelegate
- (void)publishDraftPictureView:(NHPublishDraftPictureView *)pictureView picArrayDidChange:(NSArray *)picArray {
    self.picArray = picArray;
}

#pragma mark - NHPublishDraftPictureViewDelegate
- (void)publishDraftPictureViewAddImage:(NHPublishDraftPictureView *)pictureView {
    [self addImage];
}

- (void)addImage {
    WeakSelf(weakSelf);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:kMaxImageCount - self.picArray.count delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        if (photos.count) {
            if (weakSelf.picArray.count > 0) { // 继续添加
                [weakSelf.pictureView addImages:photos];
            } else { // 从无到有
                weakSelf.pictureView.pictureArray = photos.mutableCopy;
                weakSelf.picArray = photos;
            }
        }
    }];
    [self presentVc:imagePickerVc];
}

- (void)addVideo {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [self presentVc:imagePickerVc];
}

- (NHPublishDraftTopView *)topView {
    if (!_topView) {
        NHPublishDraftTopView *top = [NHPublishDraftTopView topView];
        [self.scrollView addSubview:top];
        _topView = top;
        
        WeakSelf(weakSelf);
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(weakSelf.scrollView);
            make.width.mas_equalTo(weakSelf.view.width);
            make.height.mas_equalTo(60);
        }];
        top.publishDraftTopViewChangeTopicHandle = ^() {
            [weakSelf gotoSelectClick];
        };
    }
    return _topView;
}

- (NHPublishDraftPictureView *)pictureView {
    if (!_pictureView) {
        NHPublishDraftPictureView *pic = [[NHPublishDraftPictureView alloc] init];
        [self.scrollView addSubview:pic];
        _pictureView = pic;
        pic.delegate = self;
        WeakSelf(weakSelf);
        [pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.topView);
            make.width.mas_equalTo(weakSelf.view.width);
            make.top.mas_equalTo(weakSelf.placeHolderTextView.mas_bottom);
            make.height.mas_equalTo(kScreenWidth);
        }];
    }
    return _pictureView;
}

- (NHCustomPlaceHolderTextView *)placeHolderTextView {
    if (!_placeHolderTextView) {
        NHCustomPlaceHolderTextView *placeHolderTextView = [[NHCustomPlaceHolderTextView alloc] init];
        [self.scrollView addSubview:placeHolderTextView];
        _placeHolderTextView = placeHolderTextView;
        placeHolderTextView.placeholderFont = kFont(14);
        placeHolderTextView.del = self;
        WeakSelf(weakSelf);
        [placeHolderTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.topView);
            make.width.mas_equalTo(weakSelf.view.width);
            make.top.mas_equalTo(weakSelf.topView.mas_bottom);
            make.height.mas_equalTo(200);
        }];
    }
    return _placeHolderTextView;
}

- (NSArray *)picArray {
    if (!_picArray) {
        _picArray = [NSArray new];
    }
    return _picArray;
}

- (NHPublishDraftBottomView *)bottomView {
    if (!_bottomView) {
        NHPublishDraftBottomView *bottomView = [[NHPublishDraftBottomView alloc] init];
        [self.view addSubview:bottomView];
        _bottomView = bottomView;
        bottomView.delegate = self;
        WeakSelf(weakSelf);
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(kBottomViewH);
            make.top.mas_equalTo(kScreenHeight - kTopBarHeight - kBottomViewH);
        }];
    }
    return _bottomView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *sc = [[UIScrollView alloc] init];
        [self.view addSubview:sc];
        _scrollView = sc;
        
        [sc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, kBottomViewH, 0));
        }];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
        sc.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}
@end
