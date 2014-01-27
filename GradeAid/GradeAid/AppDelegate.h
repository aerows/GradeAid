//
//  AppDelegate.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"

static NSString *const WillDismissViewControllerNotifification = @"WillDismissViewControllerNotifification";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) Session *session;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (AppDelegate*) sharedDelegate;

@end
