//
//  NSObject+userObject.h
//  tutenow
//
//  Created by Kurt Bornhutter on 7/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface userObject : NSObject {
    NSString *currentUser;
    NSString *currentType;
    NSString *currentFirst;
    NSString *currentLast;
    NSString *tutorname;
    NSString *studentfirstname;
    NSString *studentlastname;
    int *fileButtonSelected;
    UIImage *currentImage;
    
}
@property(nonatomic,retain)NSString *currentUser;
@property(nonatomic,retain)NSString *currentType;
@property(nonatomic,retain)NSString *currentFirst;
@property(nonatomic,retain)NSString *currentLast;
@property(nonatomic,retain)NSString *tutorname;
@property(nonatomic,retain)NSString *studentfirstname;
@property(nonatomic,retain)NSString *studentlastname;
@property(nonatomic,assign)int *fileButtonSelected;
@property(nonatomic,retain)UIImage *currentImage;
+(userObject*)getInstance;

@end
