//
//  NotesViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "NotesViewController.h"

// Global
#import "AppDelegate.h"
#import "RoundCorners.h"

// Model
#import "Note.h"

// View
#import "NotesTableViewCell.h"


@interface NotesViewController ()

@end

@implementation NotesViewController
{
    NSFetchedResultsController *_fetchedNotesController;
}

#pragma mark - Constructor Methods

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        
    }
    return self;
}

- (void) reloadData
{
    [self setupFetchResultsControllers];
    [_notesTableView reloadData];
}

- (void) viewDidLoad
{
    _textViewContainer.layer.cornerRadius = 5.f;
    _textViewContainer.layer.masksToBounds = YES;
    
    CGFloat cornerRadius = 5.f;
    _textView.backgroundColor = UIColor.clearColor;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(_textView.bounds, 0, 0);

    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
    CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));

    layer.path = pathRef;
    CFRelease(pathRef);
    layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;

    [_textView.layer insertSublayer:layer atIndex:0];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self reloadData];
    [_textView setText: [self stringFromStudent: _enrollment.student]];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self putString: _textView.text forStudent: _enrollment.student];
    
}

- (void) setupFetchResultsControllers
{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Note"];
//    //request.predicate = [NSPredicate predicateWithFormat: @"(SELF IN %@. %@)", _enrollment];
//    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"caption" ascending: YES]]];
//    
//    _fetchedNotesController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
//                                                                       managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
//                                                                         sectionNameKeyPath: nil
//                                                                                  cacheName:nil];
//    _fetchedNotesController.delegate = self;
//    [_fetchedNotesController performFetch: nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _fetchedNotesController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_fetchedNotesController.sections.count)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedNotesController sections] objectAtIndex: section];
        return [sectionInfo numberOfObjects];
    }
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [RoundCorners tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Note *note = [_fetchedNotesController objectAtIndexPath: indexPath];
    
    NotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NotesTableViewCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Note *note = [_fetchedAquirementController objectAtIndexPath: indexPath];
//    return [Note heightForCellWithNote: note];
    return 45.f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotesTableViewCell *notesCell = (NotesTableViewCell*) cell;
    //[aquirementCell updateLayout];
    [RoundCorners tableView: _notesTableView willDisplayCell: cell forRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([[_fetchedNotesController sections] count])
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedNotesController sections] objectAtIndex:section];
        return [sectionInfo name];
    }
    return nil;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath: indexPath animated: YES];
}

#pragma mark - FetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [_notesTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [_notesTableView insertSections:[NSIndexSet indexSetWithIndex: sectionIndex]
                                withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_notesTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [_notesTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                        withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_notesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                        withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[_notesTableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [_notesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                        withRowAnimation:UITableViewRowAnimationFade];
            [_notesTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                        withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath
{
    //[cell setAquirement: [_fetchedAquirementController objectAtIndexPath: indexPath]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [_notesTableView endUpdates];
}

- (NSString*) stringFromStudent: (Student*) student
{
    if (student == nil) return @"";
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey: student.fullName];
    return (string) ? string : @"";
}

- (void) putString: (NSString*) string forStudent: (Student*) student
{
    if (!student) return;
    [[NSUserDefaults standardUserDefaults] setObject: string forKey:  student.fullName];
}

- (void) setEnrollment:(Enrollment *)enrollment
{
    _enrollment = enrollment;
    [_textView setText: [self stringFromStudent: _enrollment.student]];
}

#pragma mark - Getters and Setters

// State
@synthesize inEditMode = _inEditMode;

// Model

@synthesize enrollment = _enrollment;

// View
@synthesize notesTableView = _notesTableView;
@synthesize noAquirementDescriptionsLabel = _noAquirementDescriptionsLabel;
@synthesize textView = _textView;
@end
