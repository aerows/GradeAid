//
//  PromptViewController2.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBlockTableView.h"

#define errorColor ([UIColor colorWithRed:1.0 green:0.4 blue:0.4 alpha:0.5])

@protocol PromptEnviorment <NSObject>

- (void) pushPromptViewController: (id) promptViewController animated: (bool) animated;
- (void) dismissPromptViewController: (id) promptViewController animated: (bool) animated;

@end

@protocol PromptDelegate <NSObject>

- (void) promptViewController: (id) promptViewController didCreatedObject: (id) object;
- (void) promptViewController: (id) promptViewController didSelectObject: (id) object;
- (void) promptViewController: (id) promptViewController didSelectObjects: (NSArray*) object;

@end

@interface PromptViewController : UIViewController

typedef void(^DoneCreatingBlock)(PromptViewController *, id object);
typedef void(^DoneSelectingBlock)(PromptViewController *, id object);
typedef void(^CancelPromptBlock)(PromptViewController *);

- (void) dismiss;

@property (nonatomic, strong) id object;
@property (nonatomic, assign) id<PromptDelegate> delegate;
@property (nonatomic, strong) id<PromptEnviorment> enviorment;
@property (nonatomic, strong) PromptViewController *nextPromptViewController;
@property (nonatomic, strong) PromptViewController *previousPromptViewController;

@end
