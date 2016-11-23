//
//  BSTestViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/17.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTestViewController.h"

@interface BSTestViewController ()

@end

@implementation BSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setIndexString:(NSString *)indexString{
    _indexString = indexString;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 200, 21);
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.view.center;
    label.text = indexString;
    [self.view addSubview:label];
}

@end
