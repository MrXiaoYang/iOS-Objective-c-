//
//  NHCustomPlaceHolderTextView.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//  有placeHolder的UITextView

#import <UIKit/UIKit.h>

@class NHCustomPlaceHolderTextView;
@protocol NHCustomPlaceHolderTextViewDelegate <NSObject>
/** 文本改变回调*/
- (void)customPlaceHolderTextViewTextDidChange:(NHCustomPlaceHolderTextView *)textView;
@end

@interface NHCustomPlaceHolderTextView : UITextView
@property (nonatomic, weak) id <NHCustomPlaceHolderTextViewDelegate> del;
@property (nonatomic,copy) NSString *placehoder;
@property (nonatomic,strong)UIColor *placehoderColor;
@property (nonatomic, assign) CGFloat placeholderTopMargin;
@property (nonatomic, assign) CGFloat placeholderLeftMargin;
@property (nonatomic, strong) UIFont *placeholderFont;
@end
