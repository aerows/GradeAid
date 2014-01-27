//
//  NotesViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enrollment+Create.h"

@interface NotesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
{
    IBOutlet UITextView *_textView;
    IBOutlet UITableView *_notesTableView;
    IBOutlet UILabel *_noAquirementDescriptionsLabel;
    IBOutlet UIView *_textViewContainer;
}

// State
@property (nonatomic) bool inEditMode;

// Model
@property (nonatomic, strong) Enrollment *enrollment;

// View
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITableView *notesTableView;
@property (nonatomic, strong) UILabel *noAquirementDescriptionsLabel;



@end
