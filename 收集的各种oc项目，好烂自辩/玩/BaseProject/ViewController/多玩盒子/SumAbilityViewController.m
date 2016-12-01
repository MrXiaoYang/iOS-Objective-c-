//
//  SumAbilityViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SumAbilityViewController.h"
#import "SumAbilityViewModel.h"
#import "ZBItemViewController.h"
#import "SumAbilityDetailViewController.h"

@interface SumAbilityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) SumAbilityViewModel *abilityVM;
@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation SumAbilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView.header beginRefreshing];
}

- (id)init{
    if (self = [super init]) {
        self.title = @"召唤师技能列表";
        [Factory addBackItemToVC:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.abilityVM.rowNumber;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZBItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.iconView.imageView setImageWithURL:[self.abilityVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    cell.nameLb.text = [self.abilityVM titleForRow:indexPath.row];
    return cell;
}
#pragma mark - UICollectionViewDataDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SumAbilityDetailViewController *vc = [[SumAbilityDetailViewController alloc] initWithSumAbilityModel:[self.abilityVM modelForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
/** section的上下左右边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 20, 5, 20);
}
/** 最小行间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kWindowW - 5 * 20) / 4;
    CGFloat height = width + 17;
    return CGSizeMake(width, height);
}
- (SumAbilityViewModel *)abilityVM {
    if(_abilityVM == nil) {
        _abilityVM = [[SumAbilityViewModel alloc] init];
    }
    return _abilityVM;
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.abilityVM getDataFromNetCompleteHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [_collectionView reloadData];
                }
                [_collectionView.header endRefreshing];
            }];
        }];
        [_collectionView registerClass:[ZBItemCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
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
