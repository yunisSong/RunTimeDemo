//
//  KVOViewController.m
//  RunTimeDemo
//
//  Created by Yunis on 17/1/10.
//  Copyright © 2017年 Yunis. All rights reserved.
//

#import "KVOViewController.h"
#import "NSObject+KVO.h"

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;

@end

@implementation Message

@end
@interface KVOViewController ()
@property (nonatomic, weak) IBOutlet UITextField *textfield;
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, strong) Message *message;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //KVO (原Demo地址   https://github.com/okcomp/ImplementKVO)
    //我只是在原来的基础上加上了注释 方便自己学习
    
    
    self.message = [[Message alloc] init];
    [self.message PG_addObserver:self forKey:NSStringFromSelector(@selector(text))
                       withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                           NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                           dispatch_async(dispatch_get_main_queue(), ^{
                               self.textfield.text = newValue;
                           });
                           
                       }];
    
    [self changeMessage:nil];
}
- (IBAction)changeMessage:(id)sender
{
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
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
