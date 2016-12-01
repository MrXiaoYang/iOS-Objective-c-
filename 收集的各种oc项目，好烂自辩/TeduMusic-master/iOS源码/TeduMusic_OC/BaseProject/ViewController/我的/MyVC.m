//
//  MyVC.m
//  BaseProject
//
//  Created by jiyingxin on 15/12/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyVC.h"
#import "MusicHouseCell.h"

#define kLocalMusicCell         @"Cell0"
#define kSubscribeCell          @"Cell2"
#define kFounctionCell          @"Cell1"

@interface MyVC ()<UITableViewDelegate, UITableViewDataSource, MusicHouseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyVC

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 2 : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
       return indexPath.row == 0 ? 70 : 140;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 10;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor colorFromHexCode:@"f3f3f3"];
//    view.backgroundColor = [UIColor redColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = nil;
//    if (indexPath.section) {
//        str = kSubscribeCell;
//    }else{
//        if (indexPath.row) {
//            str = kFounctionCell;
//        }else{
//            str = kLocalMusicCell;
//        }
//    }
    if (indexPath.section == 0) {
        str = indexPath.row == 0 ? kLocalMusicCell : kFounctionCell;
    } else {
        str = kSubscribeCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        ((MusicHouseCell *)cell).delegate = self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

kRemoveCellSeparator

#pragma mark - MusicHouseCellDelegate
- (void)musicHouseCell:(UITableViewCell *)musicHouseCell selectedItem:(MusicItemType)itemType{
    switch (itemType) {
        case MusicItemTypeChoose: {
            //1
            DDLogVerbose(@"我喜欢");
            break;
        }
        case MusicItemTypeRank: {
            //2
            DDLogVerbose(@"下载管理");
            break;
        }
        case MusicItemTypeMedia: {
            //3
            DDLogVerbose(@"歌单");
            break;
        }
        case MusicItemTypeCommunity: {
            //4
            DDLogVerbose(@"播放记录");
            break;
        }
    }
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

@end
