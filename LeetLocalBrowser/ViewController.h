//
//  ViewController.h
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface ViewController: UINavigationController <ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property (weak, nonatomic) ICSDrawerController *drawer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBar;

@end

