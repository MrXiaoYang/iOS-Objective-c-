//
//  AVItemTableViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/8.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "AVItemTableViewController.h"
#import "AVInfoViewController.h"

#import "AVInfoViewModel.h"
#import "ShiBanInfoViewModel.h"

#import "ShiBanEpisodesTableViewCell.h"
#import "ShiBanIntroduceTableViewCell.h"
#import "AVItemTableViewCell.h"

@interface AVItemTableViewController ()
//根据cell的标识符判断初始化的cell类型
@property (nonatomic, strong) NSArray<NSString*> *cellIdentitys;
@property (nonatomic, weak) id vm;
@end

@implementation AVItemTableViewController

#pragma mark - TableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //textCell SameVideoTableViewCell ReViewTableViewCell InvestorTableViewCell
    return [@{@"AVItemTableViewCell":@(2), @"ShiBanEpisodesTableViewCell":@(1), @"ShiBanIntroduceTableViewCell":@(1),@"SameVideoTableViewCell": @([self.vm sameVideoCount]),@"InvestorTableViewCell":@([self.vm investorCount]), @"ReViewTableViewCell":@([self.vm replyCount])}[self.cellIdentitys[section]] integerValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellIdentitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentitys[indexPath.section]];
    if (cell == nil) {
        cell = [[NSClassFromString(self.cellIdentitys[indexPath.section]) alloc] initWithStyle:0 reuseIdentifier:self.cellIdentitys[indexPath.section]];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return [self setCellContent:cell index:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.cellIdentitys[indexPath.section] isEqualToString:@"SameVideoTableViewCell"]) {
        sameVideoDataModel* sModle = [self.vm sameVideoModelForRow: indexPath.row];
        AVDataModel* avModel = [[AVDataModel alloc] init];
        avModel.title = sModle.title;
        avModel.desc = sModle.desc;
        avModel.pic = sModle.pic;
        avModel.play = sModle.click;
        avModel.aid = sModle.identity;
        avModel.author = sModle.author_name;
        NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        avModel.create = [fmt stringFromDate: [[NSDate alloc] initWithTimeIntervalSince1970: sModle.pubdate.integerValue]];
        avModel.video_review = sModle.dm_count;
        AVInfoViewController* vc = [[AVInfoViewController alloc] init];
        [vc setWithModel: avModel section: nil];
        [self.navigationController pushViewController: vc animated:YES];
    }
}

#pragma mark - 方法

- (id)setCellContent:(id)cell index:(NSIndexPath*)index{
    
    //根据标识类型初始化cell内容
    //相似视频cell
    if ([self.cellIdentitys[index.section] isEqualToString:@"SameVideoTableViewCell"]) {
        [cell setWithDic:@{@"videoImgView":[self.vm sameVideoPicForRow:index.row], @"videoLabel.text":[self.vm sameVideoTitleForRow:index.row],@"playNumLabel.text":[self.vm sameVideoPlayNumForRow:index.row],@"danMuLabel.text":[self.vm sameVideoReplyForRow:index.row]}];
        //评论cell
    }else if([self.cellIdentitys[index.section] isEqualToString:@"ReViewTableViewCell"]){
        [cell setWithDic:@{@"imgView":[self.vm replyIconForRow:index.row], @"nameLabel.text":[self.vm replyNameForRow:index.row],@"timeLabel.text":[self.vm replyTimeForRow:index.row],@"messageLabel.text":[self.vm replyMessageForRow:index.row],@"goodLabel.text":[self.vm replyGoodForRow:index.row],@"lvLabel.text":[self.vm replyLVForRow:index.row],@"genderImgView":[self.vm replyGenderForRow:index.row]}];
        
        //视频详情cell
    }else if ([self.cellIdentitys[index.section] isEqualToString:@"AVItemTableViewCell"]){
        
        [cell textLabel].font = [UIFont systemFontOfSize: 13];
        [cell textLabel].numberOfLines = 0;
        //tag
        if (index.row == 0) {
            [cell textLabel].attributedText = [self.vm infoTags];
            [cell textLabel].textColor = [[ColorManager shareColorManager] colorWithString:@"AVItemTableViewController.tagColor"];
            //简介
        }else{
            [cell textLabel].text = [self.vm infoBrief];
            [cell textLabel].textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
            
        }
    }else if([self.cellIdentitys[index.section] isEqualToString:@"InvestorTableViewCell"]){
        
        [cell setWithDic:@{@"rankLabel.text":[NSString stringWithFormat:@"%ld", (long)[self.vm investorRankForRow:index.row]], @"invertorIcon":[self.vm investorIconForRow:index.row],@"invertorName.text":[self.vm investorNameForRow:index.row],@"replyLabel.text":[self.vm investorMessageForRow:index.row]}];
        //番剧详情
    }else if ([self.cellIdentitys[index.section] isEqualToString:@"ShiBanEpisodesTableViewCell"]){
        //分集
        [cell setEpisodes: [self.vm shinBanInfoEpisode]];
         //简介
    }else if ([self.cellIdentitys[index.section] isEqualToString:@"ShiBanIntroduceTableViewCell"]){
         [cell setUpWithIntroduce:[self.vm shinBanInfoIntroduce]];
    }
    return cell;
}


- (instancetype)initWithVM:(AVInfoViewModel*)vm cellIdentitys:(NSArray<NSString*>*)cellIdentitys{
    if (self = [super init]) {
        self.vm = vm;
        self.cellIdentitys = cellIdentitys;
        self.tableView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
        self.tableView.separatorColor = [[ColorManager shareColorManager] colorWithString:@"separatorColor"];
        //设置默认不可滚动
        self.tableView.scrollEnabled = NO;
        self.tableView.estimatedRowHeight = 200;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        UITableViewController* vc = (UITableViewController*)self.parentViewController.parentViewController;
        vc.tableView.scrollEnabled = YES;
        scrollView.scrollEnabled = NO;
    }
}
@end
