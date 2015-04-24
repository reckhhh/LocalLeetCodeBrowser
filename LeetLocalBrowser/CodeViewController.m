//
//  CodeViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "CodeViewController.h"
#import "FileTool.h"
#import "AppDelegate.h"

@interface CodeViewController ()
@property (strong, nonatomic) NSURL *filePath;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) UIBarButtonItem *starButton;
@property (strong, nonatomic) UIBarButtonItem *rotateButton;

@property float heightofNaviStatus;
@end

@implementation CodeViewController
{
    BOOL isStarred;
}

@synthesize problemName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) viewDidLoad {
    [super viewDidLoad];

    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    self.heightofNaviStatus = self.navigationController.navigationBar.frame.size.height + statusBarFrame.size.height;
    
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view insertSubview:self.webView atIndex:0];
    
    // MARK - problems' directory: //Resources//code";
    
    self.filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.problemName ofType:@"html" ]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.filePath]];
    
    // MARK - Configuring Star button
    
    UIImage *starIcon;
    isStarred = [self isStarred: self.problemName];
    if (isStarred) {
        starIcon = [UIImage imageNamed:@"icon_full_star.png"];
    } else {
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
    
    // MARK - Add star button and rotate ccon to the rightside of navigation
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    
}

// MARK - Behaviors of starButton click

- (BOOL) isStarred: (NSString *)problemName {
    FileTool *fileTool = [FileTool getFileTool];
    return [fileTool checkStar: self.problemName];
}
- (IBAction) starClicker: (id)sender {
    FileTool *fileTool = [FileTool getFileTool];
    [fileTool addToStarList: self.problemName];
    
    // Change icon of starButton
    UIImage *starIcon = [UIImage imageNamed:@"icon_full_star.png"];
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    [customizedStarButton addTarget:self action:@selector(unStarClicker:) forControlEvents:UIControlEventTouchUpInside];
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

- (IBAction)unStarClicker:(id)sender {
    FileTool *fileTool = [FileTool getFileTool];
    [fileTool deleteFromStarList: self.problemName];
    
    // Change icon of starButton
    UIImage *starIcon = [UIImage imageNamed:@"icon_empty_star.png"];
    CGRect frameStarIcon = CGRectMake(0, 0, starIcon.size.width, starIcon.size.height);
    
    UIButton *customizedStarButton = [[UIButton alloc]initWithFrame:frameStarIcon];
    [customizedStarButton setBackgroundImage:starIcon forState:UIControlStateNormal];
    [customizedStarButton addTarget:self action:@selector(starClicker:) forControlEvents:UIControlEventTouchUpInside];
    self.starButton = [[UIBarButtonItem alloc] initWithCustomView:customizedStarButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

// MARK - Behaviors of starButton click

- (IBAction) rotate: (id)sender {
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    
    self.webView.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.webView.frame = CGRectMake(0, self.heightofNaviStatus, width + self.heightofNaviStatus, height - self.heightofNaviStatus);
    [self.webView stopLoading];
    [self.webView reload];
    
    // Change icon of the rotateIcon
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
    
    self.webView.transform = CGAffineTransformMakeRotation(0); //rotate back
    self.webView.frame = CGRectMake(0, 0, width, height);
    
    // Change icon of the rotateIcon
    UIImage *rotateIcon = [UIImage imageNamed: @"icon_landscape.png"];
    CGRect frameRotateIcon = CGRectMake(0, 0, rotateIcon.size.width, rotateIcon.size.height);
    
    UIButton *customizedRotateButton = [[UIButton alloc]initWithFrame:frameRotateIcon];
    [customizedRotateButton setBackgroundImage:rotateIcon forState:UIControlStateNormal];
    [customizedRotateButton addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotateButton = [[UIBarButtonItem alloc] initWithCustomView:customizedRotateButton];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:self.rotateButton, self.starButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
