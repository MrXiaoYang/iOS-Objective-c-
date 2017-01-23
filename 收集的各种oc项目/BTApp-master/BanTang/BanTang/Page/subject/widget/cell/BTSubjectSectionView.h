//
//  BTSubjectSectionView.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTSubjectSectionView;
@protocol BTSubjectSectionViewDelegate <NSObject>

- (void)sectionView:(BTSubjectSectionView *)sectionView didClickIndexButton:(NSInteger)index;

@end

@interface BTSubjectSectionView : UIView

+ (instancetype)sectionView;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak)id <BTSubjectSectionViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentSelctedNum;

@end
