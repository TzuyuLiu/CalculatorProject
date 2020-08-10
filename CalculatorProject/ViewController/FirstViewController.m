//
//  FirstViewController.m
//  CalculatorProject
//
//  Created by Richard on 2020/7/14.
//  Copyright © 2020 CalculatorProject. All rights reserved.
//

#import "FirstViewController.h"
#import "CalculatorViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)pressCaculatorButton:(id)sender {
    CalculatorViewController *cac = [[CalculatorViewController alloc] init];
    [self presentViewController:cac animated:YES completion:nil];
}

@end
