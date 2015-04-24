//
//  FileTool.h
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject

- (BOOL) checkStar: (NSString *)problemName;
- (void) addToStarList: (NSString *)problemName;
- (void) deleteFromStarList: (NSString *)problemName;

- (NSMutableArray *) getStarList;
+ (FileTool *) getFileTool;

@end
