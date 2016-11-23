//
//  BSTagParameter.h
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTagParameter : NSObject

/** tag_recommend */
@property(copy, nonatomic) NSString *a;
/** sub */
@property(copy, nonatomic) NSString *action;
/** topic */
@property(copy, nonatomic) NSString *c;

+ (instancetype)tagParameter;


@end
