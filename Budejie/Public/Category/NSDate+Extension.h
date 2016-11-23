//
//  NSDate+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/19.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 * 比较fromDate和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)fromDate;
/**
 * 是否为今年
 */
- (BOOL)isThisYear;
/**
 * 是否为今天
 */
- (BOOL)isToday;
/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

@end
