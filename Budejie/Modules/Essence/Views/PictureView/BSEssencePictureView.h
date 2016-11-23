//
//  BSEssencePictureView.h
//  Budejie
//
//  Created by Jentle on 2016/11/21.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSEssenceListModel;

@interface BSEssencePictureView : UIView

/** 数据模型 */
@property(strong, nonatomic) BSEssenceListModel *essenceListModel;
/** 查看全图的信号 */
@property(strong, nonatomic) RACSubject *seeBigPicSignal;

@end
