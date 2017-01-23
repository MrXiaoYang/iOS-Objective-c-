//
//  CategoryViewController.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "CategoryViewController.h"
#import "YXPickerView.h"
#import "PlistDataManager.h"

@interface CategoryViewController ()<YXPickerViewDelegate, YXPickerViewDataSource>
@property (nonatomic) YXPickerView *pickerView;
@property (nonatomic) NSArray<CategoriesModel *> *categories;
@property (nonatomic) NSInteger selectedRow;
@end

@implementation CategoryViewController

#pragma mark - 代理 UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(YXPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(YXPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.categories.count;
    }
    return self.categories[component].subcategories.count;
}

- (NSString *)pickerView:(YXPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.categories[row].name;
    }
    return self.categories[self.selectedRow].subcategories[row];
}

/** 行宽 */
- (CGFloat)yxPickerView:(YXPickerView *)yxpickerView widthForComponent:(NSInteger)component{
    return self.view.bounds.size.width/2;
}
/** 行高 */
- (CGFloat)yxPickerView:(YXPickerView *)yxpickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (void)pickerView:(YXPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0 ) {
        self.selectedRow = row;
        [self.pickerView reloadComponent:1];
    }
    if (component == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
        !_chooseCategoryHandler ?: _chooseCategoryHandler(self.categories[self.selectedRow].subcategories[row]);
    }
    
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedRow = 0;
    [PlistDataManager getCategories:^(NSArray<CategoriesModel *> *categories, NSError *error) {
        self.categories = categories;
        [self.pickerView reloadAllComponents];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - 懒加载
- (YXPickerView *)pickerView {
    if(_pickerView == nil) {
        _pickerView = [[YXPickerView alloc] init];
        [self.view addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

@end
