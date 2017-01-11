//
//  ClassPropertyViewController.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/9.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "ClassPropertyViewController.h"
#import "ClassPropertyObj.h"

#import "NSObject+Property.h"



@interface ClassPropertyViewController ()

@end

@implementation ClassPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ClassPropertyObj *obj = [ClassPropertyObj new];
    obj.property01 = @"01";
    obj.property02 = @"02";
    obj.property03 = @"03";
    obj.property04 = @"04";
    obj.property05 = @"05";
    
    NSArray *pArr = [ClassPropertyObj getAllProperties];
    NSArray *mArr = [ClassPropertyObj getAllMethods];
    NSDictionary *pvDic = [obj getAllPropertiesAndVaules];
    NSLog(@"pArr = %@",pArr);
    NSLog(@"mArr = %@",mArr);

    NSLog(@"pvDic = %@",pvDic);


    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
