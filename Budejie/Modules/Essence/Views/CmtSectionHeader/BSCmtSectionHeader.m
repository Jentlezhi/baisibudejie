//
//  BSCmtSectionHeader.m
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSCmtSectionHeader.h"

@interface BSCmtSectionHeader()

/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation BSCmtSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = BSGlobalColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = BSGrayColor(67);
        label.font = [UIFont systemFontOfSize:BSALayoutH(28.0f)];
        label.width = 200;
        label.x = BSEssenceCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setSectionTitle:(NSString *)sectionTitle{
    _sectionTitle = sectionTitle;
    self.label.text = sectionTitle;
}

+ (instancetype)cmtSectionHeaderWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cectionHeaderID";
    BSCmtSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[BSCmtSectionHeader alloc] initWithReuseIdentifier:ID];
    }
    return header;
}




@end
