//
//  AboutViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "AboutViewController.h"
#import "AppDelegate.h"

@interface AboutViewController ()
@property (strong, nonatomic) IBOutlet UITableView *aboutTableView;
@property (strong, nonatomic) NSArray *version;
@property (strong, nonatomic) NSArray *problemSource;
@property (strong, nonatomic) NSArray *contributor;
@property (strong, nonatomic) NSArray *infoData;
@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
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
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView: customizedButton];
    [self.navigationItem setLeftBarButtonItem: menuButton];
    
    self.version = [[NSArray alloc]initWithObjects: @"1.0", nil];
    self.problemSource = [[NSArray alloc]initWithObjects: @"oj.leetcode.com", nil];
    self.contributor = [[NSArray alloc]initWithObjects: @"ngcl", nil];
    self.infoData = [[NSArray alloc]initWithObjects: self.version, self.problemSource, self.contributor, nil];
}

- (void)didReceiveMemoryWarnin {
    [super didReceiveMemoryWarning];
}

- (IBAction)menuClicker:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.infoData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.infoData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.aboutTableView dequeueReusableCellWithIdentifier:@"info"];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info"];
    }
    cell.textLabel.text = [[self.infoData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"Didot" size:14.0];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, tableView.frame.size.width, 30)];
    sectionHeaderView.backgroundColor = [UIColor clearColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(0, 0, sectionHeaderView.frame.size.width, 25.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor colorWithRed:27.0f / 255.0f green:131.0f / 255.0f blue:202.0f / 255.0f alpha:1.0f];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:20.0]];
    [sectionHeaderView addSubview:headerLabel];
    
    switch (section) {
        case 0:
            headerLabel.text = @"VERSION";
            return sectionHeaderView;
            break;
        case 1:
            headerLabel.text = @"PROBLEM SOURCE";
            return sectionHeaderView;
            break;
        case 2:
            headerLabel.text = @"ANSWERED BY";
            return sectionHeaderView;
            break;
        default:
            break;
    }
    return sectionHeaderView;
}

@end
