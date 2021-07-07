//
//  CoreDataHelper.h
//  Maple
//
//  Created by Elvis Mwenda on 06/07/2021.
//  Copyright © 2021 Learning Mobile Apps. All rights reserved.
//

#ifndef CoreDataHelper_h
#define CoreDataHelper_h


#endif /* CoreDataHelper_h */


#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>
#import "Contact.h"

#pragma mark

@interface CoreDataHelper : NSObject  

#pragma mark - Interfaces

- (void)deleteContactObject:(Contact *)contact;
- (void)saveContact:(NSDictionary *)dictionary;

- (NSArray *)loadDataFromDatabase;

+ (id)sharedManager;

@end
