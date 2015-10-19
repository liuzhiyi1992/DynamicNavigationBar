//
//  ViewController.m
//  DynamicNavigationBar
//
//  Created by liuzhiyi on 15/10/19.
//  Copyright © 2015年 liuzhiyi. All rights reserved.
//

#import "ViewController.h"
#import "DynamicNavigationBarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initStatus];
    
}

- (void)initStatus{
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController setTitle:@"hello world"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"hit me , please" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickButton {
    DynamicNavigationBarController *dynamicController = [[DynamicNavigationBarController alloc] init];
    [self.navigationController pushViewController:dynamicController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
