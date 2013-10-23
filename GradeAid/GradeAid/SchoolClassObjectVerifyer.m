//
//  SchoolClassObjectVerifyer.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClassObjectVerifyer.h"
#import "SchoolClass+Create.h"
#import "AppDelegate.h"

@implementation SchoolClassObjectVerifyer
{
    AttributeVerifyer *nameVerifyer;
    AttributeVerifyer *yearVerifyer;
    
    School *school;
}

- (id) initWithSchool: (School*) school
{
    if (self = [super init])
    {
        [self setDefaultImage: [SchoolClass defaultImage]];
        [self setCreateObjectTitle: @"Skapa ny klass"];
        nameVerifyer = [[AttributeVerifyer alloc] initWithAttributeName: @"Klassens namn"
                                                        stringFormatter: [StringFormatter nameFormatter]
                                                         stringQriteria: @[[StringQriterium notEmtpyQriterium]]];
        yearVerifyer = [[AttributeVerifyer alloc] initWithAttributeName: @"År"
                                                        stringFormatter: [StringFormatter nameFormatter]
                                                         stringQriteria: @[[StringQriterium notEmtpyQriterium]]];
        [self addAttributeVerifyers: @[nameVerifyer, yearVerifyer]];
    }
    return self;
}

//- (id) _saveObject
//{
//    return [SchoolClass createSchoolWithName: nameVerifyer.attributeValue image: self.defaultImage InManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
//}

@end
