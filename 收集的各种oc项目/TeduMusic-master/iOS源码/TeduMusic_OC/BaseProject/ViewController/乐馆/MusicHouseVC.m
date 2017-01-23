//
//  MusicHouseVC.m
//  BaseProject
//
//  Created by jiyingxin on 15/12/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MusicHouseVC.h"
#import "MusicHouseCell.h"

#define kTopCell        @"Cell0"
#define kNormalCell     @"Cell1"

@interface MusicHouseVC ()<UITableViewDelegate, UITableViewDataSource, MusicHouseCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 第1分区内容 */
@property(nonatomic,strong) NSArray *itemList1;
/** 第2分区内容 */
@property(nonatomic,strong) NSArray *itemList2;
@end

@implementation MusicHouseVC

#pragma mark - MusicHouseCellDelegate
- (void)musicHouseCell:(UITableViewCell *)musicHouseCell selectedItem:(MusicItemType)itemType{
    switch (itemType) {
        case MusicItemTypeChoose: {
            DDLogVerbose(@"精选");
            break;
        }
        case MusicItemTypeRank: {
            DDLogVerbose(@"排行");
            break;
        }
        case MusicItemTypeMedia: {
            DDLogVerbose(@"视频");
            break;
        }
        case MusicItemTypeCommunity: {
            DDLogVerbose(@"社区");
            break;
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return 49;
    }
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return  self.itemList1.count;
    }
    if (section == 2) {
        return self.itemList2.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.section ? kNormalCell: kTopCell];
    if (indexPath.section == 0) {
        MusicHouseCell *houseCell = (MusicHouseCell *)cell;
        houseCell.delegate = self;
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = self.itemList1[indexPath.row];
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"我们也在这里!";
        }
        if (indexPath.row == 3) {
            cell.detailTextLabel.text = @"音乐图书馆";
        }
        cell.imageView.image = [UIImage imageNamed:self.itemList1[indexPath.row]];
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = self.itemList2[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.itemList2[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.tableFooterView = [UIView new];
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

- (NSArray *)itemList1 {
	if(_itemList1 == nil) {
		_itemList1 = [[NSArray alloc] initWithObjects:@"艺人", @"音乐人", @"专辑", @"曲风流派", @"场景音乐", nil];
	}
	return _itemList1;
}

- (NSArray *)itemList2 {
	if(_itemList2 == nil) {
		_itemList2 = [[NSArray alloc] initWithObjects:@"看演出",@"大咖专区",@"粉丝互动", nil];
	}
	return _itemList2;
}

@end
