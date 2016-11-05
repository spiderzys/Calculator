//
//  ViewController.m
//  calculator
//
//  Created by yangsheng zou on 2015-09-02.
//  Copyright (c) 2015 yangsheng zou. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize state,last,symbol;

- (void)viewWillLayoutSubviews
{
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = CGRectMake(0.1*width, 0.5*height-0.5*width, 0.8*width, width);

}


-(void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.4]];
    self.state = 0;
    self.symbol = nil;
    self.last = @"0";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    float width = self.view.frame.size.width*0.8; //? why
   
    MyButton *button = [MyButton buttonWithType:UIButtonTypeSystem withType:clean];
    [button setTitle:@"CE" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0.04*width, 0.05*width, 0.2*width, 0.2*width);

    [self.view addSubview:button];
   
    UILabel *result = [[UILabel alloc]initWithFrame:CGRectMake(0.28*width, 0.05*width, 0.68*width, 0.2*width)];
    [result setText:@"0"];
    result.layer.borderWidth = 1.5f;
    result.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:result];
    [result setTextAlignment:NSTextAlignmentRight];
    result.tag = 100;
    
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            MyButton *button = [MyButton buttonWithType:UIButtonTypeSystem withType:number];
            [button setTitle:[NSString stringWithFormat:@"%d",j+1+i*3] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchDown];
            button.frame = CGRectMake(0.04*width+j*0.24*width, 0.29*width+i*0.24*width, 0.2*width, 0.2*width);
            
            [self.view addSubview:button];
            
            if(i==3&&j==0){
                [button setTitle:@"0" forState:UIControlStateNormal];
            }
            else if(i==3&&j==1){
                [button setTitle:@"." forState:UIControlStateNormal];
                button.tag = 101;
              //  button.type = point;
            }
            else if(i==3&&j==2){
                [button setTitle:@"=" forState:UIControlStateNormal];
                button.type = operation;
                
            }
            else if(i==3&&j==3){
                [button setTitle:@"/" forState:UIControlStateNormal];
                button.type = operation;
                
            }
            else if(i==0&&j==3){
                [button setTitle:@"+" forState:UIControlStateNormal];
                button.type = operation;
                
            }
            else if(i==1&&j==3){
                [button setTitle:@"-" forState:UIControlStateNormal];
                button.type = operation;
                
            }
            else if(i==2&&j==3){
                [button setTitle:@"*" forState:UIControlStateNormal];
                button.type = operation;
                
            }
        }
    }
    
   
}

-(void)touch:(MyButton*)button{
    UILabel *label = (UILabel*)[self.view viewWithTag:100];
    
    if(button.type == clean){
        [label setText:@"0"];
        self.state = cl;
        self.symbol = nil;
    }
    else if(self.state == cl  && button.type== operation){
        self.state = oper;
        self.symbol = button.titleLabel.text;
        
        
    }
    else if(self.state == cl  && button.type== number){
        if([button.titleLabel.text isEqualToString:@"."]){
            [label setText:[label.text stringByAppendingString:button.titleLabel.text]];
            self.state = num;
        }
        else{
            [label setText:button.titleLabel.text];
             self.state = num;
        }
    }
    
    else if(self.state == num && button.type==number){
        [label setText:[label.text stringByAppendingString:button.titleLabel.text]];
        self.state = num;
    }
    else if(self.state == num && button.type == operation){
        if(self.symbol ==nil){ // we don't need calculation
           
            self.last = label.text;
            self.state = oper;
            self.symbol = button.titleLabel.text;
           
        }
        
        
        else{
            NSString *r = [self calculationwith:self.last with:label.text];
            if(![r isEqualToString:@"error"]){
                label.text  = r;
                if([button.titleLabel.text isEqualToString:@"="]){
                    self.symbol = nil;
                    self.state = cl;
                    self.last = r;
                    
                }
                else{
                    self.symbol = button.titleLabel.text;
                    self.state = oper;
                    
                }
            }
            else{
                self.state = cl;
                self.symbol = nil;
                [label setText:@"0"];
            }
            
        }
        
    }
    else if(self.state == oper && button.type == operation){
        self.symbol = button.titleLabel.text;
    }
    
    else if(self.state == oper && button.type == number){
        self.state = num;
        label.text = button.titleLabel.text;
    }
    UIButton *b = (UIButton*)[self.view viewWithTag:101];
    if([label.text rangeOfString:@"."].location != NSNotFound){
        b.enabled = NO;
    }
    else{
        b.enabled = YES;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)deleteZeroFrom:(NSString*)value{
    if([value rangeOfString:@"."].location != NSNotFound){
        while([[value substringFromIndex:value.length-1] isEqualToString:@"0"]){
            value = [value substringToIndex:value.length-1];
        
            }
    }
    if([[value substringFromIndex:value.length-1] isEqualToString:@"."]){
        value = [value substringToIndex:value.length-1];
    }
        return value;
}

-(NSString*)calculationwith:(NSString*)a with:(NSString *)b{
    float x = [a floatValue];
    float y = [b floatValue];
    NSString *r = a;
    if([self.symbol isEqualToString:@"+"]){
        r= [NSString stringWithFormat:@"%f",x+y];
    }
    else if([self.symbol isEqualToString:@"-"]){
        r =[NSString stringWithFormat:@"%f",x-y];
    }
    else if([self.symbol isEqualToString:@"*"]){
        r= [NSString stringWithFormat:@"%f",x*y];
    }
    else{
        if(y!=0){
           r= [NSString stringWithFormat:@"%f",x/y];
        }
        else{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"warning" message:@"dividend cannot be zero" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
            
            return @"error";
        }
    }
    return [self deleteZeroFrom:r];
}

@end
