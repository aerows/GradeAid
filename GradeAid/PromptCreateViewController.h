//
//  PromptCreateViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptViewController.h"

@interface PromptCreateViewController : PromptViewController

- (void) revalidateInputs;
- (bool) validateInputs;

- (id) createObject;

@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;

@property (nonatomic, copy) DoneCreatingBlock doneCreatingBlock;
@property (nonatomic, copy) CancelPromptBlock cancelBlock;

@end
