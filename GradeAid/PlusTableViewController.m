//
//  PlusTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PlusTableViewController.h"

@interface PlusTableViewController ()

@end

@implementation PlusTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate plusTableViewController: self plusButtonSelectedIndex: indexPath.row + indexPath.section * 2];
}

@synthesize delegate = _delegate;

@end
