//
//  BSLog.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#ifndef BSLog_h
#define BSLog_h

/**
 *  日志输出
 */
#ifdef DEBUG
#define BSLog(...) NSLog(__VA_ARGS__)
/**
 *  控制台输出指定颜色信息
 */
#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET_FG XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET XCODE_COLORS_ESCAPE @";"

#define BSLogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define BSLogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define BSLogGreen(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,238,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define BSLogCyan(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,255,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define BSLogPink(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg250,20,147;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define BSLogPurple(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg160,32,240;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define BSLogGray(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg207,207,207;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
/**
 *  日志输出函数
 */
#define BSLogFunc BSLog(@"%s", __func__)

#else
#define BSLog(...)
#define BSLogBlue(frmt, ...)
#define BSLogRed(frmt, ...)
#define BSLogGreen(frmt, ...)
#define BSLogGreen(frmt, ...)
#define BSLogCyan(frmt, ...)
#define BSLogPink(frmt, ...)
#define BSLogPink(frmt, ...)
#define BSLogPurple(frmt, ...)
#define BSLogGray(frmt, ...)
#define BSLogFunc(...)

#endif


#endif /* BSLog_h */
