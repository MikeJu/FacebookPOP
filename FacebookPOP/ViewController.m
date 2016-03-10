//
//  ViewController.m
//  FacebookPOP
//
//  Created by ciwong on 15/12/17.
//  Copyright (c) 2015年 ciwong. All rights reserved.
//

#import "ViewController.h"
#import "PopView.h"

@interface ViewController ()<PopViewProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pop:(id)sender {
    PopView *popView = [[PopView alloc] initWithFrame:self.view.bounds];
    [popView showInView:self.view];
    popView.popDelegate = self;
}


#pragma mark - PopViewProtocol
- (void)pressedButtonIndex:(NSInteger)index
{
    NSLog(@"点击的btn_index:%ld",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
