//
//  BSTagTextField.m
//  Budejie
//
//  Created by Jentle on 2016/12/1.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTagTextField.h"

@implementation BSTagTextField

- (void)deleteBackward{
    if (![self hasText]) {
        !self.backwardClick?:self.backwardClick();
    }else{
        [super deleteBackward];
    }
    
}
@end
