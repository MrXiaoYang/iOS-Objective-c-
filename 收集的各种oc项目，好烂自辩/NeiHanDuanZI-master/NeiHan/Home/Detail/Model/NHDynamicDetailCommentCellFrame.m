//
//  NHDynamicDetailCommentCellFrame.m
//  NeiHan
//
//  Created by Charles on 16/9/3.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDynamicDetailCommentCellFrame.h"
#import "NHHomeServiceDataModel.h"
#import "NSAttributedString+Size.h"
#import "NSAttributedString+YYText.h"

@implementation NHDynamicDetailCommentCellFrame

- (void)setCommentModel:(NHHomeServiceDataElementComment *)commentModel {
    _commentModel = commentModel;

    // 头像
    CGFloat iconX = 20;
    CGFloat iconY = 15;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    self.iconImgF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 名字
    CGFloat nameH = 18;
    CGFloat nameX = CGRectGetMaxX(self.iconImgF) + 10;
    CGFloat nameY = 15;
    CGFloat nameW = kScreenWidth - nameX - 10 - 30;
    self.nameLF = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 分享
    CGFloat shareW = (kScreenWidth - 20 ) / 7.0;
    CGFloat shareX = kScreenWidth - shareW - 15;
    CGFloat shareY = nameY;
    CGFloat shareH = nameH;
    self.shareBtnF = CGRectMake(shareX, shareY, shareW, shareH);
    
    // 喜欢
    CGFloat likeBtnY = shareY;
    CGFloat likeBtnW = shareW;
    CGFloat likeBtnX = CGRectGetMinX(self.shareBtnF) - shareW - 15;
    CGFloat likeBtnH = shareH;
    self.likeCountBtnF = CGRectMake(likeBtnX, likeBtnY, likeBtnW, likeBtnH);
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLF) + 4;
    CGFloat timeW = kScreenWidth - timeX;
    CGFloat timeH = 15;
    self.timeLF = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 文本
    NSMutableString *mutableContent = [NSMutableString stringWithString:kValidStr(commentModel.text)];
    // 记录下所有的人的名字
    if (commentModel.reply_comments.count) {
        for (NHHomeServiceDataElementComment *replyComment in commentModel.reply_comments) {
            if (replyComment.text.length && replyComment.user_name.length) {
                NSString *replyName = [NSString stringWithFormat:@"//@%@：", replyComment.user_name];
                [mutableContent appendString:replyName];
                [mutableContent appendString:replyComment.text];
            }
        }
    }
    NSMutableAttributedString *attContent = [[NSMutableAttributedString alloc] initWithString:mutableContent];
    [attContent yy_setFont:kFont(16) range:NSMakeRange(0, attContent.length)];
    [attContent yy_setColor:kCommonBlackColor range:NSMakeRange(0, attContent.length)];
    
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(self.iconImgF) + 2;
    CGFloat contentW = kScreenWidth - nameX - 15;
    CGFloat contentH = [attContent heightWithConstrainedWidth:contentW];
    self.contentLF = CGRectMake(contentX, contentY, contentW, contentH);
    
    // 总高度
    self.cellHeight = CGRectGetMaxY(self.contentLF) + 10;
}
@end
