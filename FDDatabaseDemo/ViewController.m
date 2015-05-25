//
//  ViewController.m
//  FDDatabaseDemo
//
//  Created by Tops on 11/07/14.
//  Copyright (c) 2014 Tops. All rights reserved.
//

#import "ViewController.h"
#import "Singleton.h"
#import "FMDatabase.h"
#import "Reachability.h"

@interface ViewController ()
{
    int imgId;
    NSString *strImageName;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self isconnectedToNetwork]) {
        NSLog(@"yes available");
    }
    
    
//	FMDatabase *db = [FMDatabase databaseWithPath:[[Singleton sharedSingleton] getDBPath]];
//    if (![db open])
//    {
//        
//    }else
//    {                   //(Copy4, Copy6, ImageName,UploadFlag,OrderId)
//        NSString *strurl =@"create table if not exists tblUploadImage (ImgID integer primary key, Copy4 integer, Copy6 integer,ImageName text,  UploadFlag integer, OrderId integer)";
//        
//        if ([db executeUpdate:strurl]) {
//            [self.navigationController popViewControllerAnimated:YES];
//            NSLog(@"sucess");
//            
//        }
//        
//        [db close];
//    }
    
    
    
}

- (BOOL) isconnectedToNetwork {
    
    //    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    //    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    //    return !(networkStatus == NotReachable);
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus=[reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
}

-(IBAction)btnSAVE:(id)sender
{
    //    FMDatabase *dbsave = [FMDatabase databaseWithPath:[[Singleton sharedSingleton] getDBPath]];
    //    if ([dbsave open])
    //    {
    //        NSString *strQuery =@"insert into studentsDetail (regno,name, department, year) values (109,\"ilesh\",\"OSX Developer\",\"2015\")";
    //        if ([dbsave executeUpdate:strQuery]) {
    //            NSLog(@"save data");
    //        }
    //        [dbsave close];
    //    }
    NSString *str4 =@"4";
    NSString *str6 =@"6";
    NSString *strname =@"name";
        NSString *strflag =@"0";
        NSString *strOID =@"214";
    
    
    FMDatabase *dbsave = [FMDatabase databaseWithPath:[[Singleton sharedSingleton] getDBPath]];
    if ([dbsave open])
    {
        NSString *strQuery =[NSString stringWithFormat:@"insert into tblUploadImage (Copy4, Copy6, ImageName,UploadFlag,OrderId) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",str4,str6,strname,strflag,strOID];
        if ([dbsave executeUpdate:strQuery])
        {
            NSLog(@"save data");
        }
        [dbsave close];
    }
}

-(IBAction)btnFetch:(id)sender
{
    int count =0;
    
//    FMDatabase *dbfetch1 = [FMDatabase databaseWithPath:[[Singleton sharedSingleton] getDBPath]];
//    if ([dbfetch1 open])
//    {
//        
//        int count = [dbfetch1 executeQuery:@"SELECT count(ImgId) FROM tblUploadImage where UploadFlag = 0"];
//        
//        [dbfetch1 close];
//    }
    
    
    FMDatabase *dbfetch = [FMDatabase databaseWithPath:[[Singleton sharedSingleton] getDBPath]];
    if ([dbfetch open])
    {
        
        FMResultSet *rs = [dbfetch executeQuery:@"select ImageName,ImgID from tblUploadImage Where UploadFlag =0 limit 0,1"];
        while ([rs next])
        {
            NSLog(@"%d",[rs intForColumn:@"ImgId"] );
            imgId =[rs intForColumn:@"ImgId"];
           // NSLog(@"%d",[rs intForColumn:@"Copy4"] );
           // NSLog(@"%@",[rs stringForColumn:@"Copy6"] );
            NSLog(@"%@",[rs stringForColumn:@"ImageName"] );
            strImageName =[rs stringForColumn:@"ImageName"];
           // NSLog(@"%@",[rs stringForColumn:@"UploadFlag"] );
         //   NSLog(@"%@",[rs stringForColumn:@"OrderId"] );
            count++;
            
           // break ;
        }
        
        [dbfetch close];
    }
    if (count==0)
    {
        NSLog(@"All Image Upload");
    }
    else
    {
        [self updateDATA];
    }
    
}
-(void)updateDATA
{
    FMDatabase *dbfetch = [FMDatabase databaseWithPath:[[Singleton sharedSingleton] getDBPath]];
    if ([dbfetch open])
    {
        
        BOOL success  =[dbfetch executeUpdate:[NSString stringWithFormat:@"update  tblUploadImage  set UploadFlag=1 Where ImageName =%@",strImageName]];
        
//        while ([rs next])
//        {
//            NSLog(@"%d",[rs intForColumn:@"ImgId"] );
//            imgId =[rs intForColumn:@"ImgId"];
//            // NSLog(@"%d",[rs intForColumn:@"Copy4"] );
//            // NSLog(@"%@",[rs stringForColumn:@"Copy6"] );
//            NSLog(@"%@",[rs stringForColumn:@"ImageName"] );
//            strImageName =[rs stringForColumn:@"ImageName"];
//            // NSLog(@"%@",[rs stringForColumn:@"UploadFlag"] );
//            //   NSLog(@"%@",[rs stringForColumn:@"OrderId"] );
//            NSLog(@"update");
//            break ;
//        }
    [dbfetch close];
        if (success)
        {   
           NSLog(@"update");
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *strname=[NSString stringWithFormat:@"%@%d.png",strImageName,imgId];
            if ([fileManager removeItemAtPath:[self documentsPathForFileName:strname] error:NULL]) {
                NSLog(@"Removed successfully");
            }
            
         [self btnFetch:self];
        }
        else
            NSLog(@"NOT update");
      
    }
   
}
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
