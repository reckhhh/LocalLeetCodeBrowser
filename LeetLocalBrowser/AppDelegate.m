//
//  AppDelegate.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "AppDelegate.h"
#import "ICSDrawerController.h"
#import "ViewController.h"
#import "DrawerViewController.h"
#import "ProblemListViewController.h"
#import "FileTool.h"
#import "ProblemStruct.h"
#import "LaunchImageTransition.h"
#import "CodeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // MARK - create a fileTool
    FileTool *fileTool;
    fileTool = [FileTool getFileTool];
    
    // MARK - set background color
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // MARK - init problemList
    self.problemList = [[NSArray alloc] initWithObjects:
                        //1-10
                        [[ProblemStruct alloc]initProblem:@"Two Sum" :@"level_2.png" :@"array, sort, hash"],
                        [[ProblemStruct alloc]initProblem:@"Median of Two Sorted Arrays" :@"level_5.png" :@"array, binary search"],
                        [[ProblemStruct alloc]initProblem:@"Longest Substring Without Repeating Characters" :@"level_3.png" :@"hash"],
                        [[ProblemStruct alloc]initProblem:@"Add Two Numbers" :@"level_3.png" :@"linked list"],
                        [[ProblemStruct alloc]initProblem:@"Longest Palindromic Substring" :@"level_4.png" :@"string"],
                        [[ProblemStruct alloc]initProblem:@"ZigZag Conversion" :@"level_3.png" :@"string"],
                        [[ProblemStruct alloc]initProblem:@"Reverse Integer" :@"level_2.png" :@"math"],
                        [[ProblemStruct alloc]initProblem:@"String to Integer" :@"level_2.png" :@"string, math"],
                        [[ProblemStruct alloc]initProblem:@"Palindrome Number" :@"level_2.png" :@"math"],
                        [[ProblemStruct alloc]initProblem:@"Regular Expression Matching" :@"level_5.png" :@"string, recursion"],
                        //11-20
                        [[ProblemStruct alloc]initProblem:@"Container With Most Water" :@"level_3.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Integer to Roman" :@"level_3.png" :@"math"],
                        [[ProblemStruct alloc]initProblem:@"Roman to Integer" :@"level_2.png" :@"math"],
                        [[ProblemStruct alloc]initProblem:@"Longest Common Prefix" :@"level_2.png" :@"string"],
                        [[ProblemStruct alloc]initProblem:@"3Sum" :@"level_3.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"3Sum Closest" :@"level_3.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"4Sum" :@"level_3.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Letter Combinations of a Phone Number" :@"level_3.png" :@"DFS"],
                        [[ProblemStruct alloc]initProblem:@"Remove Nth Node From End of List" :@"level_2.png" :@"linked list"],
                        [[ProblemStruct alloc]initProblem:@"Longest Common Prefix" :@"level_1.png" :@"string"],
                        //21-30
                        [[ProblemStruct alloc]initProblem:@"Valid Parentheses" :@"level_2.png" :@"stack"],
                        [[ProblemStruct alloc]initProblem:@"Generate Parentheses" :@"level_4.png" :@"string, DFS"],
                        [[ProblemStruct alloc]initProblem:@"Merge k Sorted Lists" :@"level_3.png" :@"linked list, heap, merge"],
                        [[ProblemStruct alloc]initProblem:@"Swap Nodes in Pairs" :@"level_2.png" :@"linked list"],
                        [[ProblemStruct alloc]initProblem:@"Reverse Nodes in k-Group" :@"level_4.png" :@"linked list"],
                        [[ProblemStruct alloc]initProblem:@"Remove Duplicates from Sorted Array" :@"level_1.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Remove Element" :@"level_1.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Implement strStr()" :@"level_4.png" :@"string, KMP, hash"],
                        [[ProblemStruct alloc]initProblem:@"Divide Two Integers" :@"level_4.png" :@"binary search"],
                        [[ProblemStruct alloc]initProblem:@"Substring with Concatenation of All Words" :@"level_3.png" :@"string"],
                        //31-40
                        [[ProblemStruct alloc]initProblem:@"Next Permutation" :@"level_5.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Longest Valid Parentheses" :@"level_4.png" :@"string, DP"],
                        [[ProblemStruct alloc]initProblem:@"Search in Rotated Sorted Array" :@"level_4.png" :@"binary search"],
                        [[ProblemStruct alloc]initProblem:@"Search for a Range" :@"level_4.png" :@"binary search"],
                        [[ProblemStruct alloc]initProblem:@"Search Insert Position" :@"level_2.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Valid Sudoku" :@"level_2.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Sudoku Solver" :@"level_4.png" :@"recursive, DFS"],
                        [[ProblemStruct alloc]initProblem:@"Count and Say" :@"level_2.png" :@"two pointer"],
                        [[ProblemStruct alloc]initProblem:@"Combination Sum" :@"level_3.png" :@"combination"],
                        [[ProblemStruct alloc]initProblem:@"Combination Sum II" :@"level_4.png" :@"combination"],
                        //41-50
                        [[ProblemStruct alloc]initProblem:@"First Missing Positive" :@"level_5.png" :@"math"],
                        [[ProblemStruct alloc]initProblem:@"Trapping Rain Water" :@"level_5.png" :@""],
                        [[ProblemStruct alloc]initProblem:@"Multiply Strings" :@"level_4.png" :@"math"],
                        [[ProblemStruct alloc]initProblem:@"Wildcard Matching" :@"level_5.png" :@"DP"],
                        [[ProblemStruct alloc]initProblem:@"Jump Game II" :@"level_4.png" :@"array"],
                        [[ProblemStruct alloc]initProblem:@"Permutations" :@"level_3.png" :@"DFS"],
                        [[ProblemStruct alloc]initProblem:@"Permutations II" :@"level_4.png" :@"DFS"],
                        [[ProblemStruct alloc]initProblem:@"Rotate Image" :@"level_4.png" :@"math, recursive"],
                        [[ProblemStruct alloc]initProblem:@"Anagrams" :@"level_3.png" :@"hash"],
                        [[ProblemStruct alloc]initProblem:@"Pow(x, n)" :@"level_3.png" :@"binary"],
                        nil];
    
    // MARK - init drawer: left(drawerViewController) + center(mainViewController)
    
    // left
    self.drawerViewController = [[DrawerViewController alloc] init];
    // center
    self.problemListMain = [[ViewController alloc] init];
    self.mainViewController = self.problemListMain;
    self.mainViewController.view.backgroundColor = [UIColor grayColor];
    // drawer = left + center
    self.drawer = [[ICSDrawerController alloc] initWithLeftViewController:self.drawerViewController centerViewController:self.mainViewController];
    
    // MARK - push problems to problemListMain
    
    self.problemListViewController = [[ProblemListViewController alloc]init];
    self.problemListViewController.title = @"Problems";
    
    [self.problemListMain pushViewController:self.problemListViewController animated:YES];
    
    // MARK - init window by drawer
    
    self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:self.drawer animation:UIModalTransitionStyleCrossDissolve delay:0.0];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
