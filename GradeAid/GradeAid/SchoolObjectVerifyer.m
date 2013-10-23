//
//  SchoolObjectVerifyer.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-08.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolObjectVerifyer.h"
#import "School.h"
#import "AppDelegate.h"

@implementation SchoolObjectVerifyer
{
    AttributeVerifyer *nameVerifyer;
}

- (id) init
{
    if (self = [super init])
    {
        [self setDefaultImage: [School defaultImage]];
        [self setCreateObjectTitle: @"Skapa ny skola"];
        nameVerifyer = [[AttributeVerifyer alloc] initWithAttributeName: @"Skolans namn"
                                                        stringFormatter: [StringFormatter nameFormatter]
                                                         stringQriteria: @[[StringQriterium notEmtpyQriterium]]];
        [self addAttributeVerifyer: nameVerifyer];
    }
    return self;
}

- (id) _saveObject
{
    return [School createSchoolWithName: nameVerifyer.attributeValue image: self.defaultImage InManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
}

@end
