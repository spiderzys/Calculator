//
//  MyButton.h
//  calculator
//
//  Created by yangsheng zou on 2015-09-02.
//  Copyright (c) 2015 yangsheng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton
typedef enum{
    number = 0,
    operation = 1,
    clean = 2
} type;


+(id)buttonWithType:(UIButtonType)buttonType withType:(NSInteger)type;
@property NSInteger type;

@end
