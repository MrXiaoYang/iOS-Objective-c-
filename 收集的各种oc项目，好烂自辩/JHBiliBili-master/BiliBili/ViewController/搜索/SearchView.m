//
//  SearchView.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/14.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchView.h"

@interface SearchView()
/**
 *  搜索框
 */
@property (nonatomic, strong)UITextField* searchTextField;
/**
 *  搜索确认按钮
 */
@property (nonatomic, strong)UIButton* searchButton;
/**
 *  圆形动画视图
 */
@property (nonatomic, strong)UIView* circleMaskView;
@end

@implementation SearchView

- (instancetype)init{
    if (self = [super init]) {
        self.searchButton.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.mask = self.circleMaskView.layer;
    }
    return self;
}
/**
 * 搜索框
 */
- (UITextField *)searchTextField{
	if(_searchTextField == nil) {
		_searchTextField = [[UITextField alloc] init];
        _searchTextField.font = [UIFont systemFontOfSize: 13];
        _searchTextField.placeholder = @" 搜索视频，番剧，up主或av号";
        [self addSubview: _searchTextField];
        [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(0);
            make.right.mas_offset(-40);
        }];
	}
	return _searchTextField;
}
/**
 * 搜索按钮
 */
- (UIButton *)searchButton{
	if(_searchButton == nil) {
		_searchButton = [[UIButton alloc] init];
        _searchButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_searchButton setImage: [UIImage imageNamed:@"ic_search_query"] forState: UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(touchSearchButton) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: _searchButton];
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_offset(0);
            make.left.mas_equalTo(self.searchTextField.mas_right);
        }];
	}
	return _searchButton;
}
/**
 * 搜索框
 */
- (UIView *)circleMaskView{
    if(_circleMaskView == nil) {
        _circleMaskView = [[UIView alloc] init];
        _circleMaskView.backgroundColor = [UIColor redColor];
        _circleMaskView.layer.anchorPoint = CGPointMake(0.8, 0.2);
        _circleMaskView.frame = CGRectMake(kWindowW, 0, 40, 40);
        CAShapeLayer *maskLayer  = [[CAShapeLayer alloc] init];
        UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 20, 20)];
        [maskLayer setPath: path.CGPath];
        _circleMaskView.layer.mask = maskLayer;
    }
    return _circleMaskView;
}

#pragma mark -  方法
- (void)showSearchView{
    self.hidden = NO;
    [UIView animateWithDuration: 0.5 animations:^{
        self.circleMaskView.transform = CGAffineTransformMakeScale(20, 20);
    }];
}
- (void)hideSearchView:(void(^)())handel{
    [UIView animateWithDuration:0.5 animations:^{
        self.circleMaskView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (handel != nil) {
            handel();
        }
    }];
}

#pragma mark - 协议方法

- (void)touchSearchButton{
    if ([self.delegate respondsToSelector:@selector(searchButtonDown:searchText:)]) {
        [self.delegate searchButtonDown:self searchText:[self.searchTextField.text stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLPathAllowedCharacterSet]]];
    }
}
@end
