//
//  classroomTabViewController.m
//  tutenow
//
//  Created by Kurt Bornhutter on 8/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import "classroomTabViewController.h"

@interface classroomTabViewController ()

@end

@implementation classroomTabViewController
NSTimer *timer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSTimer scheduledTimerWithTimeInterval:13.50f
                                     target:self
                                   selector:@selector(checkLessonFinished)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkLessonFinished {
    userObject *usrObj = [userObject getInstance];
    NSLog(@"%@ current access key", usrObj.currentUser);
    PFQuery *queueEntry= [PFQuery queryWithClassName:@"accesskeys"];
    [queueEntry whereKey:@"accesskeystring" equalTo:usrObj.currentUser];
    [queueEntry addAscendingOrder:@"createdAt"];
    [queueEntry getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            // No session
        }
        else {
            if (object[@"finished"]) {
                if ([object[@"finished"] isEqualToString:@"YES"]) {
                    // Session is already marked as finished... so quit
                    welcomeViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"welcomescreen"];
                    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
                }
            }
            else {
                // Not finished, but check again in 30 seconds
                [NSTimer scheduledTimerWithTimeInterval:30.00f
                                                 target:self
                                               selector:@selector(checkLessonFinished)
                                               userInfo:nil
                                                repeats:NO];

            }
        }
    }];


}

@end
