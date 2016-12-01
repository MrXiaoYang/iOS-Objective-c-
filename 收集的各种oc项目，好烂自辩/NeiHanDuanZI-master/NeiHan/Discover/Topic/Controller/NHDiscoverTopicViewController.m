//
//  NHDiscoverTopicViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverTopicViewController.h"
#import "NHDiscoverTopicRequest.h"
#import "NHHomeBaseViewController.h"
#import "NHDiscoverModel.h"
#import "NHPublishDraftViewController.h"

@interface NHDiscoverTopicViewController ()
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NHDiscoverCategoryElement *element;
@property (nonatomic, strong) NHHomeBaseViewController *controller;
@end

@implementation NHDiscoverTopicViewController

- (instancetype)initWithCatogoryId:(NSInteger)categoryId {
    if (self = [super init]) {
        self.categoryId = categoryId;
    }
    return self;
}

- (instancetype)initWithCategoryElement:(NHDiscoverCategoryElement *)element {
    if (self = [super init]) {
        self.element = element;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpItems];
    
    [self loadData];

}

- (void)setUpItems {
    if (self.element.name) {
        self.navigationItem.title = self.element.name;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"submission"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

- (void)rightItemClick {
    NHPublishDraftViewController *publishController = [[NHPublishDraftViewController alloc] init];
    [self pushVc:publishController];
}
// 请求数据
- (void)loadData  {
    [super loadData];
    NHDiscoverTopicRequest *request = [NHDiscoverTopicRequest nh_request];
    request.nh_url = kNHHomeCategoryDynamicListAPI;
    request.count = 30;
    request.level = 6;
    request.category_id = self.element ? self.element.ID : self.categoryId;
    request.message_cursor = 0;
    request.mpic = 1;
    NHHomeBaseViewController *controller = [[NHHomeBaseViewController alloc] initWithRequest:request];
    [self addChildVc:controller];
    _controller = controller;
}
@end
