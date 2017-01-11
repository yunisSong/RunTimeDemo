//
//  DIc2ModelViewController.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/11.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "DIc2ModelViewController.h"
#import "NSDictionary+dic2Json.h"
#import "NSString+json2Dic.h"
#import "NSObject+Property.h"
#import "NSObject+dicToModel.h"
#import "DicToModel.h"
@interface DIc2ModelViewController ()

@end

@implementation DIc2ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSDictionary *modelDic = @{@"OC":@"日照香炉生紫烟",
                               @"Swift":@"遥看瀑布挂前川",
                               @"Python":@"飞流直下三千尺",
                               @"Ruby":@"疑是银河落九天",
                               @"Shell":@"朝发白帝彩云间",
                               @"Java":@"千里江陵一日还",
                               @"PHP":@"两岸猿声啼不住"};
    
    DicToModel *model = [DicToModel Y_ModelWithDic:modelDic];
    
    NSLog(@"model = %@",model.OC);
    NSLog(@"model = %@",model.Swift);
    NSLog(@"model = %@",model.Python);
    NSLog(@"model = %@",model.Ruby);


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
