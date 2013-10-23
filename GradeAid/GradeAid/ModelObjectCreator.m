//
//  ModelObjectCreater.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-05.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "ModelObjectCreator.h"
#import "UIStoryboard+mainStoryboard.h"

@interface ModelObjectCreator ()

- (NSArray*) attributeVerifyers;
- (UIImage*) defaultImage;

@end

@implementation ModelObjectCreator
{

}

- (id) init
{
    if (self = [super init])
    {

    }
    return self;
}

- (void) show
{
}

- (void) attributeVerifyerDidUpdate:(id)sender
{
    
}

#pragma - Abstract ModelObjectCreator Methods

- (NSArray*) attributeVerifyers
{
    return @[];
}

- (UIImage*) defaultImage
{
    return nil;
}

#pragma - Getters and Setters

@synthesize delegate = _delegate;

@end
