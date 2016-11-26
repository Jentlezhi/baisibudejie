//
//  BSEnum.h
//  Budejie
//
//  Created by Jentle on 2016/11/21.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#ifndef BSEnum_h
#define BSEnum_h

typedef enum {
    BSTopicTypeAll = 1,
    BSTopicTypePicture = 10,
    BSTopicTypeJoke = 29,
    BSTopicTypeVoice = 31,
    BSTopicTypeVideo = 41
} BSTopicType;

typedef enum {
    BSRequestTypeRefresh = 0,
    BSRequestTypeLoadMore
} BSRequestType;


#endif /* BSEnum_h */
