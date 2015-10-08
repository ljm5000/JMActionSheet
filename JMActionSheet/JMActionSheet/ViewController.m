//
//  ViewController.m
//  JMActionSheet
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"
#import "JMActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 //   self.view.backgroundColor = [UIColor redColor];
    
    [self performSelector:@selector(gotoActionSheet) withObject:nil afterDelay:1.0f];
    
}

-(void)gotoActionSheet{
    
    

    [JMActionSheet showWithTitle:@"message" withDetail:@"a" withCancelTitle:@"cancel" withSubmitTitle:@"okokokokokok" withClickHandler:^(NSInteger index) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
