//
//  PickOneViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "PickOneViewController.h"
#import "AppDelegate.h"
#import "FileTool.h"
#import "ProblemStruct.h"

@interface PickOneViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSArray *problemList;
@property (strong, nonatomic) NSString *problemName;

@property (strong, nonatomic) UIBarButtonItem *starButton;
@property (strong, nonatomic) UIBarButtonItem *rotateButton;

@property float heightofNaviStatus;
@end

@implementation PickOneViewController {
    BOOL isStarred;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];

    // MARK - Configuring Frame Menu Icon
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];

    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    self.heightofNaviStatus = self.navigationController.navigationBar.frame.size.height + statusBarFrame.size.height;
    
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view insertSubview:self.webView atIndex:0];
    
    UIImage *menuIcon = [UIImage imageNamed:@"icon_menu.png"];
    CGRect frameMenuIcon = CGRectMake(0, 0, menuIcon.size.width, menuIcon.size.height);
    
    UIButton *customizedButton = [[UIButton alloc]initWithFrame:frameMenuIcon];
    [customizedButton setBackgroundImage:menuIcon forState:UIControlStateNormal];
    [customizedButton addTarget:self action:@selector(menuClicker:) forControlEvents:UIControlEventTouchUpInside];
    
    // MARK - Add Frame Menu Icon to the leftside of navigation
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:customizedButton];
    [self.navigationItem setLeftBarButtonItem:menuButton];
    
    // MARK - Randomly pick one problem
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.problemList = [[NSArray alloc]initWithArray:delegate.problemList];
    
    int index = [self generateRandom:(int)[self.problemList count]];
    ProblemStruct *problem = [self.problemList objectAtIndex:index];
    self.problemName = problem.problemName;
    
    NSURL *filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.problemName ofType:@"html" ]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:filePath]];
    
    // MARK - Configuring Rotate Button
    
    UIImage *starIcon;
    isStarred = [self isStarred:self.problemName];
    if (isStarred) {
        starIcon = [UIImage imageNamed:@"icon_full_star.png"];
    }
    else {
        starIcon = [UIImage imageNamed:@"icon_empty_star.png"];
    }
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    if (!isStarred) {
        [customizedStarButton addTarget:self action:@selector(starClicker:) forControlEvents:UIControlEventTouchUpInside];
        isStarred = YES;
    }
    else {
        [customizedStarButton addTarget:self action:@selector(unStarClicker:) forControlEvents:UIControlEventTouchUpInside];
        isStarred = NO;
    }
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    
    // MARK - Configuring Rotate Icon
    
    UIImage *rotateIcon = [UIImage imageNamed:@"icon_landscape.png"];
    CGRect frameRotateIcon = CGRectMake(0, 0, rotateIcon.size.width, rotateIcon.size.height);
    UIButton *customizedRotateButton = [[UIButton alloc]initWithFrame:frameRotateIcon];
    [customizedRotateButton setBackgroundImage:rotateIcon forState:UIControlStateNormal];
    [customizedRotateButton addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotateButton = [[UIBarButtonItem alloc] initWithCustomView:customizedRotateButton];
    
    // MARK - Add Star Button and Rotate Icon to the rightside of navigation
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (int) generateRandom: (int)count {
    return arc4random() % count;
}

- (BOOL) isStarred: (NSString *)problemName {
    FileTool *fileTool = [FileTool getFileTool];
    return [fileTool checkStar:self.problemName];
}

- (IBAction) menuClicker: (id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}

- (IBAction) starClicker: (id)sender {
    FileTool *fileTool = [FileTool getFileTool];
    [fileTool addToStarList:self.problemName];
    
    // Change the picture icon of starButton
    UIImage *starIcon = [UIImage imageNamed:@"icon_full_star.png"];
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    [customizedStarButton addTarget:self action:@selector(unStarClicker:) forControlEvents:UIControlEventTouchUpInside];
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

- (IBAction) unStarClicker: (id)sender {
    FileTool *fileTool = [FileTool getFileTool];
    [fileTool deleteFromStarList:self.problemName];
    
    // Change the picture icon of starButton
    UIImage *starIcon = [UIImage imageNamed:@"icon_empty_star.png"];
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    [customizedStarButton addTarget:self action:@selector(starClicker:) forControlEvents:UIControlEventTouchUpInside];
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

- (IBAction) rotate: (id)sender {
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    self.webView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    self.webView.frame = CGRectMake(0, self.heightofNaviStatus, width + self.heightofNaviStatus, height - self.heightofNaviStatus);
    [self.webView stopLoading];
    [self.webView reload];
    
    // Change icon of the button
    UIImage *rotateIcon = [UIImage imageNamed:@"icon_portrait.png"];
    CGRect frameRotateIcon = CGRectMake(0, 0, rotateIcon.size.width, rotateIcon.size.height);
    
    UIButton *customizedRotateButton = [[UIButton alloc]initWithFrame:frameRotateIcon];
    [customizedRotateButton setBackgroundImage:rotateIcon forState:UIControlStateNormal];
    [customizedRotateButton addTarget:self action:@selector(unrotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotateButton = [[UIBarButtonItem alloc] initWithCustomView:customizedRotateButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

- (IBAction) unrotate: (id)sender {
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    
    self.webView.transform = CGAffineTransformMakeRotation(0);
    self.webView.frame = CGRectMake(0, 0, width, height);
    
    // Change icon of the button
    UIImage *rotateIcon = [UIImage imageNamed:@"icon_landscape.png"];
    CGRect frameRotateIcon = CGRectMake(0, 0, rotateIcon.size.width, rotateIcon.size.height);
    
    UIButton *customizedRotateButton = [[UIButton alloc]initWithFrame:frameRotateIcon];
    [customizedRotateButton setBackgroundImage:rotateIcon forState:UIControlStateNormal];
    [customizedRotateButton addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotateButton = [[UIBarButtonItem alloc] initWithCustomView:customizedRotateButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

@end
