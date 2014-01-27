//
//  RoundCorners.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-13.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundCorners : NSObject


+ (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

+ (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

@end
