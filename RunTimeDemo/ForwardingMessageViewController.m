//
//  ForwardingMessageViewController.m
//  RunTimeDemo
//
//  Created by Yunis on 5/1/17.
//  Copyright © 2018年 Yunis. All rights reserved.
//

#import "ForwardingMessageViewController.h"
#import "ForwardingMessageModel.h"
@interface ForwardingMessageViewController ()

@end

@implementation ForwardingMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ForwardingMessageModel *model = [ForwardingMessageModel new];
    [model performSelector:@selector(test) withObject:nil];
    [model performSelector:@selector(test:) withObject:@"11111"];
    [model performSelector:@selector(sayHello:) withObject:@"Yunis"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
