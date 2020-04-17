//
//  TwoViewController.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/7.
//  Copyright © 2020 gin. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🔙" style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemTapped:)];
}

- (void)backBarItemTapped:(id)sender {
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
