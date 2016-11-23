//
//  BSEssenceVoiceView.h
//  Budejie
//
//  Created by Jentle on 2016/11/23.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSEssenceListModel;

@interface BSEssenceVoiceView : UIView

@property (strong, nonatomic) BSEssenceListModel *essenceListModel;

/** 播放语言的信号 */
@property(strong, nonatomic) RACSubject *voicePlaySignal;


@end
