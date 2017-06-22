//
//  NSObject+userObject.m
//  tutenow
//
//  Created by Kurt Bornhutter on 7/01/2015.
//  Copyright (c) 2015 tutenow. All rights reserved.
//

#import "userObject.h"

@implementation userObject
@synthesize currentUser;
@synthesize currentType;
@synthesize currentFirst;
@synthesize currentLast;
@synthesize tutorname;
@synthesize studentfirstname;
@synthesize studentlastname;
@synthesize fileButtonSelected;
@synthesize currentImage;

static userObject *instance = nil;
+(userObject *)getInstance {
    @synchronized(self)
    {
        if(instance==nil) {
            instance = [userObject new];
        }
    }
    return instance;
}

@end