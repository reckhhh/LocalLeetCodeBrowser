//
//  ProblemListViewController.h
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *problemListTable;

@end
