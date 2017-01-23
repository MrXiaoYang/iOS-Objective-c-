//
//  RegionViewController.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "RegionViewController.h"
#import "PlistDataManager.h"

@interface RegionViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) NSArray<CitiesModel *> *cities;
@property (nonatomic) CitiesModel *currentCitiesModel;
@property (nonatomic) CitiesRegionsModel *currentCitiesRegionsModel;
@end


@implementation RegionViewController

#pragma mark - 代理 UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.cities.count;
    }else{
        return self.currentCitiesModel.regions.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.cities[row].name;
    }else{
        return self.currentCitiesModel.regions[row].name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.currentCitiesModel = self.cities[row];
        self.currentCitiesRegionsModel = self.currentCitiesModel.regions[0];
    }
    if (component == 1) {
        self.currentCitiesRegionsModel = self.currentCitiesModel.regions[row];
    }
    [pickerView reloadAllComponents];
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    !_chooseRegionHandler ?: _chooseRegionHandler(self.currentCitiesRegionsModel.name);
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [PlistDataManager getCities:^(NSArray<CitiesModel *> *cities, NSError *error) {
        self.cities = cities;
        NSInteger row = [self.cities indexOfObjectPassingTest:^BOOL(CitiesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj.name isEqualToString:kCurrentCity];
        }];
        if (row >= 0 && row < self.cities.count) {
            
        }else{
            row = 0;
        }
        self.currentCitiesModel = self.cities[row];
        self.currentCitiesRegionsModel = self.currentCitiesModel.regions[0];
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:row inComponent:0 animated:0];
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
- (UIPickerView *)pickerView {
    if(_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
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
