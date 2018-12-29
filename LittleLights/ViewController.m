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
@property (assign, nonatomic) NSInteger countDown;
@property (strong, nonatomic) NSTimer *securityCodeTimer;
@end

@implementation ViewController

- (IBAction)getSecurityButtonClicked:(id)sender {
    self.countDown = 10;
    [self.getSecurityCodeButton setTitle:[NSString stringWithFormat:@"%ld",self.countDown] forState:UIControlStateDisabled];
    @weakify(self);
    self.securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        @strongify(self);
        self.countDown--;
        [self.getSecurityCodeButton setTitle:[NSString stringWithFormat:@"%ld",self.countDown] forState:UIControlStateDisabled];
        if (self.countDown == 0) {
            [timer invalidate];
            [self.getSecurityCodeButton setTitle:@"获取验证码" forState:UIControlStateDisabled];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    RACSignal *validPhoneLength = [self.phoneTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 11);
    }];
    RACSignal *validCodeLength = [self.securityCodeTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 6);
    }];
    RACSignal *isNotCountingDown = [RACObserve(self, countDown) map:^id _Nullable(NSNumber *_Nullable value) {
        return @([value isEqualToNumber:@0]);
    }];
    
    // 仅当手机号11位数字时， 且不在倒计时，获取验证码按钮高亮
    RAC(self.getSecurityCodeButton, enabled) = [RACSignal combineLatest:@[validPhoneLength, isNotCountingDown] reduce:^id (NSNumber *validPhoneLengthValue, NSNumber *isNotCountingDownValue){
        return @(validPhoneLengthValue.boolValue && isNotCountingDownValue.boolValue);
    }];
    
    // 仅当手机号11位数字、验证码6位数字时，登录按钮高亮
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[validPhoneLength, validCodeLength] reduce:^id (NSNumber *validPhoneLengthValue, NSNumber *validCodeLengthValue){
        return @(validPhoneLengthValue.boolValue && validCodeLengthValue.boolValue);
    }];
}

- (void)dealloc {
    //没必要， 但是可以提前销毁
    [self.securityCodeTimer invalidate];
}
@end
