//
//  MAAppDelegate.h
//  Maple CoreData
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
