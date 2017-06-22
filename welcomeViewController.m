//
//  welcomeViewController.m
//  tutenow
//
//  Created by Kurt Bornhutter on 7/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import "welcomeViewController.h"

@interface welcomeViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
NSArray *userpass;

@implementation welcomeViewController

- (IBAction)loginAttempt:(id)sender {
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center=self.view.center;
    
    [activityView startAnimating];
    
    [self.view addSubview:activityView];
    PFQuery *query = [PFQuery queryWithClassName:@"accesskeys"];
    [query whereKey:@"accesskeystring" equalTo:self.userName.text];
    userpass = [query findObjects];
    [query addAscendingOrder:@"createdAt"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            // Join room
            if (object) {
                if (object[@"finished"] && [object[@"finished"] isEqualToString:@"YES"]) {
                    // Lesson is old
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Access Code"
                                                                    message:@"Please request a new access code"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [activityView stopAnimating];
                    [alert show];
                    
                } else {
                    // Lesson is not finihsed - ENTER
                    userObject *usrObj = [userObject getInstance];
                    usrObj.currentUser = self.userName.text;
                    [activityView stopAnimating];
                    classroomTabViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"classroom"];
                    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
                }
                
            } else {
                // incorrect user/pass
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Incorrect Access Code"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [activityView stopAnimating];
                [alert show];
            }
        } else {
            // The request failed
            NSLog(@"Query Failed User Auth");
        }
    }];
    
}
- (IBAction)cancelButton:(id)sender {
    classroomTabViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"classroom"];
    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center=self.view.center;
    
    [activityView startAnimating];
    
    [self.view addSubview:activityView];
    PFQuery *query = [PFQuery queryWithClassName:@"accesskeys"];
    [query whereKey:@"accesskeystring" equalTo:self.userName.text];
    userpass = [query findObjects];
    [query addAscendingOrder:@"createdAt"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            // Join room
            if (object) {
                if (object[@"finished"] && [object[@"finished"] isEqualToString:@"YES"]) {
                    // Lesson is old
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Access Code"
                                                                    message:@"Please request a new access code"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [activityView stopAnimating];
                    [alert show];
                    
                } else {
                    // Lesson is not finihsed - ENTER
                    userObject *usrObj = [userObject getInstance];
                    usrObj.currentUser = self.userName.text;
                    [activityView stopAnimating];
                    classroomTabViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"classroom"];
                    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
                }
                
            } else {
                // incorrect user/pass
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Incorrect Access Code"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [activityView stopAnimating];
                [alert show];
            }
        } else {
            // The request failed
            NSLog(@"Query Failed User Auth");
        }
    }];
    return NO; // We do not want UITextField to insert line-breaks.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
    }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
