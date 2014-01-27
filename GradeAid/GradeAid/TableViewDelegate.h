//
//  TableViewDelegate.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-27.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewDelegate <NSObject>

- (void) tableViewDidUpdate: (UITableView*) tableView;

@end