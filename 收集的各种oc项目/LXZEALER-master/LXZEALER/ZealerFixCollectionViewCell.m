//
//  ZealerFixCollectionViewCell.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "ZealerFixCollectionViewCell.h"

@implementation ZealerFixCollectionViewCell{
    CGRect originRect ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setImageForCellWithIndexpath:(NSIndexPath*)indexpath{
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"iphone1",
                         @"iphone2",
                         @"iphone3",
                         @"iphone4",
                         @"iphone5",
                         @"iphone6",
                         @"iphone7",nil];
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"iphone 6 Plus",
                          @"iphone 6",
                          @"iphone 5s",
                          @"iphone 5c",
                          @"iphone 5",
                          @"iphone 4s",nil];
    
    NSArray *priceArray = [NSArray arrayWithObjects:@"¥ 4299.00起",
                           @"¥ 3999.00起",
                           @"¥ 2099.00起",
                           @"¥ 1399.00起",
                           @"¥ 1599.00起",
                           @"¥ 999.00起",
                           nil];
    
    if (indexpath.row == 6) {
        self.productImageView.image = [UIImage imageNamed:imageNameArray[6]];
        self.productNameLabel.text = @"查看更多";
        self.productPriceLabel.text = @"";
    }
    else{
        self.productImageView.image = [UIImage imageNamed:imageNameArray[indexpath.row]];
        self.productNameLabel.text = nameArray[indexpath.row];
        self.productPriceLabel.text = priceArray[indexpath.row];
    }
}

@end
