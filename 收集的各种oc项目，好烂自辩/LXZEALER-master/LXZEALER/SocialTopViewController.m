//
//  SocialTopViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/3.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "SocialTopViewController.h"
#import "SocialGroupCollectionViewCell.h"
#import "SocialWebViewController.h"

#define BUTTON_WIDTH 180
#define BUTTON_HEIGHT 89

@implementation SocialTopViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initScrollView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SocialGroupCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.contentSize = CGSizeMake(BUTTON_WIDTH * 3 + 32, 100);
    
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *imageName = [NSString stringWithFormat:@"socialScroll%d",i + 1];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        button.frame = CGRectMake(8 + (8 + BUTTON_WIDTH) * i, 8, BUTTON_WIDTH, BUTTON_HEIGHT);
        button.tag = i;
        [button addTarget:self action:@selector(scrollButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
    
}

- (void)initScrollView{
    UIImage *image1 = [UIImage imageNamed:@"top2.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"top1.jpg"];
    NSArray *array = [NSArray arrayWithObjects:image1,image2, nil];
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) imagesGroup:array];
    scrollView.delegate = self;
    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:scrollView];
    
}

- (void)scrollButton:(UIButton*)sender{
    SocialWebViewController *webVC = [[SocialWebViewController alloc] init];
    switch (sender.tag) {
        case 0:
            webVC.websiteId = 1;
            break;
        case 1:
            webVC.websiteId = 2;
            break;
        case 2:
            webVC.websiteId = 3;
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SocialWebViewController *webVC = [[SocialWebViewController alloc] init];
    webVC.websiteId = (int)index;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma  mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 11;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cell";
    SocialGroupCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setImageForCellWithIndexpath:indexPath];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了%ld个cell",indexPath.row);
}
- (IBAction)moreButtonAction:(UIButton *)sender {
    NSLog(@"more...");
}

@end




