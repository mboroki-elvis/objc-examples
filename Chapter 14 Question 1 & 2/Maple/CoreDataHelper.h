//
//  CoreDataHelper.h
//  Maple
//
//  Created by Nouman on 06/07/2021.
//  Copyright © 2021 Nouman. All rights reserved.
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
- (void)saveContactData:(NSDictionary *)dictionary user:(Contact *)contact;

- (NSArray *)loadDataFromDatabase;

+ (id)sharedManager;

@end
