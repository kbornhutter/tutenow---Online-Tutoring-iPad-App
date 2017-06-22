//
//  fileViewController.h
//  tutenow
//
//  Created by Kurt Bornhutter on 8/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "userObject.h"
#import "MBProgressHUD.h"
#include <stdlib.h>

@interface fileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
    NSMutableArray *allImages;
    
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHD;
}
@end
