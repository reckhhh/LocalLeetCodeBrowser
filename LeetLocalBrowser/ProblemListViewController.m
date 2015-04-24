//
//  ProblemListViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "ProblemListViewController.h"
#import "AppDelegate.h"
#import "ProblemStruct.h"

@interface ProblemListViewController ()
@property (strong, nonatomic) NSArray *problemList;
@property (strong, nonatomic) NSMutableArray *filteredProblemList;
@end

@implementation ProblemListViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Set title color
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    // Add menu button
    UIImage *menuIcon = [UIImage imageNamed:@"icon_menu.png"];
    CGRect frameMenuIcon = CGRectMake(0, 0, menuIcon.size.width, menuIcon.size.height);
    
    UIButton *customizedButton = [[UIButton alloc]initWithFrame:frameMenuIcon];
    [customizedButton setBackgroundImage:menuIcon forState:UIControlStateNormal];
    [customizedButton addTarget:self action:@selector(menuClicker:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:customizedButton];
    [self.navigationItem setLeftBarButtonItem:menuButton];
    
    // MARK - Init problemList and filteredProblemList

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.problemList = [[NSArray alloc]initWithArray: delegate.problemList];
    self.filteredProblemList = [[NSMutableArray alloc]initWithArray: self.problemList];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) menuClicker: (id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}

- (void) dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"problem_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"problem_cell"];
    }
    
    ProblemStruct *problem;
    if (self.filteredProblemList != Nil && self.filteredProblemList.count != 0) {
        problem = [self.filteredProblemList objectAtIndex: indexPath.row];
    }
    
    // Add levelIcon of problem
    UIImage *sourceIcon = [UIImage imageNamed: problem.problemIcon];
    [cell.imageView setContentMode: UIViewContentModeCenter];
    [cell.imageView setImage: sourceIcon];
    
    // Add description of problem
    cell.textLabel.text = problem.problemName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text = problem.problemDetails;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredProblemList count];
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissKeyboard];

    ProblemStruct *problem = [self.filteredProblemList objectAtIndex:indexPath.row];
    NSString *problemName = problem.problemName;
    
    CodeViewController *codeView = [[CodeViewController alloc]init];
    codeView.problemName = problemName;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.mainViewController pushViewController: codeView animated:YES];
}


- (void) searchBar: (UISearchBar *)searchBar textDidChange: (NSString *)searchText; {
    if (searchText != nil && searchText.length > 0) {
        self.filteredProblemList = [NSMutableArray array];
        for (ProblemStruct *problem in self.problemList) {
            if ([problem.problemName rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0 ) {
                [self.filteredProblemList addObject: problem];
            }
        }
    } else {
        self.filteredProblemList = [NSMutableArray arrayWithArray:self.problemList];
    }
    [self.problemListTable reloadData];
}

- (void) searchBarSearchButtonClicked: (UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked: (UISearchBar *) searchBar {
    [_searchBar resignFirstResponder];
}

@end
