//
//  FileTool.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "FileTool.h"

static FileTool *fileTool = Nil;

@implementation FileTool
{
    NSString *documentsPath;
    NSString *appDirectory;
    NSString *filePath;
    NSMutableArray *starList;
}

+ (FileTool *) getFileTool {
    if (fileTool == Nil) {
        fileTool = [[FileTool alloc]init];
    }
    return fileTool;
}

// MARK - Create Directory and File: "path: user//$//LeetCode//FilePath.txt"

- (NSString *) getDocumentsPath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    NSLog(@"docPath: %@", docPath);
    return docPath;
}

- (id) init {
    self = [super init];
    
    documentsPath =[self getDocumentsPath];
    appDirectory = [documentsPath stringByAppendingPathComponent:@"LeetCode"];
    filePath = [appDirectory stringByAppendingPathComponent:@"FilePath.txt"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath isDirectory:NO]) {
        NSError *error;
        starList =[[NSMutableArray alloc]initWithArray: [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error] componentsSeparatedByString:@","]];
        if ([[starList objectAtIndex:0] isEqualToString:@""]) {
            [starList removeObjectAtIndex:0];
        }
    } else {
        [self createDirectory];
        [self createFile];
        starList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void) createDirectory {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL res = [fm createDirectoryAtPath:appDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    res ? NSLog(@"createDirectory success") : NSLog(@"createDirectory failed");
}
- (void) createFile {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL res = [fm createFileAtPath:filePath contents:nil attributes:nil];
    res ? NSLog(@"createFile success") : NSLog(@"createFile failed");
}

// MARK - Operations for StarList

- (NSMutableArray *) getStarList {
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSString *problem in starList) {
        [result addObject:problem];
    }
    return result;
}

- (BOOL) checkStar: (NSString *)problemName {
    for (NSString *problem in starList) {
        if ([problem isEqualToString:problemName]) {
            return YES;
        }
    }
    return NO;
}

- (void) writeToStarList {
    NSString *problemList = [[NSString alloc]init];
    
    int length = (int)starList.count;
    for (int i = 0; i < length; ++i) {
        problemList = [problemList stringByAppendingString:[starList objectAtIndex:i]];
        if (i < length - 1) {
            problemList = [problemList stringByAppendingString:@","];
        }
    }
    NSLog(@"length: %d", length);
    NSLog(@"content: %@", problemList);
//    NSLog(@"last one: %@", [starList objectAtIndex:length - 1]);

    BOOL state = [problemList writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:Nil];
    state ? NSLog(@"writeToFile success") : NSLog(@"writeToFile failed");
}

- (void) addToStarList: (NSString *)problemName {
    [starList addObject:problemName];
    [self writeToStarList];
}

- (void) deleteFromStarList: (NSString *)problemName {
    int i = 0;
    for (NSString *problem in starList) {
        if ([problem isEqualToString:problemName]) {
            [starList removeObjectAtIndex:i];
            [self writeToStarList];
            break;
        }
        ++i;
    }
}

@end
