//
//  TuWanPicViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanPicViewController.h"
#import "TuWanPicViewModel.h"

@interface TuWanPicViewController ()<MWPhotoBrowserDelegate>
@property(nonatomic,strong) TuWanPicViewModel *tuwanPicVM;
@end
@implementation TuWanPicViewController
- (TuWanPicViewModel *)tuwanPicVM{
    if (!_tuwanPicVM) {
        _tuwanPicVM = [[TuWanPicViewModel alloc] initWithAid:_aid];
    }
    return _tuwanPicVM;
}

- (id)initWithAid:(NSString *)aid{
    if (self = [super init]) {
        self.aid = aid;
    }
    return self;
}
- (id)init{
    if (self = [super init]) {
        NSAssert1(NO, @"%s 必须使用initWithAid方法初始化", __func__);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//非xib，storyboard。 默认背景色是透明
    self.view.backgroundColor = [UIColor whiteColor];
    [Factory addBackItemToVC:self];
//请求时要有正在操作的提示
    [self showProgress];
    [self.tuwanPicVM getDataFromNetCompleteHandle:^(NSError *error) {
        [self hideProgress];
//创建图片展示页面，Github排名最高的图片展示类控件
        MWPhotoBrowser *photoB = [[MWPhotoBrowser alloc] initWithDelegate:self];
//图片展示页面不应该是当前页推出的，而应该是取代当前页面在导航控制器中的位置。
        NSMutableArray *naviVCs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//删除掉最后一个控制器，即当前的白色控制器
        [naviVCs removeLastObject];
//把图片控制器添加到最后
        [naviVCs addObject:photoB];
//把新的控制器数组赋值给导航控制器
        self.navigationController.viewControllers = naviVCs;
    }];
}
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return self.tuwanPicVM.rowNumber;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    MWPhoto *photo = [MWPhoto photoWithURL:[self.tuwanPicVM picURLForRow:index]];
    return photo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
