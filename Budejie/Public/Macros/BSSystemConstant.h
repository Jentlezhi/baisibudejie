//
//  BSSystemConstant.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#ifndef BSSystemConstant_h
#define BSSystemConstant_h

#define BSMarigin BSALayoutH(20.0f)
#define BSViewOriginY 64.0f
#define BSViewHeight  (kScreenHeight - BSViewOriginY)
#define BSDividerHeight 0.4f

#define BSEssenceCellTextY     BSALayoutH(70)
#define BSEssenceToolBarH      BSALayoutV(80)
#define BSEssenceCellMargin    BSALayoutH(12)
#define BSEssenceCellContentW (kScreenWidth - 4*BSEssenceCellMargin)
#define BSEssenceCellPicBreakH   BSALayoutH(1000)
#define BSEssenceCellPicMaxH     BSALayoutH(500)
#define BSUserHeaderPlaceholder [[UIImage imageNamed:@"defaultUserIcon"] circleImageWithBorderWidth:BSALayoutH(2.f) borderColor:BSGlobalColor]

#define BSTagFontSize 15.f

#endif /* BSSystemConstant_h */
