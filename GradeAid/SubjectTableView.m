//
//  SubjectTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-27.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SubjectTableView.h"
#import "SubjectObjective+Create.h"

#import "TextTableViewCell.h"
#import "SubjectiveObjectiveHeaderTableViewCell.h"
#import "SubjectObjectiveTableViewCell.h"

#import "AppDelegate.h"
#import "RoundCorners.h"

static NSInteger const SubjectNameRow               = 0;
static NSInteger const SubjectIntroCaptionRow       = 1;
static NSInteger const SubjectObjectiveCaptionRow   = 2;

static NSInteger const SubjectHeaderSection         = 0;
static NSInteger const SubjectObjectivesSection     = 1;

@interface SubjectTableView ()

@end

@implementation SubjectTableView
{
    NSFetchedResultsController *_fetchedCentralContentController;
    
    bool subjectIntroCaptionRowExpanded;
    bool subjectObjectiveCaptionRowExpanded;
}

- (void) reloadData
{
//[self setupFetchResultsControllers];
    self.delegate = self;
    self.dataSource = self;
    [super reloadData];
    [_tableViewDelegate tableViewDidUpdate: self];
}

- (void) endUpdates
{
    [super endUpdates];
    [_tableViewDelegate tableViewDidUpdate: self];
}

- (CGFloat) height
{
    CGFloat height = 0.f;
    for (int i = 0; i < [self numberOfSectionsInTableView: self]; i++) {
        for (int j = 0; j < [self tableView: self numberOfRowsInSection: i]; j++) {
            height += [self tableView:self heightForRowAtIndexPath: [NSIndexPath indexPathForRow: j inSection:i]];
        }
    }
    return height;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case SubjectHeaderSection: return 3;
        case SubjectObjectivesSection:
        {
            return _subject.objectives.count;
        }
        default: return 0;
    }
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [RoundCorners tableView: self willDisplayCell: cell forRowAtIndexPath:indexPath];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case SubjectHeaderSection:
        {
            switch (indexPath.row)
            {
                case SubjectNameRow: return 55.f;
                case SubjectIntroCaptionRow: return [TextTableViewCell heightForText: _subject.introCaption expanded: subjectIntroCaptionRowExpanded];
                    
                case SubjectObjectiveCaptionRow: return [TextTableViewCell heightForText: _subject.objectiveCaption expanded: subjectObjectiveCaptionRowExpanded];
            }
        }
        case SubjectObjectivesSection: return 40.f;
        default: return 0.f;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SubjectHeaderSection)
    {
        switch (indexPath.row)
        {
            case SubjectNameRow:
            {
                static NSString *CellIdentifier = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

                [cell.detailTextLabel setText: @"Ämne"];
                [cell.textLabel setText: _subject.name];
//                if (YES)
//                {
//                    [cell.expandLabel setText: @"Dölj detaljer"];
//                }
//                else
//                {
//                    [cell.expandLabel setText: @"Visa detaljer"];
//                }
                return cell;
            }
            case SubjectIntroCaptionRow:
            {
                TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TextTableViewCellIdentifier];
                [cell setText: [_subject introCaption] expanded: subjectIntroCaptionRowExpanded];
                [cell setTitle: @""];
                return cell;
            }
            case SubjectObjectiveCaptionRow:
            {
                TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TextTableViewCellIdentifier];
                [cell setText: [_subject objectiveCaption] expanded: subjectObjectiveCaptionRowExpanded];
                [cell setTitle: @"Ämnets syfte"];
                return cell;
            }
        }
    }
    else if (indexPath.section == SubjectObjectivesSection)
    {
        if (indexPath.row == 0)
        {
            SubjectiveObjectiveHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SubjectiveObjectiveHeaderTableViewCellIdentifier];
            cell.title = _subject.objectiveItemHeader;
            return cell;
        }
        else
        {
            NSArray *subjectObjectives = _subject.sortedObjectivesItems;
            SubjectObjectiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SubjectObjectiveTableViewCellIdentifier];
            [cell setObjective: [subjectObjectives objectAtIndex: indexPath.row - 1]];
            return cell;
        }
    }
    return nil;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if (indexPath.section == SubjectHeaderSection)
    {
        switch (indexPath.row)
        {
            case SubjectNameRow: return;
            case SubjectIntroCaptionRow: subjectIntroCaptionRowExpanded ^= YES; break;
            case SubjectObjectiveCaptionRow: subjectObjectiveCaptionRowExpanded ^= YES; break;
            default: return;
        }
        [self beginUpdates];
        [self reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationFade];
        [self endUpdates];
    }
}



#pragma mark - FetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    
//    NSInteger sectionWithOffset = sectionIndex + CourseAquirementsSectionOffset;
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionWithOffset]
//                          withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionWithOffset]
//                          withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
//    
//    UITableView *tableView = self.tableView;
//    NSIndexPath *indexPathWithOffset = [NSIndexPath indexPathForRow: indexPath.row
//                                                          inSection: indexPath.section + CourseAquirementsSectionOffset];
//    NSIndexPath *newIndexPathWithOffset = [NSIndexPath indexPathForRow: newIndexPath.row
//                                                             inSection: newIndexPath.section + CourseAquirementsSectionOffset];
//    
//    
//    switch(type) {
//            
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPathWithOffset]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathWithOffset]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
//            
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPathWithOffset]
//                    atIndexPath:indexPath];
//            break;
//            
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathWithOffset]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPathWithOffset]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
}

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath
{
//    //    NSIndexPath *indexPathWithOffset = [NSIndexPath indexPathForRow: indexPath.row inSection: indexPath.section - CourseAquirementsSectionOffset];
//    AquirementCell *aquirementCell = (AquirementCell*) cell;
//    [aquirementCell setAquirement: nil];
//    [aquirementCell setAquirement: [_fetchedResultsController objectAtIndexPath: indexPath]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self endUpdates];
}

@synthesize subject = _subject;
@synthesize tableViewDelegate = _tableViewDelegate;

@end
