//
//  ViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong, nonatomic) UIBarButtonItem *menuButton;
@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed: 0.0f / 255.0f green: 134.0f / 255.0f blue: 203.0f / 255.0f alpha: 1.0f];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

// MARK - Configuring the view’s layout behavior

- (BOOL) prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// MARK - ICSDrawerControllerPresenting

- (void) drawerControllerWillOpen:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = NO;
}
- (void) drawerControllerDidClose:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = YES;
}

// MARK - Open drawer action

- (void) openDrawer: (id)sender {
    [self.drawer open];
}

@end
