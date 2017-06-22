//
//  whiteboardViewController.m
//  tutenow
//
//  Created by Kurt Bornhutter on 8/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import "whiteboardViewController.h"

@interface whiteboardViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *whiteboardView;

@end

@implementation whiteboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://tutenow.com/tutenowClassroomiPad.html"]];
    [self.whiteboardView loadRequest: request];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
