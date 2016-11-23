//
//  BSJokeCell.h
//  Budejie
//
//  Created by Jentle on 2016/11/18.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseCell.h"

@interface BSJokeCell : BSBaseCell

+ (instancetype)jokeCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
