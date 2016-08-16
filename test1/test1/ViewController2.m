//
//  ViewController2.m
//  test1
//
//  Created by LvJianfeng on 16/8/16.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

#import "ViewController2.h"
#import "LLAlertView.h"

@interface ViewController2 () <LLAlertViewDelegate>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tap:(id)sender {
    LLAlertView *alertView = [[LLAlertView alloc] initWithTitle:@"版本提示(默认)" message:@"最新版本1.3.3" cancelButtonTitle:@"稍后更新" otherButtonTitle:@"立即更新"];
    alertView.clickActionBlock = ^{
        NSLog(@"Clicked->样式一(版本提示)");
    };
    [alertView show];
}

- (IBAction)tap2:(id)sender {
    LLAlertView *alertView = [[LLAlertView alloc] initWithTitle:@"背景及文本颜色" message:@"修改背景色" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    alertView.contentViewBackgroundColor = ll_ColorWithRGB(0xffb412);
    alertView.titleColor = [UIColor whiteColor];
    alertView.messageColor = [UIColor groupTableViewBackgroundColor];
    alertView.clickActionBlock = ^{
        NSLog(@"Clicked->样式二(背景及文本颜色)");
    };
    [alertView show];
}
- (IBAction)tap3:(id)sender {
    LLAlertView *alertView = [[LLAlertView alloc] initWithTitle:@"按钮文本颜色" message:@"修改文本色" cancelButtonTitle:@"我是蓝色" otherButtonTitle:@"我是红色"];
    alertView.cancelButtonTitleColor = [UIColor blueColor];
    alertView.otherButtonTitleColor = [UIColor redColor];
    alertView.clickActionBlock = ^{
        NSLog(@"Clicked->样式三(按钮文本颜色)");
    };
    [alertView show];
}
- (IBAction)tap44:(id)sender {
    //文本传空
    LLAlertView *alertView = [[LLAlertView alloc] initWithTitle:@"只有标题" message:@"" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    alertView.clickActionBlock = ^{
        NSLog(@"Clicked->样式四(只有标题)");
    };
    [alertView show];
}

- (IBAction)tap4:(id)sender {
    
    LLAlertView *alertView = [[LLAlertView alloc] initWithTitle:@"实现协议" message:@"Delegate" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    alertView.delegate = self;
    [alertView show];
}

//协议
- (void)cancelClicked{
    NSLog(@"点击了取消");
}

- (void)otherClicked{
    NSLog(@"点击了确定");
}

@end
