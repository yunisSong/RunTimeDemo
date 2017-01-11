//
//  EncodeViewController.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/11.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "EncodeViewController.h"
#import "EncodeTestModel.h"
@interface EncodeViewController ()

@end

@implementation EncodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    EncodeTestModel *model = [[EncodeTestModel alloc] init];
    model.e0 = @"日照香炉生紫烟";
    model.e1 = @"遥看瀑布挂前川";
    model.e2 = @"飞流直下三千尺";
    model.e3 = @"疑是银河落九天";
    model.e4 = @"朝发白帝彩云间";
    model.e5 = @"千里江陵一日还";
    model.e6 = @"两岸猿声啼不住";
    model.e7 = @"轻舟已过万重山";
    model.e8 = @"日";
    model.e9 = @"干";
    //  归档文件的路径
    NSString *filePath = [NSHomeDirectory()stringByAppendingPathComponent:@"EncodeTestModel.archiver"];
    
    NSLog(@"filePath = %@",filePath);
    //  判断该文件是否存在
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        
        NSLog(@"归档存储");
        //  不存在的时候，归档存储一个Student的对象
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [archiver encodeObject:model forKey:@"EncodeTestModel"];
        [archiver finishEncoding];
        
        BOOL success = [data writeToFile:filePath atomically:YES];
        if (success) {
            NSLog(@"归档成功！");
        }
    } else{
        NSLog(@"解挡读取");

        //  存在的时候，不再进行归档，而是解挡！
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        EncodeTestModel *studentFromSaving = [unArchiver decodeObjectForKey:@"EncodeTestModel"];
        
        NSLog(@"%@, %@", studentFromSaving.e1, studentFromSaving.e2);
    
    }
    
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
