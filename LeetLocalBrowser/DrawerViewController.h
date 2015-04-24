//
//  DrawerViewController.h
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface DrawerViewController: UITableViewController <ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property (weak, nonatomic) ICSDrawerController *drawer;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (id)initWithColors: (NSArray *)colors;

@end
