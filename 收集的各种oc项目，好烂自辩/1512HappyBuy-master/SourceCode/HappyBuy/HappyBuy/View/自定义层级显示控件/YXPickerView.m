//
//  YXPickerView.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "YXPickerView.h"

@interface YXPickerViewCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSInteger rowNumber;
@property (nonatomic) UIView *customView;
@property (nonatomic) NSString *text;
@property (nonatomic, copy) void(^clickedHandler)(YXPickerViewCell *cell ,NSInteger row);
@property (nonatomic) id<YXPickerViewDelegate> delegate;
@property (nonatomic) NSInteger componentNumber;
@property (nonatomic, weak) YXPickerView *pickerView;
@end

@implementation YXPickerViewCell
#pragma mark - 代理UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (_customView) {
            [cell.contentView addSubview:[_customView copy]];
            _customView.frame = cell.contentView.bounds;
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        cell.backgroundColor= [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    if ([self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        cell.textLabel.text = [self.delegate pickerView:self.pickerView titleForRow:indexPath.row forComponent:self.componentNumber];
    }
    if ([self.delegate respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]) {
        cell.textLabel.attributedText = [self.delegate pickerView:self.pickerView attributedTitleForRow:indexPath.row forComponent:self.componentNumber];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !_clickedHandler ?: _clickedHandler(self, indexPath.row);
}

#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //    NSLog(@"%@", NSStringFromCGRect(frame));
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_tableView];
    }
    return self;
}

@end

/** Default Row Size */
#define kRowHeight    44
#define kRowWidth     100

@interface YXPickerView()
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation YXPickerView

#pragma mark - 代理UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numberOfComponents;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YXPickerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YXPickerViewCell" forIndexPath:indexPath];
    cell.delegate = self.delegate;
    cell.componentNumber = indexPath.row;
    cell.pickerView = self;
    cell.rowNumber = [self.dataSource pickerView:self numberOfRowsInComponent:indexPath.row];
    [cell.tableView reloadData];
    cell.clickedHandler = ^(YXPickerViewCell *pickerCell, NSInteger row){
        if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
            [self.delegate pickerView:self didSelectRow:row inComponent:pickerCell.componentNumber];
        }
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([self rowSizeForComponent:indexPath.row].width, collectionView.bounds.size.height);
}

#pragma mark - 方法

- (NSInteger)selectedRowInComponent:(NSInteger)component{
    return 2;
}

- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component{
    return nil;
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    
}

- (CGSize)rowSizeForComponent:(NSInteger)component{
    CGFloat height = kRowHeight;
    if ([self.delegate respondsToSelector:@selector(yxPickerView:rowHeightForComponent:)]) {
        height = [self.delegate yxPickerView:self rowHeightForComponent:component];
    }
    
    CGFloat width = kRowWidth;
    if ([self.delegate respondsToSelector:@selector(yxPickerView:widthForComponent:)]) {
        width = [self.delegate yxPickerView:self widthForComponent:component];
    }
    return CGSizeMake(width, height);
}

- (NSInteger)numberOfComponents{
    return [self.dataSource numberOfComponentsInPickerView:self];
}

- (void)reloadComponent:(NSInteger)component{
    YXPickerViewCell *cell = (YXPickerViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:component inSection:0]];
    [cell.tableView reloadData];
}

- (void)reloadAllComponents{
    [self.collectionView reloadData];
}

#pragma mark - 生命周期

kCodingMethod


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self collectionView];
    }
    return self;
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[YXPickerViewCell class] forCellWithReuseIdentifier:@"YXPickerViewCell"];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

@end














