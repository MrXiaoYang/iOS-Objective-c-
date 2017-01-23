//
//  BoPhotoPickerViewController.m
//  PhotoPicker
//
//  Created by AlienJunX on 15/11/2.
//  Copyright © 2015年 com.alienjun.demo. All rights reserved.
//

#import "BoPhotoPickerViewController.h"
#import "BoPhotoGroupView.h"
#import "BoPhotoListView.h"
#import "Masonry.h"

//rgb颜色转换（16进制->10进制）
#define mRGBToColor(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]

@interface BoPhotoPickerViewController()<BoPhotoGroupViewProtocol,BoPhotoListProtocol>

@property (weak, nonatomic) BoPhotoGroupView *photoGroupView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIView *navBar;
@property (weak, nonatomic) UIView *bgMaskView;
@property (weak, nonatomic) BoPhotoListView *photoListView;
@property (weak, nonatomic) UIImageView *selectTip;
@property (weak, nonatomic) UIButton *okBtn;
@property (nonatomic) BOOL isNotAllowed;
@end

@implementation BoPhotoPickerViewController

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor blueColor];
        _maximumNumberOfSelection = 10;
        _minimumNumberOfSelection = 0;
        _assetsFilter = [ALAssetsFilter allAssets];
        _showEmptyGroups = NO;
        _selectionFilter = [NSPredicate predicateWithValue:YES];
    }
    return self;
}

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    //列表view
    [self setupPhotoListView];
    
    //相册分组
    [self setupGroupView];
    
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage rx_captureImageWithImageName:@"bg_search_bar"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    //没有相册访问权限通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showNotAllowed)
                                                 name:@"NotAllowedPhoto"
                                               object:nil];
    //数据初始化
    [self setupData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}


#pragma mark - 界面初始化

- (void)setupNavBar {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithTitle:@"取消"
                                                                      titleColor:[UIColor whiteColor]
                                                                       titleFont:[UIFont systemFontOfSize:15]
                                                                          target:self action:@selector(cancelBtnAction:)];
    UIView *titleView = [UIView new];
    titleView.bounds = CGRectMake(0, 0, 200, 64);
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleView);
        make.centerY.mas_equalTo(titleView);
    }];
    self.titleLabel = titleLabel;
    
    UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tapBtn.backgroundColor = [UIColor clearColor];
    [tapBtn addTarget:self action:@selector(selectGroupAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:tapBtn];
    
    [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titleLabel.mas_width).offset(50);
        make.centerX.mas_equalTo(titleView);
        make.centerY.mas_equalTo(titleView);
        make.height.mas_equalTo(@44);
    }];
    
    //selectTipImageView
    UIImageView *selectTip = [[UIImageView alloc] init];
    selectTip.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BoPhotoPicker.bundle/images/BoSelectGroup_tip@2x.png"]];
    [titleView addSubview:selectTip];
    [selectTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleLabel.mas_trailing).offset(10);
        make.width.mas_equalTo(@8);
        make.height.mas_equalTo(@5);
        make.centerY.mas_equalTo(titleLabel);
    }];
    self.selectTip = selectTip;
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rx_barBtnItemWithTitle:@"确定"
                                                                       titleColor:[UIColor whiteColor]
                                                                        titleFont:[UIFont systemFontOfSize:15]
                                                                           target:self action:@selector(okBtnAction:)];
}

- (void)setupPhotoListView {
    BoPhotoListView *collectionView = [[BoPhotoListView alloc] init];
    collectionView.my_delegate = self;
    collectionView.frame = self.view.bounds;
    [self.view addSubview:collectionView];
    self.photoListView = collectionView;
}

- (void)setupGroupView {
    BoPhotoGroupView *photoGroupView = [[BoPhotoGroupView alloc] init];
    photoGroupView.assetsFilter = self.assetsFilter;
    photoGroupView.my_delegate = self;
    [self.view addSubview:photoGroupView];
    self.photoGroupView = photoGroupView;
    photoGroupView.hidden = YES;
    [photoGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(-360);
        make.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(@360);
    }];
}

- (void)setupData {
    [self.photoGroupView setupGroup];
}


#pragma mark - 相册切换
- (void)selectGroupAction:(UIButton *)sender {
    //无权限
    if (self.isNotAllowed) {
        return;
    }
    if (self.photoGroupView.hidden) {
        [self bgMaskView];
        self.photoGroupView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.photoGroupView.transform = CGAffineTransformMakeTranslation(0, 360);
            self.selectTip.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        [self hidenGroupView];
    }
}

- (void)hidenGroupView {
    [self.bgMaskView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.photoGroupView.transform = CGAffineTransformIdentity;
        self.selectTip.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        self.photoGroupView.hidden = YES;
    }];
}


#pragma mark - BoPhotoGroupViewProtocol
- (void)didSelectGroup:(ALAssetsGroup *)assetsGroup {
    self.photoListView.assetsGroup = assetsGroup;
    self.titleLabel.text = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    [self hidenGroupView];
}

#pragma mark - BoPhotoListProtocol
- (void)tapAction:(ALAsset *)asset {
    if ([asset isKindOfClass:[UIImage class]] && _delegate && [_delegate respondsToSelector:@selector(photoPickerTapAction:)]) {
        [_delegate photoPickerTapAction:self];
    }
}


#pragma mark - Action
- (void)cancelBtnAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(photoPickerDidCancel:)]) {
        [_delegate photoPickerDidCancel:self];
    }
}

- (void)okBtnAction:(UIButton *)sender {
    if (self.minimumNumberOfSelection > self.indexPathsForSelectedItems.count) {
        if (_delegate && [_delegate respondsToSelector:@selector(photoPickerDidMinimum:)]) {
            [_delegate photoPickerDidMinimum:self];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(photoPicker:didSelectAssets:)]) {
            [_delegate photoPicker:self didSelectAssets:self.indexPathsForSelectedItems];
        }
    }
}


#pragma mark - 遮罩背景
- (UIView *)bgMaskView {
    if (_bgMaskView == nil) {
        UIView *bgMaskView = [[UIView alloc] init];
        bgMaskView.alpha = 0.4;
        bgMaskView.backgroundColor = [UIColor blackColor];
        [self.view insertSubview:bgMaskView aboveSubview:self.photoListView];
        bgMaskView.userInteractionEnabled = YES;
        [bgMaskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgMaskView:)]];
        [bgMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.leading.mas_equalTo(self.view);
            make.trailing.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
        _bgMaskView = bgMaskView;
    }
    return _bgMaskView;
}

- (void)tapBgMaskView:(UITapGestureRecognizer *)sender {
    if (!self.photoGroupView.hidden) {
        [self hidenGroupView];
    }
}

#pragma mark - 没有访问权限提示
- (void)showNotAllowed {
    //没有权限时隐藏部分控件
    self.isNotAllowed = YES;
    self.selectTip.hidden = YES;
    self.titleLabel.text = @"无权限访问相册";
    self.okBtn.hidden = YES;
    UIAlertView *alert;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                           message:@"请在iPhone的“设置”-“隐私”-“照片”中，找到波波网更改"
                                          delegate:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil, nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                           message:@"请先允许访问照片"
                                          delegate:self
                                 cancelButtonTitle:@"取消"
                                 otherButtonTitles:@"前往", nil];
    }
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark - getter/setter
- (NSMutableArray *)indexPathsForSelectedItems {
    if (!_indexPathsForSelectedItems) {
        _indexPathsForSelectedItems = [[NSMutableArray alloc] init];
    }
    return _indexPathsForSelectedItems;
}
@end
