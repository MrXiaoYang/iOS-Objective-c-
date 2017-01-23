//
//  YXPickerView.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

/*
 使用TableView模仿UIPickerView, 制作多层级视图
 */

#import <UIKit/UIKit.h>

@class YXPickerView;

NS_ASSUME_NONNULL_BEGIN


@protocol YXPickerViewDataSource <NSObject>

@required

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(YXPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(YXPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol YXPickerViewDelegate <NSObject>
@optional
/** 行宽 */
- (CGFloat)yxPickerView:(YXPickerView *)yxpickerView widthForComponent:(NSInteger)component;
/** 行高 */
- (CGFloat)yxPickerView:(YXPickerView *)yxpickerView rowHeightForComponent:(NSInteger)component;

/** 每行的题目 */
- (nullable NSString *)pickerView:(YXPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (nullable NSAttributedString *)pickerView:(YXPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
/** 选中某行时 */
- (void)pickerView:(YXPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
/** 自定义视图 */
- (UIView *)yxPickerView:(YXPickerView *)yxpickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;

@end

@interface YXPickerView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSCoding>

@property (nonatomic, weak, nullable) id<YXPickerViewDelegate> delegate;
@property (nonatomic, weak, nullable) id<YXPickerViewDataSource> dataSource;

@property(nonatomic,readonly) NSInteger numberOfComponents;

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (NSInteger)selectedRowInComponent:(NSInteger)component;
- (NSInteger)numberOfRowsInComponent:(NSInteger)component;
- (CGSize)rowSizeForComponent:(NSInteger)component;
- (nullable UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;

@end

NS_ASSUME_NONNULL_END