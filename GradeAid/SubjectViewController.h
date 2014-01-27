//
//  SubjectViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectTableView.h"
#import "Course+Create.h"

@interface SubjectViewController : UIViewController<TableViewDelegate>
{
    IBOutlet SubjectTableView *_subjectTableView;
//    IBOutlet UILabel *_studentsLabel;
//    IBOutlet UIButton *_addStudentsButton;
//    IBOutlet UILabel *noStudentsLabel;
}

// Model
@property (nonatomic, strong) Course *course;

// View
@property (nonatomic, strong) SubjectTableView *subjectTableView;;
//@property (nonatomic, strong) UILabel *studensLabel;
//@property (nonatomic, strong) UIButton *addStudentsButton;
//@property (nonatomic, strong) UILabel *noStudentsLabel;

@end