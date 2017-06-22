//
//  finishViewController.m
//  tutenow
//
//  Created by Kurt Bornhutter on 8/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import "finishViewController.h"

@interface finishViewController ()

@end

@implementation finishViewController
CAShapeLayer *circle;
NSTimer *t;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchDown:(id)sender {
    
    // Set up the shape of the circle
    int radius = 300;
    circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor whiteColor].CGColor;
    circle.lineWidth = 5;
    
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.delegate = (self);
    drawAnimation.duration            = 4.0; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = YES;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    t = [NSTimer scheduledTimerWithTimeInterval:3.9
                                         target:self
                                       selector:@selector(onTick:)
                                       userInfo:nil
                                        repeats:NO];
    
}

-(void)onTick:(NSTimer *)timer {
    userObject *usrObj = [userObject getInstance];
        PFQuery *queueEntry= [PFQuery queryWithClassName:@"accesskeys"];
        [queueEntry whereKey:@"accesskeystring" equalTo:usrObj.currentUser];
        [queueEntry addAscendingOrder:@"createdAt"];
        [queueEntry getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!object) {
                // Never existed
            } else {
                object[@"finished"] = @"YES";
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        welcomeViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"welcomescreen"];
                        [self presentViewController:monitorMenuViewController animated:YES completion:nil];
                    }
                }];
            }}];
    
    
}


- (IBAction)relaseButton:(id)sender {
    [t invalidate];
    t = nil;
    [circle removeFromSuperlayer];
}

@end
