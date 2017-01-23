//
//  ZBDetailViewController.m
//  BaseProject
//
//  Created by 廖文博 on 15/11/12.
//  Copyright © 2015年 wenbo. All rights reserved.
//

#import "ZBDetailViewController.h"
#import "HeroIconView.h"
#import "ZBDetailViewModel.h"

@class EquipDetailCell;
@protocol EquipDetailCellDelegate <NSObject>
@optional
-(void)EquipDetailCell:(EquipDetailCell *)cell completeWithEquipId:(NSInteger)equipId;

@end
@interface EquipDetailCell : UITableViewCell<EquipDetailCellDelegate>
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,weak)UIView *whiteView;
@property (nonatomic,weak)id<EquipDetailCellDelegate>delegate;
@end
@implementation EquipDetailCell
-(void)setArray:(NSArray *)array
{
    _array = array;
    NSInteger count = array.count;
   
    
    if(count > 0)
    {
        UIButton *lastButton = nil;
        for (int i = 0; i < count; i++) {
            NSInteger equipId = [array[i] integerValue];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *path = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%ld_64x64.png",equipId];
            [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];
            [self.whiteView addSubview:button];
            
            if(lastButton == nil)
            {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.mas_equalTo(5);
                    make.size.mas_equalTo(CGSizeMake(60, 60));
                }];
            }
            else
            {
                if(i%5 == 0)
                {
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(lastButton);
                        make.left.mas_equalTo(5);
                        make.topMargin.mas_equalTo(lastButton.mas_bottom).mas_equalTo(10);
                    }];
                }
                else
                {
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(lastButton);
                        make.centerY.mas_equalTo(lastButton);
                        make.left.mas_equalTo(lastButton.mas_right).mas_equalTo(5);
                    }];
                }
                
            }
           if(i == count - 1)
           {
               [button mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.bottom.mas_equalTo(-10);
               }];
           }
            [button bk_addEventHandler:^(id sender) {
                if([self.delegate respondsToSelector:@selector(EquipDetailCell:completeWithEquipId:)])
                {
                    [self.delegate EquipDetailCell:self completeWithEquipId:equipId];
                    
                }
                
            } forControlEvents:UIControlEventTouchUpInside];
            lastButton = button;
        }
    
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView *grayView = [UIView new];
        grayView.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:grayView];
        grayView.layer.cornerRadius = 4;
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(3, 10, 3, 10));
        }];
        
        UIView *whiteView =[UIView new];
        whiteView.backgroundColor = [UIColor whiteColor];
        [grayView addSubview:whiteView];
        whiteView.layer.cornerRadius = 4;
        
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(1, 1, 1, 1));
            make.height.mas_greaterThanOrEqualTo(28);
        }];
        self.whiteView = whiteView;
        
    }
    return self;
}


@end

@interface ZBDetailViewController ()<UITableViewDelegate,UITableViewDataSource,EquipDetailCellDelegate>
@property (nonatomic,strong)ZBDetailViewModel *zbDetailVM;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ZBDetailViewController
-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.allowsSelection = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[EquipDetailCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell2"];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.zbDetailVM getDataFromNetCompleteHandle:^(NSError *error) {
                [_tableView.header endRefreshing];
                 _tableView.tableHeaderView = [self headView];
                [_tableView reloadData];
            }];
        }];
    }
    return _tableView;
}
-(ZBDetailViewModel *)zbDetailVM
{
    if(!_zbDetailVM)
    {
        _zbDetailVM = [[ZBDetailViewModel alloc]initWithEquipId:self.equipId];
    }
    return _zbDetailVM;
}
-(id)initWithEquipId:(NSInteger)equipId
{
    if(self = [super init])
    {
        self.equipId = equipId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.header beginRefreshing];
    self.title = @"装备详情";
    [Factory addBackItemToVC:self];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [self.zbDetailVM descFromModel];
        return cell;
    }
    else if(indexPath.section == 1)
    {
        EquipDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.array = [self.zbDetailVM needArrayFromModel];
        cell.delegate = self;
        return cell;
    }
    else
    {
        EquipDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.array = [self.zbDetailVM composeArrayFromModel];
        cell.delegate = self;
        return cell;
    }
}
kRemoveCellSeparator
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[@"装备简介",@"合成需求",@"可合成"][section];
}
-(UIView *)headView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 90)];
    headView.backgroundColor = [UIColor whiteColor];
    HeroIconView *icon = [HeroIconView new];
    [headView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.top.mas_equalTo(10);
    }];
    icon.equipId = self.equipId;
    UILabel *nameLb = [UILabel new];
    [headView addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.mas_equalTo(icon.mas_topMargin);
        make.left.mas_equalTo(icon.mas_right).mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-10);
    }];
    nameLb.text = [self.zbDetailVM nameFromModel];
    UILabel *priceLb = [UILabel new];
    [headView addSubview:priceLb];
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLb.mas_bottom).mas_equalTo(10);
        make.left.right.mas_equalTo(nameLb);
        make.height.mas_equalTo(15);
    }];
    priceLb.text = [self.zbDetailVM priceFromModel];
    priceLb.textColor = [UIColor lightGrayColor];
    priceLb.font = [UIFont systemFontOfSize:15];

    return headView;
}
-(void)EquipDetailCell:(EquipDetailCell *)cell completeWithEquipId:(NSInteger)equipId
{
    ZBDetailViewController *vc = [[ZBDetailViewController alloc]initWithEquipId:equipId];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
