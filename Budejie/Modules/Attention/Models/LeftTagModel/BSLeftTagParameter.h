//
//  BSLeftTagParameter.h
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSLeftTagParameter : NSObject

+ (instancetype)leftTagParameter;

/** category */
@property(copy, nonatomic) NSString *a;
/** subscribe */
@property(copy, nonatomic) NSString *c;

@end
