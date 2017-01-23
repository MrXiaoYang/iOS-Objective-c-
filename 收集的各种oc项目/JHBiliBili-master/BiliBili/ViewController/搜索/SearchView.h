//
//  SearchView.h
//  BiliBili
//
//  Created by apple-jd24 on 15/12/14.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchView;
@protocol SearchViewDelegate <NSObject>
@optional
/**
 *  点击搜索按钮协议
 */
- (void)searchButtonDown:(SearchView*)searchView searchText:(NSString*)searchText;
@end

@interface SearchView : UIView
@property (nonatomic, weak)id<SearchViewDelegate> delegate;
- (void)showSearchView;
- (void)hideSearchView:(void(^)())handel;
@end
