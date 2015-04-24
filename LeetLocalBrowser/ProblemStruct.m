//
//  ProblemStruct.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "ProblemStruct.h"

@implementation ProblemStruct

@synthesize problemName;
@synthesize problemIcon;
@synthesize problemDetails;

- (id) initProblem: (NSString *)name : (NSString *)icon : (NSString *)details {
    self = [super init];
    
    problemName = name;
    problemIcon = icon;
    problemDetails = details;
    
    return self;
}

@end
