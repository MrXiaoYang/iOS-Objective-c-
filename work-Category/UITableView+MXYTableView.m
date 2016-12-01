//
//  UITableView+MXYTableView.m

//

#import "UITableView+MXYTableView.h"

@implementation UITableView (MXYTableView)

+ (UITableView *)initWithTableView:(CGRect)frame withDelegate:(id)delegate
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    
    //将系统的Separator左边不留间隙
    tableView.separatorInset = UIEdgeInsetsZero;
    
    return tableView;
}

@end
