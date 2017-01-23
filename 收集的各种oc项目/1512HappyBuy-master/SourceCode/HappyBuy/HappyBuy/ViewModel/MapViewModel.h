//
//  MapViewModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/3.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPNetManager.h"

@interface MapViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<BusinessBusinessesModel *> *dataList;

- (void)getBusinessWithCategory:(NSString *)category region:(MKCoordinateRegion)region completionHandler:(void(^)(NSError *error))completionHandler;

@end
