//
//  ViewController.m
//  LittleLights
//
//  Created by Weicheng Yang on 2018/12/27.
//  Copyright © 2018 Weicheng Yang. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"--%@",x);
    }];
    
    
}
@end
