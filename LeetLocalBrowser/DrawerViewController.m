//
//  DrawerViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "DrawerViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "ProblemListViewController.h"
#import "PickOneViewController.h"
#import "StarViewController.h"
#import "AboutViewController.h"
#import "FeedBackViewController.h"

static NSString * const cellReuseId = @"cellReuseId";

@interface DrawerViewController ()
@property (strong, nonatomic) NSArray *colors;
@property (assign, nonatomic) NSInteger previousRow;
@property (strong, nonatomic) NSArray *menuItems;
@end

@implementation DrawerViewController

- (id) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    self.menuItems = [[NSArray alloc]initWithObjects: @"Problems", @"Pick One", @"Favorites", @"About", @"Feedback", nil];
    return self;
}

- (id) initWithColors:(NSArray *)colors {
    NSParameterAssert(colors);
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _colors = colors;
    }
    return self;
}

// MARK - Managing the view

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseId];
    self.view.backgroundColor = [UIColor colorWithRed: 255.0f / 255.0f green: 255.0f / 255.0f blue: 255.0f / 255.0f alpha: 1.0f];
    
    UIImageView *header = [self headerWithColor:[UIColor colorWithRed: 34.0f / 255.0f green: 34.0f / 255.0f blue : 34.0f / 255.0f alpha: 1.0f]];
    self.tableView.tableHeaderView = header;
}

// MARK - Generate a pure color header

- (UIImageView *) headerWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width,
                             [[UIApplication sharedApplication] statusBarFrame].size.height + 44.5);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIGraphicsEndImageContext();
    
    // MARK - Set drawer's header picture
    
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:rect];
    imageHolder.image = [UIImage imageNamed:@"drawer_header.png"];
    return imageHolder;
}

// MARK - Configuring the view’s layout behavior

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL) prefersStatusBarHidden {
    return NO;
}

// MARK - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // MARK - Configuring cell's style
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    cell.textLabel.text = self.menuItems[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor clearColor];
    
    UIImage *sourceIcon;
    switch (indexPath.row) {
        case 0:
            sourceIcon = [UIImage imageNamed:@"drawer_problem_list.png"];
            break;
        case 1:
            sourceIcon = [UIImage imageNamed:@"drawer_pick_one.png"];
            break;
        case 2:
            sourceIcon = [UIImage imageNamed:@"drawer_noted.png"];
            break;
        case 3:
            sourceIcon = [UIImage imageNamed:@"drawer_about.png"];
            break;
        case 4:
            sourceIcon = [UIImage imageNamed:@"drawer_feedback.png"];
            break;
        default:
            break;
    }
    [cell.imageView setContentMode:UIViewContentModeCenter];
    [cell.imageView setImage:sourceIcon];
    return cell;
}

// MARK - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.previousRow && indexPath.row != 1) {
        [self.drawer close];
    }
    else {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        PickOneViewController *pickOneViewController;
        StarViewController *starViewController;
        AboutViewController *aboutViewController;
        FeedBackViewController *feedBackViewController;
        
        // MARK - Configuring every cell's behavior by row
        //   1. - Alloc and init targetView
        //   2. - Replace current view to targetView
        //   3. - Delegate mainView to targetView
        
        switch (indexPath.row) {
            case 0:
                [self.drawer replaceCenterViewControllerWithViewController:delegate.problemListMain];
                delegate.mainViewController = delegate.problemListMain;
                break;
            case 1:
                pickOneViewController = [[PickOneViewController alloc]init];
                delegate.pickOneMain = [[ViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.pickOneMain];
                pickOneViewController.title = @"Lucky!";
                delegate.mainViewController = delegate.pickOneMain;
                [delegate.pickOneMain pushViewController:pickOneViewController animated:YES];
                break;
            case 2:
                starViewController = [[StarViewController alloc]init];
                delegate.starMain = [[ViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.starMain];
                starViewController.title = @"Favorites";
                delegate.mainViewController = delegate.starMain;
                [delegate.starMain pushViewController:starViewController animated:YES];
                break;
            case 3:
                aboutViewController = [[AboutViewController alloc]init];
                delegate.aboutMain = [[ViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.aboutMain];
                aboutViewController.title = @"About";
                delegate.mainViewController = delegate.aboutMain;
                [delegate.aboutMain pushViewController:aboutViewController animated:YES];
                break;
            case 4:
                feedBackViewController = [[FeedBackViewController alloc]init];
                delegate.feedBackMain = [[ViewController alloc]init];
                [self.drawer replaceCenterViewControllerWithViewController:delegate.feedBackMain];
                feedBackViewController.title = @"Feedback";
                delegate.mainViewController = delegate.feedBackMain;
                [delegate.feedBackMain pushViewController:feedBackViewController animated:YES];
                break;
            default:
                break;
        }
    }
    self.previousRow = indexPath.row;
}

// MARK - ICSDrawerControllerPresenting

- (void) drawerControllerWillOpen:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = NO;
}
- (void) drawerControllerDidOpen:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = YES;
}
- (void) drawerControllerWillClose:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = NO;
}
- (void) drawerControllerDidClose:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = YES;
}

@end
