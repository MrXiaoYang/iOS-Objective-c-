
![597d436214da822392419a7788a5ec0805d5d4f7.jpg](http://upload-images.jianshu.io/upload_images/939127-36a510bfeeb8a0c3.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
简书地址：[简书入口](http://www.jianshu.com/p/c19052dd96e5)
  
  

9.16日提示 修复了一下首页因为数据原因引起的崩溃问题。内涵段子服务数据结构复杂，有些判断逻辑可能不是很严谨，造成了崩溃，大家可以下载最新版本的

 介绍：  

 花了两周的闲余时间模仿了一下今日头条旗下的iOS端app内涵段子，如果喜欢的话请给个star。(8.30-9.11)  

 这个项目是用OC编写，如果有的朋友已经下载下来看了这个项目， 就会意识到这个项目没有一个storyboard或者是nib，不是因为不喜欢用storyboard或者nib，而是因为一直以来就想用纯代码写个项目，（好远大的梦想。。开玩笑的。。），但是项目是写出来的，光想不做不写是不行的，所以我就开始我的”内涵之旅“了。


![1.gif](http://upload-images.jianshu.io/upload_images/939127-bec577630d600bdd.gif?imageMogr2/auto-orient/strip)


####日志:
8.30号：没怎么做东西，就是搭建了项目的架构，拉入了之前经常用的一些工具类，宏定义等等。
8.30主要事项：UITabbarController+UINavigationController项目架构组建。
部分代码
```
// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    NHBaseNavigationViewController *nav = [[NHBaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}
``` 
8.31号：开始在8.30建的类上面填充内容，首页，这个最复杂的界面。
搭建类似于今日头条首页的架构。开始抓接口，添加接口的公共参数，完善请求基类。还有几个展示的列表页的编写，由简单入难，有助于在开发中培养自信心。
``` 
/** 链接*/
@property (nonatomic, copy) NSString *nh_url;
/** 默认GET*/
@property (nonatomic, assign) BOOL nh_isPost;
/** 图片数组*/
@property (nonatomic, strong) NSArray <UIImage *>*nh_imageArray;

/** 构造方法*/
+ (instancetype)nh_request;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost delegate:(id <NHBaseRequestReponseDelegate>)nh_delegate;

/** 开始请求，如果设置了代理，不需要block回调*/
- (void)nh_sendRequest;
/** 开始请求，没有设置代理，或者设置了代理，需要block回调，block回调优先级高于代理*/
- (void)nh_sendRequestWithCompletion:(NHAPIDicCompletion)completion;
```

9.1号， 控制器和cell以及普通文本图片数据的展示，以及发布界面的视图封装。
9.2 - 9.4 首页的回调处理以及发现界面
``` 
typedef NS_ENUM(NSUInteger, NHHomeTableViewCellItemType) {
    /** 点赞*/
    NHHomeTableViewCellItemTypeLike = 1,
    /** 踩*/
    NHHomeTableViewCellItemTypeDontLike,
    /** 评论*/
    NHHomeTableViewCellItemTypeComment,
    /** 分享*/
    NHHomeTableViewCellItemTypeShare
}; 
@class NHHomeTableViewCellFrame , NHHomeTableViewCell, NHDiscoverSearchCommonCellFrame, NHNeiHanUserInfoModel;
@protocol NHHomeTableViewCellDelegate <NSObject>

/** 点击浏览大图*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickImageView:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray <NSURL *>*)urls;
/** 播放视频*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickVideoWithVideoUrl:(NSString *)videoUrl videoCover:(NHBaseImageView *)baseImageView;
/** 分类*/
- (void)homeTableViewCellDidClickCategory:(NHHomeTableViewCell *)cell;
/** 个人中心*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(NHNeiHanUserInfoModel *)userInfoModel;
/** 点击底部item*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType;

@optional
/** 点击关注*/
- (void)homeTableViewCellDidClickAttention:(NHHomeTableViewCell *)cell;
/** 删除*/
- (void)homeTableViewCellDidClickClose:(NHHomeTableViewCell *)cell;
@end
@interface NHHomeTableViewCell : NHBaseTableViewCell

/** 代理*/
@property (nonatomic, weak) id <NHHomeTableViewCellDelegate> delegate;
/** 首页cellFrame模型*/
@property (nonatomic, strong) NHHomeTableViewCellFrame *cellFrame;
/** 搜索cellFrame模型*/
@property (nonatomic, strong) NHDiscoverSearchCommonCellFrame *searchCellFrame;
/** 用来判断是否有删除按钮*/
@property (nonatomic, assign) BOOL isFromHomeController;

/** 判断是否在详情页*/
- (void)setCellFrame:(NHHomeTableViewCellFrame *)cellFrame isDetail:(BOOL)isDetail;
/** 设置关键字*/
- (void)setSearchCellFrame:(NHDiscoverSearchCommonCellFrame *)searchCellFrame keyWord:(NSString *)keyWord;
/** 点赞*/
- (void)didDigg;
/** 踩*/
- (void)didBury;
```
9.5 - 9.7审核界面的逻辑处理和动画处理，以及发现界面的轮播图和自定义pageControl
```
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置选中layer的动画
    
    CGFloat delta = self.width -  self.numberOfItems * self.pageWidth + (self.numberOfItems - 1) * self.pageSpace - 15;
    [path moveToPoint:CGPointMake(currentIndex  * self.pageWidth + currentIndex * self.pageSpace + delta, 5)];
    [path addLineToPoint:CGPointMake((currentIndex + 1) * self.pageWidth + currentIndex * self.pageSpace + delta , 5)];
    
    // path(平移动画)
    CGFloat duration = 1.0;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.fromValue = (__bridge id _Nullable)(self.prePath.CGPath);
    animation.toValue = (__bridge id _Nullable)(path.CGPath);
    [self.selectedLayer addAnimation:animation forKey:@""];
    
    self.prePath = path;
}

- (void)setNumberOfItems:(NSInteger)numberOfItems {
    _numberOfItems = numberOfItems;
    if (self.pageWidth * numberOfItems + self.pageSpace * (numberOfItems - 1) > self.frame.size.width) {
        self.pageWidth = (self.frame.size.width - self.pageSpace * (numberOfItems - 1)) / numberOfItems;
    }
    CGFloat originX = 0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 内容充不满，需要靠右边对齐
    CGFloat delta = self.width -  numberOfItems * self.pageWidth + (numberOfItems - 1) * self.pageSpace - 15;
    for (int i = 0; i < numberOfItems; i++) {
        originX = i * self.pageSpace + self.pageWidth * i + delta;
        [path moveToPoint:CGPointMake(originX, 5)];
        [path addLineToPoint:CGPointMake(originX + self.pageWidth, 5)];
        path.lineWidth = 5;
        if (i == 0) {
            self.prePath = path;
            self.selectedLayer.path = self.prePath.CGPath;
        }
    }
    self.showPageLayer.path = path.CGPath;
}
```
9.8 - 9.9，搜索界面的逻辑处理
个人中心内容的填充，部分公共空数据界面视图的处理
9.10 视频的播放和一些地方的修修补补
9.11部分动画效果的完善，例如点赞和踩，关注等。。以及简单的测试。9.11晚上编写博文上传Github。
``` 
@interface NHCustomCommonEmptyView : UIView
@property (nonatomic, weak) UIImageView *topTipImageView;
@property (nonatomic, weak) UILabel *firstL;
@property (nonatomic, weak) UILabel *secondL;

- (instancetype)initWithTitle:(NSString *)title
                  secondTitle:(NSString *)secondTitle
                     iconname:(NSString *)iconname;
- (instancetype)initWithAttributedTitle:(NSMutableAttributedString *)attributedTitle
                  secondAttributedTitle:(NSMutableAttributedString *)secondAttributedTitle
                               iconname:(NSString *)iconname;
- (void)showInView:(UIView *)view;

@end
```


##主要实现的功能如下：

#### 首页 : 包括点赞、踩、分享、收藏，复制链接，视频的播放，上拉下拉，评论列表，关注列表
#####首页：
>要点处理：将请求到的列表数据，转化为模型数组，然后计算出模型所对应的frame数组，这样做的好处是防止CellForHeight会计算多次，缺点是计算量大， 需要耐心。

> 利用视图的drawRect方法来达到滚动条滑动的时候的穿透效果，封装分享视图，见NHHomeShareView ，封装带有高斯模糊效果的自定义弹窗，与系统的UIAlertView相差无几，效果更佳。

>评论列表：利于YYLabel和NSAttributeString，将@的用户的名字高亮，加以点击事件。

>分享： 封装分享管理类，配置友盟的appKey和UrlScheme等一系列必要操作。

>图片浏览器，根据数据展示布局九宫格视图，然后利于自定义的NHBaseImgeView，将网络图片的请求处理逻辑全部放到该类中，还记得当SDWebimage的方法加上sd_开头的时候，我们吃过的亏么？

>Gif图的处理，封装一个Gif视图，继承自UIImageView，然后顶部加载loading。


![
![3.gif](http://upload-images.jianshu.io/upload_images/939127-98fd99423876390a.gif?imageMogr2/auto-orient/strip)
](http://upload-images.jianshu.io/upload_images/939127-121e352cd9a21a12.gif?imageMogr2/auto-orient/strip)


#### 发现：轮播，热吧列表，推荐的关注用户列表，订阅列表，搜索，附近的人，附近的人的筛选，
#####发现“
>要点处理：利用UICollectionview实现无限滚动轮播视图，利于贝塞尔曲线自定义pageControl，类似于系统的UIPageControl，当改变当前索引的时候，曲线改变，设置layer的动画。

>附近的人：思路：当app启动的时候先请求一次定位信息，如果请求到了将经纬度保存，然后如果进入附近的人重新定位，获取最新的经纬度，获取附近的人列表，封装筛选视图，根据性别筛选附近的人。

>搜索：自定义搜索框，如果业务逻辑比较深的话，用系统的UISearchBar就不太现实了，需要让搜索框变得变得高度可定制化。搜索关键字，将搜索结果的文本转化为富文本，自定义多种不同类型的cell，然后显示数据，处理业务逻辑。要点在于，搜索的时候需要同时并发调用三个接口，搜索用户、动态还有热吧.

>这时候处理单个界面的多个并发网络请求用到了dispatch_group[想了解GCD可点击此链接](http://blog.csdn.net/wangzitao126/article/details/43195533), 当然，如果你的项目使用的RAC，那么这个dispatch_group，就可以摒弃了。

![4.gif](http://upload-images.jianshu.io/upload_images/939127-67512f783552d3bb.gif?imageMogr2/auto-orient/strip)

![5.gif](http://upload-images.jianshu.io/upload_images/939127-ed0e33ea58625113.gif?imageMogr2/auto-orient/strip)

#### 审核：举报，喜欢和不喜欢，手动左滑刷新，利用贝塞尔曲线和CAShaperLayer加载视图动画
#####审核
>处理：可以右滑来查看新的内涵段子动画，详情见下面Gif图。利于UICollectionview进行页面展示，自定义UICollectionviewFlowLayout布局。

>封装举报底部视图

>利于UIWebView加载Gif图，这里的处理不是很好

>封装一个带有loading进度条的时候，loading进度条的实现使用了CAShapeLayer和白塞尔曲线以及基本动画，详情可以去项目中的NHCheckTableViewProgressBar这个类。

![8.gif](http://upload-images.jianshu.io/upload_images/939127-42361f35820aad63.gif?imageMogr2/auto-orient/strip)

#### 发布：选择热吧，发布图片文字
##### 发布
>发布界面相对简单，利用masonry[masonry地址](https://github.com/SnapKit/Masonry)布局，处理键盘弹出下落通知事件，当键盘申弹出和下落的时候更新约束，可以看下标哥的这篇软文[masonry约束动画](http://blog.csdn.net/woaifen3344/article/details/50114415)

>利于UICollectionview布局图片选择完成后的界面，添加带有占位文字的高度可定制化的textView。

![7.gif](http://upload-images.jianshu.io/upload_images/939127-a9c571614261c037.gif?imageMogr2/auto-orient/strip)

![
![
![3.gif](http://upload-images.jianshu.io/upload_images/939127-72780653c0da73cd.gif?imageMogr2/auto-orient/strip)
](http://upload-images.jianshu.io/upload_images/939127-5e5c5fb61cc82107.gif?imageMogr2/auto-orient/strip)
](http://upload-images.jianshu.io/upload_images/939127-15a7925817178164.gif?imageMogr2/auto-orient/strip)

#### 用户：用户信息写死在本地，模仿登录逻辑
#####用户
>将用户信息利用归档存储在本地，用NSUserdefault记录用户是否在登陆状态

>修改头像，利用弹出的自定义的ActionSheet，详情可见NHCustomActionSheet类

![个人.jpeg](http://upload-images.jianshu.io/upload_images/939127-e5633ad9e53919c0.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


>项目中工具类众多，管理类也众多，如果您有需要或者是想了解的话可以去Github查看我的项目源码，还有几个比较好用的Demo也开源了。

####代码展示
```请求基类，在网络请求工具类上一层封装，传递属性，然后获取所有成员变量的值，即为请求参数
@protocol NHBaseRequestReponseDelegate <NSObject>
@required
/** 如果不用block返回数据的话，这个方法必须实现*/
- (void)requestSuccessReponse:(BOOL)success response:(id)response message:(NSString *)message;
@end

typedef void(^NHAPIDicCompletion)(id response, BOOL success, NSString *message);
@interface NHBaseRequest : NSObject

@property (nonatomic, weak) id <NHBaseRequestReponseDelegate> nh_delegate;
/** 链接*/
@property (nonatomic, copy) NSString *nh_url;
/** 默认GET*/
@property (nonatomic, assign) BOOL nh_isPost;
/** 图片数组*/
@property (nonatomic, strong) NSArray <UIImage *>*nh_imageArray;

/** 构造方法*/
+ (instancetype)nh_request;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost delegate:(id <NHBaseRequestReponseDelegate>)nh_delegate;

/** 开始请求，如果设置了代理，不需要block回调*/
- (void)nh_sendRequest;
/** 开始请求，没有设置代理，或者设置了代理，需要block回调，block回调优先级高于代理*/
- (void)nh_sendRequestWithCompletion:(NHAPIDicCompletion)completion;

@end
```

```
首页最复杂的cell
@class NHBaseImageView;

typedef NS_ENUM(NSUInteger, NHHomeTableViewCellItemType) {
    /** 点赞*/
    NHHomeTableViewCellItemTypeLike = 1,
    /** 踩*/
    NHHomeTableViewCellItemTypeDontLike,
    /** 评论*/
    NHHomeTableViewCellItemTypeComment,
    /** 分享*/
    NHHomeTableViewCellItemTypeShare
};

@class NHHomeTableViewCellFrame , NHHomeTableViewCell, NHDiscoverSearchCommonCellFrame, NHNeiHanUserInfoModel;
@protocol NHHomeTableViewCellDelegate <NSObject>

/** 分类*/
- (void)homeTableViewCellDidClickCategory:(NHHomeTableViewCell *)cell;
/** 个人中心*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(NHNeiHanUserInfoModel *)userInfoModel;
/** 点击底部item*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType;
/** 点击浏览大图*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickImageView:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray <NSURL *>*)urls;
/** 播放视频*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickVideoWithVideoUrl:(NSString *)videoUrl videoCover:(NHBaseImageView *)baseImageView;

@optional
/** 点击关注*/
- (void)homeTableViewCellDidClickAttention:(NHHomeTableViewCell *)cell;
/** 删除*/
- (void)homeTableViewCellDidClickClose:(NHHomeTableViewCell *)cell;
@end
@interface NHHomeTableViewCell : NHBaseTableViewCell

/** 代理*/
@property (nonatomic, weak) id <NHHomeTableViewCellDelegate> delegate;
/** 首页cellFrame模型*/
@property (nonatomic, strong) NHHomeTableViewCellFrame *cellFrame;
/** 搜索cellFrame模型*/
@property (nonatomic, strong) NHDiscoverSearchCommonCellFrame *searchCellFrame;
/** 用来判断是否有删除按钮*/
@property (nonatomic, assign) BOOL isFromHomeController;
```
```
审核，利用贝塞尔完成一些展示上的效果
- (void)setLeftScale:(CGFloat)leftScale {
    _leftScale = leftScale;
    NSInteger leftDelta = leftScale * 100;
    self.leftL.text = [NSString stringWithFormat:@"%ld%%", leftDelta];
    
    CGFloat height = 10;
    UIRectCorner corner = UIRectCornerAllCorners;
    if (leftScale == 1.0) {
        corner = UIRectCornerAllCorners;
    } else {
        corner = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    }
    
    UIBezierPath *bezierPath0 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.height / 2.0 - height / 2.0, 0, height) byRoundingCorners:corner cornerRadii:CGSizeMake(5.f, 5.f)];
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.height / 2.0 - height / 2.0, self.width * self.leftScale, height) byRoundingCorners:corner cornerRadii:CGSizeMake(5.f, 5.f)];
    
    CGFloat duration = 0.8;
    [self performSelector:@selector(showLeftAndRightLabel) withObject:nil afterDelay:duration];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.fromValue = (__bridge id _Nullable)(bezierPath0.CGPath);
    animation.toValue = (__bridge id _Nullable)(bezierPath1.CGPath);
    [self.leftLayer addAnimation:animation forKey:@""];
}
```
```
首页滑动穿透效果
// 滑动进度
- (void)setProgress:(CGFloat)progress {
    _progress = progress;

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [_fillColor set];
    
    CGRect newRect = rect;
    newRect.size.width = rect.size.width * self.progress;
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
}
```
####附上自定义的一些类，项目中有自定义的ActionSheet，AlertView，SegmentControl，pageControl等， 
```
贴上几段封装的关于tableView的一些代码
typedef NS_ENUM(NSInteger, NHBaseTableViewRowAnimation) {
    Fade = UITableViewRowAnimationFade,
    Right = UITableViewRowAnimationRight,           // slide in from right (or out to right)
    Left = UITableViewRowAnimationLeft,
    Top = UITableViewRowAnimationTop,
    Bottom = UITableViewRowAnimationBottom,
    None = UITableViewRowAnimationNone,            // available in iOS 3.0
    Middle = UITableViewRowAnimationMiddle,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
    Automatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you
};
@class NHBaseTableViewCell;
@interface NHBaseTableView : UITableView
- (void)nh_updateWithUpdateBlock:(void(^)(NHBaseTableView *tableView ))updateBlock;
- (UITableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath;

/** 注册普通的UITableViewCell*/
- (void)nh_registerCellClass:(Class)cellClass identifier:(NSString *)identifier;

/** 注册一个从xib中加载的UITableViewCell*/
- (void)nh_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier;

/** 注册一个普通的UITableViewHeaderFooterView*/
- (void)nh_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier;

/** 注册一个从xib中加载的UITableViewHeaderFooterView*/
- (void)nh_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier;

#pragma mark - 只对已经存在的cell进行刷新，没有类似于系统的 如果行不存在，默认insert操作
/** 刷新单行、动画默认*/
- (void)nh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 刷新单行、动画默认*/
- (void)nh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(NHBaseTableViewRowAnimation)animation;

/** 刷新多行、动画默认*/
- (void)nh_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 刷新多行、动画默认*/
- (void)nh_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(NHBaseTableViewRowAnimation)animation;

/** 刷新某个section、动画默认*/
- (void)nh_reloadSingleSection:(NSInteger)section;

/** 刷新某个section、动画自定义*/
- (void)nh_reloadSingleSection:(NSInteger)section animation:(NHBaseTableViewRowAnimation)animation;

/** 刷新多个section、动画默认*/
- (void)nh_reloadSections:(NSArray <NSNumber *>*)sections;

/** 刷新多个section、动画自定义*/
- (void)nh_reloadSections:(NSArray <NSNumber *>*)sections animation:(NHBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行删除操作
/** 删除单行、动画默认*/
- (void)nh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 删除单行、动画自定义*/
- (void)nh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(NHBaseTableViewRowAnimation)animation;

/** 删除多行、动画默认*/
- (void)nh_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 删除多行、动画自定义*/
- (void)nh_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(NHBaseTableViewRowAnimation)animation;

/** 删除某个section、动画默认*/
- (void)nh_deleteSingleSection:(NSInteger)section;
```

####[简单易用的tableViewControllerGithub地址](https://github.com/Charlesyaoxin/CustomTableViewController)


###分析和总结
-  这个项目做得时间比较仓促，前后用了不到两周的时间。
-  不知道仔细看的朋友有没有意识到，这是用纯代码写的，并不是自己不习惯用nib或者sb，是因为一直以来想用纯代码写一个项目。
-   所有的东西都是在公司的事情忙完的情况下编写的，最近公司不是特别忙，所以有时间写点自己的东西，当然下班回家晚上也花了不少时间用在了这个项目上面。
-  项目中有些类和文件是之前自己整理的直接拖进去用，一定的意义上来说节省了时间。
-  bug有很多，我也没怎么测直接就提交Github了，以后可能会再更新这个项目吧
-  下一阶段的方向大概是swift项目了，现在在着手一个swift小项目，前段时间写的，大概75%完成度了，也会在未来开源出来，这个项目的话短期内不会再更新了。
-  如果想交朋友的可以加我qq3297391688，共同进步，成为一名真正的‘老司机’
-  如果您喜欢这个项目，或者这个项目帮助到了您，请联系我，或者给我点赞和评论吧。
代码先不更新了，针对出现的问题，如果首页出现崩溃现象，朋友们请重新运行一下。
 想了解更多请移步至简书地址《简书地址》：http://www.jianshu.com/users/3930920b505b/latest_articles
    
