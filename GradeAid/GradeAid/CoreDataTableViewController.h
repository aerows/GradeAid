//
//  CoreDataTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-09.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath;

@end
