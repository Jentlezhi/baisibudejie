//
//  BSTagTextField.h
//  Budejie
//
//  Created by Jentle on 2016/12/1.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTagTextField : UITextField

@property (copy, nonatomic)void(^backwardClick)();

@end
