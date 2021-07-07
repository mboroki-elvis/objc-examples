//
//  MADateController.h
//  Maple CoreData
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//


#import <UIKit/UIKit.h>

//1
@protocol MADateControllerDelegate <NSObject>
//2
@required
-(void)dateChanged:(NSDate *) date;

@end

@interface MADateController : UIViewController
//3
@property (strong, nonatomic) id<MADateControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *dtpDate;
@end
