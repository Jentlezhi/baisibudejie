//
//  BSEssenceUIConstant.h
//  Budejie
//
//  Created by Jentle on 2016/11/24.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#ifndef BSEssenceUIConstant_h
#define BSEssenceUIConstant_h

#define BSTopCmtLineParagraphMargin 3.5f
#define BSTopCmtTopMargin BSALayoutV(35)
#define BSTopCmtHMargin BSALayoutH(8)


//评论详情
#define BSCommentViewKey  @"essenceTopCommentView"
#define BSCommentMarign   BSALayoutH(25)
#define BSCommentHeaderWH BSALayoutH(70)
#define BSCommentContentW (kScreenWidth-2*BSEssenceCellMargin-BSCommentHeaderWH)
#define BSCommnetContentFont [UIFont systemFontOfSize:15]
#define BSCmtContentTopMargin (BSCommentMarign + BSALayoutV(28) + (BSALayoutV(60)-BSALayoutV(28))*0.5 + BSEssenceCellMargin)

#endif /* BSEssenceUIConstant_h */
