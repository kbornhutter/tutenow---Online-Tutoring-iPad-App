//
//  fileViewController.m
//  tutenow
//
//  Created by Kurt Bornhutter on 8/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import "fileViewController.h"

@interface fileViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnGallery;
@property (strong, nonatomic) IBOutlet UIImageView *studentImage1;
@property (strong, nonatomic) IBOutlet UIImageView *studentImage2;
@property (strong, nonatomic) IBOutlet UIImageView *tutorImage1;
@property (strong, nonatomic) IBOutlet UIImageView *tutorImage2;

@end

@implementation fileViewController 
UIImage *si1;
UIImage *si2;
UIImage *ti1;
UIImage *ti2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSTimer scheduledTimerWithTimeInterval:5.00f
                                     target:self
                                   selector:@selector(downloadAllImages)
                                   userInfo:nil
                                    repeats:YES];
}
- (void)downloadAllImages
{
    PFQuery *query = [PFQuery queryWithClassName:@"fileDB"];
    userObject *usrObj = [userObject getInstance];
        // User is student
        [query whereKey:@"tname" equalTo:usrObj.currentUser];
        [query addAscendingOrder:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            // If there are photos, we start extracting the data
            // Save a list of object IDs while extracting this data
            int i = 0;
            if (objects.count > 0) {
                for (PFObject *eachObject in objects) {
                    if (i == 0) {
                        i++;
                        [self.studentImage1 setImage: [UIImage imageWithData: [eachObject[@"file"] getData]]];
                        si1 = [UIImage imageWithData: [eachObject[@"file"] getData]];
                    } else if (i == 1 && objects.count > 1) {
                        i++;
                        [self.studentImage2 setImage: [UIImage imageWithData: [eachObject[@"file"] getData]]];
                        si2 = [UIImage imageWithData: [eachObject[@"file"] getData]];
                    } else if (i == 2 && objects.count > 2) {
                        i++;
                        [self.tutorImage1 setImage: [UIImage imageWithData: [eachObject[@"file"] getData]]];
                        ti1 = [UIImage imageWithData: [eachObject[@"file"] getData]];
                    } else if (i == 3 && objects.count > 3) {
                        i++;
                        [self.tutorImage2 setImage: [UIImage imageWithData: [eachObject[@"file"] getData]]];
                        ti2 = [UIImage imageWithData: [eachObject[@"file"] getData]];
                    } else {
                        break;
                    }
                }
            }
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectPhoto:(id)sender {
    // Ask for camera or library with alert box
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select one" delegate:self cancelButtonTitle:@"Take Photo" otherButtonTitles:@"Choose Photo", nil];
    [alert show];
   
    }
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //Camera chosen - open camera
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera] == YES){
            // Create image picker controller
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            // Set source to the camera
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            
            // Delegate is self
            imagePicker.delegate = self;
            
            // Show image picker
            [self presentModalViewController:imagePicker animated:YES];
        }
    }else{
        // Library chosen - open photo library
        ipc= [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            [self presentViewController:ipc animated:YES completion:nil];
        else
        {
            popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
            [popover presentPopoverFromRect:self.btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [picker dismissModalViewControllerAnimated:YES];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
    [self uploadImage:imageData];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void) uploadImage:(NSData *)imageData {
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    //HUD creation here (see example for code)
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"fileDB"];
            
            [userPhoto setObject:imageFile forKey:@"file"];
            userObject *usrObj = [userObject getInstance];
            userPhoto[@"tname"] = usrObj.currentUser;
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    // Saved into DB (eventually)
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        HUD.progress = (float)percentDone/100;
    }];
}
- (IBAction)s1ButtonPressed:(id)sender {
  userObject *usrObj = [userObject getInstance];
    usrObj.currentImage = si1;
}
- (IBAction)s2ButtonPressed:(id)sender {
    userObject *usrObj = [userObject getInstance];
    usrObj.currentImage = si2;

}
- (IBAction)t1ButtonPressed:(id)sender {
    userObject *usrObj = [userObject getInstance];
    usrObj.currentImage = ti1;
}
- (IBAction)t2ButtonPressed:(id)sender {
    userObject *usrObj = [userObject getInstance];
    usrObj.currentImage = ti2;
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD hides
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
