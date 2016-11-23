//
//  BSEssenceListModel.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceListModel.h"
#import "BSThemsModel.h"
#import "NSDate+Extension.h"


@implementation BSEssenceListModel
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id",
             @"small_image"  : @"image0",
             @"middle_image" : @"image1",
             @"large_image"  : @"image2"};
}


+ (NSDictionary *)objectClassInArray{
    return @{@"themes" : [BSThemsModel class]};
}

- (NSString *)create_time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (create.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else {
        return _create_time;
    }
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake(BSEssenceCellContentW, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : BSEssenceTextFont} context:nil].size.height;
        CGFloat pictureH = 0.f;
        CGFloat voiceH = 0.f;
        if (self.type == BSTopicTypePicture) {
            CGFloat pictureX = 0;
            CGFloat pictureY = BSEssenceCellTextY + textH;
            CGFloat pictureW = BSEssenceCellContentW;
            pictureH = BSEssenceCellContentW*self.height/self.width;
            _cellHeight = 3*BSEssenceCellMargin;
            if (pictureH>=BSEssenceCellPicBreakH && !self.isGifPic) {
                pictureH = BSEssenceCellPicMaxH;
                self.bigPic = YES;
            }
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        }else if (self.type == BSTopicTypeVoice || self.type == BSTopicTypeVideo){
            CGFloat voiceX = 0;
            CGFloat voiceY = BSEssenceCellTextY + textH;
            CGFloat voiceW = BSEssenceCellContentW;
            voiceH = BSEssenceCellContentW*self.height/self.width;
            _cellHeight = 3*BSEssenceCellMargin;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
        }
        _cellHeight += (BSEssenceCellTextY + textH + BSEssenceToolBarH + 3*BSEssenceCellMargin + pictureH + voiceH);
    }

    return _cellHeight;
}

- (BOOL)isGifPic{
    // 判断是否为gif
    NSString *extension = self.large_image.pathExtension;
    return [extension.lowercaseString isEqualToString:@"gif"];
}

@end
