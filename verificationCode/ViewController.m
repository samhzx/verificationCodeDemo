//
//  ViewController.m
//  verificationCode
//
//  Created by sam on 16/9/9.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "ViewController.h"
#import "VerificationCodeView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet VerificationCodeView *vv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@",object);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",_vv.verCode);
}
@end
