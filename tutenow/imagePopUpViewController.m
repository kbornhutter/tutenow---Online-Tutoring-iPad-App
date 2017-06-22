//
//  imagePopUpViewController.m
//  tutenow
//
//  Created by Kurt Bornhutter on 17/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import "imagePopUpViewController.h"

@interface imagePopUpViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation imagePopUpViewController
UIScrollView *scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    userObject *usrObj = [userObject getInstance];
    if (usrObj.currentImage) {
        [self.image setImage:usrObj.currentImage];
    }
    // Scroll View Imp
    self.scrollview.minimumZoomScale=0.8;
    self.scrollview.maximumZoomScale=10.1;
    self.scrollview.contentSize=CGSizeMake(400, 300);
    self.scrollview.delegate=self;
    
    
    // Reload image
    [NSTimer scheduledTimerWithTimeInterval:2.00f
                                     target:self
                                   selector:@selector(refreshImage)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) refreshImage {
    userObject *usrObj = [userObject getInstance];
    if (usrObj.currentImage) {
        [self.image setImage:usrObj.currentImage];
    }

}
- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.image;
}

@end
