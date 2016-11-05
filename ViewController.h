//
//  ViewController.h
//  calculator
//
//  Created by yangsheng zou on 2015-09-02.
//  Copyright (c) 2015 yangsheng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
typedef enum{
    cl = 0,
    oper = 1,
    num = 2
    
    
}state;
@property NSInteger state;
@property NSString* last;
@property NSString* symbol;
@end

