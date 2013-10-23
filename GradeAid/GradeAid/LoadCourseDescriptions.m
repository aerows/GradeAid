//
//  LoadCourseDescriptions.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "LoadCourseDescriptions.h"
#import "SBJson.h"
#import "Subject+Create.h"
#import "AppDelegate.h"

@implementation LoadCourseDescriptions



+ (void) loadCourseDescriptions
{
    NSArray *subjectsTitles = @[@"musik"];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    Subject *music = nil;
    
    for (NSString *subject in subjectsTitles)
    {
        
        NSString * path = [[NSBundle mainBundle] pathForResource: subject ofType: @"json"];
        NSData *data = [NSData dataWithContentsOfFile: path];
        
        NSDictionary *subjectDict = [parser objectWithData: data];

        music = [Subject subjectWithDict: subjectDict inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    }
    
    NSLog(@"%@",music);
}






@end
