//
//  CoreDataHelper.m
//  Maple
//
//  Created by Elvis Mwenda on 06/07/2021.
//  Copyright © 2021 Learning Mobile Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import "MAAppDelegate.h"
#import "Constants.h"

NSManagedObjectContext *managedContext;

@implementation CoreDataHelper

+ (id)sharedManager {
  static CoreDataHelper *sharedMyManager = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
   sharedMyManager = [[self alloc] init];
     });
     return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        MAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        [context setMergePolicy:NSOverwriteMergePolicy];
        managedContext = context;
    }
    return self;
}


#pragma mark - Core Data methods
- (NSArray *) loadDataFromDatabase
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *sortField = [settings stringForKey:kSortField];
    bool sortAscending = [settings boolForKey:kSortDirectionAscending];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Contact"
                                              inManagedObjectContext:managedContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //Specify sorting
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:sortField
                                        ascending:sortAscending];
    NSArray *sortDescriptors = [[NSArray alloc]
                                initWithObjects: sortDescriptor, nil] ;
    request.sortDescriptors = sortDescriptors;
    
    NSError *error;
    
    return [[NSArray alloc]
                initWithArray:[managedContext executeFetchRequest:request
                                                     error:&error]];
}

- (void) deleteContactObject:(Contact*)contact {
    [managedContext deleteObject:contact];
    NSError *error;
    [managedContext save:&error];
}

- (void)saveContact:(NSDictionary*)dictionary {
    Contact *contact = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Contact"
                        inManagedObjectContext:managedContext];
    NSError *error;
    
    [contact setValue:[dictionary objectForKey:@"contactName"] forKey:@"contactName"];
    [contact setValue:[dictionary objectForKey:@"streetAddress"]  forKey:@"streetAddress"];
    [contact setValue:[dictionary objectForKey:@"city"]  forKey:@"city"];
    [contact setValue:[dictionary objectForKey:@"state"]  forKey:@"state"];
    [contact setValue:[dictionary objectForKey:@"zipCode"]  forKey:@"zipCode"];
    [contact setValue:[dictionary objectForKey:@"phoneNumber"]  forKey:@"phoneNumber"];
    [contact setValue:[dictionary objectForKey:@"cellNumber"]  forKey:@"cellNumber"];
    [contact setValue:[dictionary objectForKey:@"email"]  forKey:@"email"];
    [contact setValue:[dictionary objectForKey:@"birthday"]  forKey:@"birthday"];
    
    [managedContext save:&error];
    if(error !=nil) {
        NSLog(@"Error saving object: %@", error.description);
    } else {
        NSLog(@"Object saved successfully");
    }
}
@end
