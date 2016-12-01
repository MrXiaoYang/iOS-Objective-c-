//
//  MapViewController.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/3.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewModel.h"
#import "WebViewController.h"
@import MapKit;


@interface TRAnnotation : NSObject<MKAnnotation>
@property (nonatomic) BusinessBusinessesModel *businessModel;
- (void)changeTitle:(NSString *)title;
@end
@implementation TRAnnotation
@synthesize coordinate = _coordinate;
@synthesize title = _title;
- (void)changeTitle:(NSString *)title{
    _title = title;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}
@end

@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) MapViewModel *mapVM;

@property (nonatomic) BOOL alreadyShowUserLocation;
@property (nonatomic) NSMutableSet *dataSet;
@property (nonatomic) MKUserLocation* userLocation;
@end

@implementation MapViewController

#pragma mark - 代理 MapView
/** 当地图显示区域发生变化时触发 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self showBussinessedInMapView];
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    static NSString *identify = @"annotationView";
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] init];
        //        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"ic_category_default"];
        UITapGestureRecognizer *tapGR = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            MKAnnotationView *annotationV = (MKAnnotationView *)sender.view;
            if(annotationV.selected){ //弹出气泡时
                WebViewController *webVC = [[WebViewController alloc] initWithURL:[NSURL URLWithString:[[(TRAnnotation *)annotationV.annotation businessModel] businessURL]]];
                [self.navigationController pushViewController:webVC animated:YES];
            }
        }];
        [annotationView addGestureRecognizer:tapGR];
    }
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    self.userLocation = userLocation;
    if (!self.alreadyShowUserLocation) {
        [self relocation:nil];
    }
}

#pragma mark - 方法
- (void)showBussinessedInMapView{
    [self.mapVM cancelTask]; //取消之前进行的网络操作
    [self.mapVM getBusinessWithCategory:self.category region:self.mapView.region completionHandler:^(NSError *error) {
        if (error) {
            //[self.view showWarning:error.localizedDescription];
        }else{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //                NSMutableArray *annotions = [NSMutableArray new];
                NSMutableArray *annotions = @[].mutableCopy;
                for (BusinessBusinessesModel *model in self.mapVM.dataList) {
                    TRAnnotation *pointA = [TRAnnotation new];
                    [pointA setCoordinate:CLLocationCoordinate2DMake(model.latitude, model.longitude)];
                    [pointA changeTitle:model.name];
                    //                    if (![self.dataSet containsObject:pointA]) {
                    //                        [annotions addObject:pointA];
                    //                    }
                    pointA.businessModel = model;
                    [self.dataSet containsObject:pointA] ?: [annotions addObject:pointA];
                    [self.dataSet addObject:pointA];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[self.mapView removeAnnotations:self.mapView.annotations];
                    [self.mapView addAnnotations:self.dataSet.allObjects];
                });
            });
        }
    }];
}
- (IBAction)relocation:(id)sender {
    self.alreadyShowUserLocation = YES;
    [self.mapView setRegion:MKCoordinateRegionMake(self.userLocation.location.coordinate, MKCoordinateSpanMake(0.1, 0.1)) animated:YES];
}

#pragma mark - 生命周期
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.alreadyShowUserLocation = NO;
        self.category = @"美食";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Factory addBackItemToVC:self];
    
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
- (MapViewModel *)mapVM {
    if(_mapVM == nil) {
        _mapVM = [[MapViewModel alloc] init];
    }
    return _mapVM;
}

- (NSMutableSet *)dataSet {
    if(_dataSet == nil) {
        _dataSet = [[NSMutableSet alloc] init];
    }
    return _dataSet;
}

@end
