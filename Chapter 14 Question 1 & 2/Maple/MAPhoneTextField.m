//
//  MAPhoneTextField.m
//  Maple
//
//  Created by Jakob Iversen on 9/15/13.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import "MAPhoneTextField.h"

@implementation MAPhoneTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return _editMode;
}

@end
