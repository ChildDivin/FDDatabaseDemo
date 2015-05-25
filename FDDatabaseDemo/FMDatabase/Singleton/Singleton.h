//
//  Singleton.h
//  InstagramApp
//
//  Created by Webinfoways on 15/02/13.
//  Copyright (c) 2013 WebPlanex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject {
    NSString *strDBPath;
}

@property (nonatomic, retain) NSString *strDBPath;

+ (Singleton *)sharedSingleton;

- (NSString *) getBaseURL;

-(void) setDBPath : (NSString *) path;
-(NSString *) getDBPath;


@end
