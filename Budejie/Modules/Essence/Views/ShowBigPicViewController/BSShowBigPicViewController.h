//
//  BSShowBigPicViewController.h
//  Budejie
//
//  Created by Jentle on 2016/11/22.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseViewController.h"

@class BSEssenceListModel;

@interface BSShowBigPicViewController : BSBaseViewController

@property(strong, nonatomic)BSEssenceListModel *essenceListModel;

+ (instancetype)showBigPicViewController;

@end
