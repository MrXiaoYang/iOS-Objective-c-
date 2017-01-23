//
//  ViewController.m
//  HappyBuy
//
//  Created by jiyingxin on 16/3/28.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import <MJRefresh.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 按钮 */
@property (nonatomic) UIButton *button;
/** <#属性#> */
@property (nonatomic) UITableView *tableView;
@end
@implementation ViewController

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //奇数行 蓝色  偶数行 绿色
    cell.contentView.backgroundColor = indexPath.row%2?[UIColor blueColor]:[UIColor greenColor];
    //或
    cell.contentView.backgroundColor = @[[UIColor greenColor], [UIColor blueColor]][indexPath.row%2];
    
    return cell;
}

#pragma mark - Methods 方法
// clicked:(id)sender{}  id可以不写
- (void)clicked:sender{
    NSLog(@"Hello!!");
}

#pragma mark - Lazy Load 懒加载
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            //table和父视图的4个边距都是0
            make.edges.equalTo(0);
        }];
    }
    return _tableView;
}


- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        //BlocksKit提供的类别都是以bk_开头
        [_button bk_addEventHandler:^(id sender) {
            NSLog(@"Hello!!");
            //弹出提示, 1.5秒后自动消失
            /*
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             //纯文本模式
             hud.mode = MBProgressHUDModeText;
             hud.labelText = @"当前无网络,请稍后再试";
             [hud hide:YES afterDelay:1.5];
             */
            [self.view showWarning:@"当前无网络,请稍后再试"];
            //模仿一个5秒钟的耗时操作,即子线程中5秒后执行某个任务
            [self.view showBusyHUD];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                [self.view hideBusyHUD];
            });
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        //[_button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"点击弹出提示" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:_button];
        //按钮居中, 宽80 高40
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
#warning 在此块中,不允许出现fame, 以make代替当前视图
            make.center.equalTo(0);
            //按钮的中心等于self.view的中心,x偏移量+0, y偏移量+0
            //make.center.mas_equalTo(self.view.center).mas_equalTo(CGPointMake(0, 0));
            make.size.equalTo(CGSizeMake(120, 40));
        }];
    }
    return _button;
}
#pragma mark - Life Circle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self button];
    [self tableView];
    //__weak __typeof(&*self)weakSelf = self;
    WK(weakSelf)
    [self.tableView addHeaderRefresh:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView endHeaderRefresh];
        });
    }];
    //    [self.tableView beginHeaderRefresh];
    /*
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self.tableView.mj_header endRefreshing];
     });
     }]; */
    //到MJRefresh官网上, 按照文档, 把脚部刷新做一下
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
