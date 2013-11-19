//
//  SettingsViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UIImageView *teacherPictureView;
    IBOutlet UILabel     *teacherNameLabel;
    
    IBOutlet UIButton *logoutButton;
    
    IBOutlet UILabel *myCourseEditionsLabel;
    IBOutlet UIButton *addNewCourseEditionButton;
    IBOutlet UICollectionView *courseEditionsCollectionView;
    
    IBOutlet UILabel *mySchoolsLabel;
    IBOutlet UIButton *addNewSchoolButton;
    IBOutlet UICollectionView *schoolCollectionView;
    
    IBOutlet UILabel *mySchoolClassesLabel;
    IBOutlet UIButton *addNewSchoolClassButton;
    IBOutlet UICollectionView *schoolClassCollectionView;

    IBOutlet UILabel *myStudentsLabel;
    IBOutlet UIButton *addNewStudentButton;
    IBOutlet UICollectionView *studentCollectionView;
    
    NSManagedObjectContext *managedObjectContext;
}

- (IBAction) logout: (id)sender;

- (IBAction) addCourseEdition:(id)sender;
- (IBAction) addSchoolClass: (id)sender;
- (IBAction) addStudent:(id)sender;


@end
