//
//  RecommentCollectionViewFlowLayout.m
//  BiliBili
//
//  Created by JimHuang on 16/1/14.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "RecommentCollectionViewFlowLayout.h"
#define kEdge 10

@interface RecommentCollectionViewFlowLayout()
@property (nonatomic, strong) NSValue *contentCellSize;
@property (nonatomic, strong) NSValue *titleCellSize;
@property (nonatomic, strong) NSValue *cellSize;
@end

@implementation RecommentCollectionViewFlowLayout
- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.cellSize.CGSizeValue.width, (self.cellSize.CGSizeValue.height + kEdge) * [self.collectionView numberOfSections]);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建空白的attributes对象
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize contentCellSize = self.contentCellSize.CGSizeValue;
    CGSize titltCellSize = self.titleCellSize.CGSizeValue;
    
    //当前行的y坐标
    CGFloat y = indexPath.section * self.cellSize.CGSizeValue.height;
    
    CGFloat cell1X = kEdge;
    CGFloat cell2X = 2 * cell1X + contentCellSize.width;
    
    //针对情况，判断当前格在哪个位置，从而计算出frame
    if (indexPath.item % 5 == 0) {
        attr.frame = CGRectMake(0, y, titltCellSize.width, titltCellSize.height);
    }else if (indexPath.item % 5 == 1){
        attr.frame = CGRectMake(cell1X, y + titltCellSize.height + kEdge, contentCellSize.width, contentCellSize.height);
    }else if (indexPath.item % 5 == 2){
        attr.frame = CGRectMake(cell2X, y + titltCellSize.height + kEdge, contentCellSize.width, contentCellSize.height);
    }else if (indexPath.item % 5 == 3){
        attr.frame = CGRectMake(cell1X, y + titltCellSize.height + 2 *kEdge + contentCellSize.height, contentCellSize.width, contentCellSize.height);
    }else if (indexPath.item % 5 == 4){
        attr.frame = CGRectMake(cell2X, y + titltCellSize.height + 2 *kEdge + contentCellSize.height, contentCellSize.width, contentCellSize.height);
    }
    return attr;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger sectionNum = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionNum; ++i) {
        CGFloat itemCount = [self.collectionView numberOfItemsInSection: i];
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection: i];
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
            [array addObject:attr];
        }
    }
    return array;
}


#pragma mark - 懒加载
- (NSValue *)contentCellSize {
	if(_contentCellSize == nil) {
        CGFloat contentCellWidth = (self.titleCellSize.CGSizeValue.width - 3 * kEdge) / 2;
		_contentCellSize = [NSValue valueWithCGSize: CGSizeMake(contentCellWidth, contentCellWidth / 0.96)];
	}
	return _contentCellSize;
}

- (NSValue *)titleCellSize {
	if(_titleCellSize == nil) {
		_titleCellSize = [NSValue valueWithCGSize: CGSizeMake(self.collectionView.frame.size.width, 25)];
	}
	return _titleCellSize;
}

- (NSValue *)cellSize {
	if(_cellSize == nil) {
		_cellSize = [NSValue valueWithCGSize: CGSizeMake(self.titleCellSize.CGSizeValue.width, self.titleCellSize.CGSizeValue.height + self.contentCellSize.CGSizeValue.height * 2 + 4 * kEdge)];
	}
	return _cellSize;
}

@end
