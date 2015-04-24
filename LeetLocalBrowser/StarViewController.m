//
//  StarViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "StarViewController.h"
#import "AppDelegate.h"
#import "FileTool.h"
#import "ProblemStruct.h"

@interface StarViewController ()
@property (strong, nonatomic) IBOutlet UITableView *problemListTable;
@property (strong, nonatomic) NSMutableArray *starList;
@end

@implementation StarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    FileTool *fileTool = [FileTool getFileTool];
    self.starList = [fileTool getStarList];
    
    // Set title color
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    // Add menu button
    UIImage *menuIcon = [UIImage imageNamed:@"icon_menu.png"];
    CGRect frameMenuIcon = CGRectMake(0, 0, menuIcon.size.width, menuIcon.size.height);
    
    UIButton *customizedButton = [[UIButton alloc]initWithFrame: frameMenuIcon];
    [customizedButton setBackgroundImage:menuIcon forState:UIControlStateNormal];
    [customizedButton addTarget:self action:@selector(menuClicker:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView: customizedButton];
    [self.navigationItem setLeftBarButtonItem: menuButton];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) menuClicker:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"star_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"star_cell"];
    }
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSArray *problemList = delegate.problemList;
    NSString *problemName = [self.starList objectAtIndex:indexPath.row];
    
    ProblemStruct *problem;
    for (ProblemStruct *tmp in problemList) {
        if ([tmp.problemName isEqualToString:problemName]) {
            problem = tmp;
            break;
        }
    }
    
    UIImage *sourceIcon = [UIImage imageNamed:problem.problemIcon];
    [cell.imageView setContentMode:UIViewContentModeCenter];
    [cell.imageView setImage: sourceIcon];
    
    cell.textLabel.text = problem.problemName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text = problem.problemDetails;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    NSString *problemName = [self.starList objectAtIndex:indexPath.row];
    CodeViewController *codeView = [[CodeViewController alloc]init];
    codeView.problemName = problemName;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.mainViewController pushViewController: codeView animated:YES];
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [self.starList count];
}


@end
