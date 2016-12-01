//
//  UITableView+MXYTableView.h

//

#import <UIKit/UIKit.h>

@interface UITableView (MXYTableView)
/**
 *  快速创建tableView
 *
 *  @param frame    tableView的frame
 *  @param delegate 代理
 *
 *  @return 返回一个自定义的tableView
 */
+ (UITableView *)initWithTableView:(CGRect)frame withDelegate:(id)delegate;
@end
