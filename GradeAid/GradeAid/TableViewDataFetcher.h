//
//  TableViewDataFetcher.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-17.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewDataFetcherDelegate <NSObject>

- (UITableViewCell*) tableView:(UITableView *)tableView cellWithObject: (id) object atIndexPath:(NSIndexPath *)indexPath;

@end

@interface TableViewDataFetcher : NSObject<UITableViewDataSource, NSFetchedResultsControllerDelegate>

- (id) initWithFetchController: (NSFetchedResultsController*) fetchedResultsController tableView: (UITableView*) tableView delegate: (id<TableViewDataFetcherDelegate>) delegate;

@property (nonatomic, strong) id<TableViewDataFetcherDelegate> delegate;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UITableView *tableView;

@end
