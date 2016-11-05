//
//  MyButton.m
//  calculator
//
//  Created by yangsheng zou on 2015-09-02.
//  Copyright (c) 2015 yangsheng zou. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
@synthesize type;

+(id)buttonWithType:(UIButtonType)buttonType withType:(NSInteger)type{
    MyButton *button = [super buttonWithType:buttonType];
    if(button){
        button.type = type;
        button.backgroundColor = [UIColor whiteColor];
        button.tintColor = [UIColor redColor];
        button.layer.borderWidth = 1.0f;
    }
    return button;
}

@end
