//
//  ProblemStruct.h
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProblemStruct : NSObject

@property (strong, nonatomic) NSString *problemName;
@property (strong, nonatomic) NSString *problemIcon;
@property (strong, nonatomic) NSString *problemDetails;

- (id) initProblem: (NSString *)name : (NSString *)icon : (NSString *)details;

@end
