//
//  BSCommentModel.m
//  Budejie
//
//  Created by Jentle on 2016/11/24.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSCommentModel.h"

@implementation BSCommentModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}
//{
//   CGFloat _cellHeight;
//}
//
//- (CGFloat)cellHeight{
//    if (!_cellHeight) {
//        CGSize maxSize = CGSizeMake(BSCommentContentW, MAXFLOAT);
//        CGFloat textH = [NSString sizeForContent:self.content font:BSCommnetContentFont size:maxSize].height;
//        _cellHeight = BSCmtContentTopMargin + textH + BSEssenceCellMargin;
//    }
//    return _cellHeight;
//}

@end
