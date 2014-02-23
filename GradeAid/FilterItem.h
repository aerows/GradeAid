//
//  FilterItem.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course+Create.h"
#import "Student+Create.h"

#import "PromptViewController.h"
#import "PromptCreateViewController.h"

static NSString *const FilterItemWasCreatedNotification = @"FilterItemWasCreatedNotification";

@protocol FilterItemDelegate <NSObject>

- (void) filterItemDidUpdate: (id) filterItem;

@end

typedef void(^CreateNewBlock)();
typedef void(^EditObjectBlock)(id);

@interface FilterItem : NSObject
{
    NSMutableArray *_selectableItems;
}

@property (nonatomic, strong) NSArray *selectableItems;
@property (nonatomic, strong) id selectedItem;
@property (nonatomic, strong) id<FilterItemDelegate> delegate;

@property (nonatomic, copy) CreateNewBlock createNewBlock;
@property (nonatomic, copy) EditObjectBlock editObjectBlock;

@property (nonatomic) bool editable;

- (NSArray*) filterCourses: (NSArray*) courses;
- (NSArray*) filterStudents: (NSArray*) students;

- (NSPredicate*) coursePredicate;
- (NSPredicate*) studentPredicate;

- (void) reloadItems;

- (NSInteger) indexForInsertSelectableItem: (id) item;
- (void) deleteItemAtIndex: (NSInteger) index;

- (UIImage*) imageForItem: (id) item;
- (NSString*) titleForItem: (id) item;

- (UIImage*) imageForSelectedItem;
- (NSString*) titleForSelectedItem;

- (PromptCreateViewController*) newObjectPromptViewController;

@end
