//
//  AppDelegate.h
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
#import "DrawerViewController.h"
#import "ViewController.h"
#import "ProblemListViewController.h"
#import "CodeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ICSDrawerController *drawer;
@property (strong, nonatomic) DrawerViewController *drawerViewController;
@property (strong, nonatomic) ViewController *mainViewController;

@property (strong, nonatomic) ViewController *problemListMain;
@property (strong, nonatomic) ViewController *pickOneMain;
@property (strong, nonatomic) ViewController *starMain;
@property (strong, nonatomic) ViewController *aboutMain;
@property (strong, nonatomic) ViewController *feedBackMain;

@property (strong, nonatomic) ProblemListViewController *problemListViewController;
@property (strong, nonatomic) NSArray *problemList;

@end

