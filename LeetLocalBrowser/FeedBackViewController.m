//
//  FeedBackViewController.m
//  LeetLocalBrowser
//
//  Created by ngcl on 4/14/15.
//  Copyright (c) 2015 Black Mamba. All rights reserved.
//

#import "FeedBackViewController.h"
#import "AppDelegate.h"

@interface FeedBackViewController ()
@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    // Add Menu Button
    UIImage *menuIcon = [UIImage imageNamed:@"icon_menu.png"];
    CGRect frameMenuIcon = CGRectMake(0, 0, menuIcon.size.width, menuIcon.size.height);
    
    UIButton *customizedButton = [[UIButton alloc]initWithFrame:frameMenuIcon];
    [customizedButton setBackgroundImage:menuIcon forState:UIControlStateNormal];
    [customizedButton addTarget:self action:@selector(menuClicker:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:customizedButton];
    [self.navigationItem setLeftBarButtonItem:menuButton];
    
    // Open mail
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil && [mailClass canSendMail]) {
        [self sendEmail];
    }
    else {
        [self launchMailAppOnDevice];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)menuClicker:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawer open];
}

- (void)sendEmail {
    MFMailComposeViewController *sendMailViewController = [[MFMailComposeViewController alloc]init];
    sendMailViewController.mailComposeDelegate = self;
    [sendMailViewController setSubject: @"Feedback of LeetLocalBrowser"];
    [sendMailViewController setToRecipients:[NSArray arrayWithObject:@"ngcr@outlook.com"]];
    [sendMailViewController setMessageBody:@"" isHTML: NO];
    [self presentViewController: sendMailViewController animated: YES completion: nil];
}

-(void)launchMailAppOnDevice {
    NSString *recipients = @"mailto:ngcr@outlook.com&subject=Feedback of LeetLocalBrowser";
    NSString *body = @"&body= sent from my iphone.";
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled: {
            //NSLog(@"Mail send canceled.");
            break;
        }
        case MFMailComposeResultSaved: {
            //NSLog(@"Mail saved.");
            break;
        }
        case MFMailComposeResultSent: {
            //NSLog(@"Mail sent.");
            break;
        }
        case MFMailComposeResultFailed: {
            //NSLog(@"Mail sent Failed.");
            break;
        }
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
