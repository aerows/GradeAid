//
//  SellectionVerifyer.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-06.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellPresentable.h"

@protocol SellectionVerifyerView <NSObject>

- (void) updateView;

@end

@protocol SellectionVerifyerDelegate <NSObject>

- (void) updateSellectionVerifyerDelegate;

@end

@interface SellectionVerifyer : NSObject<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate>

- (id) initWithFetchRequest: (NSFetchRequest*) fetchRequest managedObjectContext: (NSManagedObjectContext*) managedObjectContext;

- (id) initWithArray: (NSArray*) objects;

@property (nonatomic, strong) NSString* attributeTitle;
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) id<CellPresentable> selectedObject;

@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, strong) id value;
@property (nonatomic, readonly, getter = isVerified) bool verified;

@property (nonatomic, strong) id<SellectionVerifyerView> view;
@property (nonatomic, strong) id<SellectionVerifyerDelegate> delegate;

@property (nonatomic, copy) void(^setupTableViewCell)(UITableViewCell* tableViewCell, NSManagedObject* object);

@end
