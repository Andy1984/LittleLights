//
//  ViewController.m
//  LittleLights
//
//  Created by Weicheng Yang on 2018/12/27.
//  Copyright © 2018 Weicheng Yang. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 仅当手机号11位数字、验证码6位数字时，登录按钮高亮
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[self.phoneTextField.rac_textSignal, self.securityCodeTextField.rac_textSignal] reduce:^id (NSString *phone, NSString *code){
        NSLog(@"%@ %@",phone, code);
        return @(phone.length == 11 && code.length == 6);
    }];
}
@end
