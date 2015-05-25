//
//  Singleton.m
//  InstagramApp
//
//  Created by Webinfoways on 15/02/13.
//  Copyright (c) 2013 WebPlanex. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

@synthesize strDBPath;

static Singleton *singletonObj = NULL;

+ (Singleton *)sharedSingleton {
    @synchronized(self) {
        if (singletonObj == NULL)
            singletonObj = [[self alloc] init];
    }
    return(singletonObj);
}

- (NSString *) getBaseURL {
    return @"http://tops-tech.com/test-webservices/";
}

-(void) setDBPath : (NSString *) path {
    self.strDBPath = path;
}
-(NSString *) getDBPath {
    return self.strDBPath;
}

@end
