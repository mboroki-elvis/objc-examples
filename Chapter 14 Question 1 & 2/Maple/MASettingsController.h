//
//  MASettingsController.h
//  Maple
//
//  Created by Jakob Iversen on 9/9/13.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASettingsController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> 
@property (weak, nonatomic) IBOutlet UIPickerView *pckSortField;
@property (weak, nonatomic) IBOutlet UISwitch *swAscending;
- (IBAction)sortDirectionChanged:(id)sender;

@end
