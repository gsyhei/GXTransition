//
//  OneViewController.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🔙" style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemTapped:)];
}

- (void)backBarItemTapped:(id)sender {
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark IBAction

- (IBAction)nextButtonClicked:(id)sender {
    TwoViewController *vc = [[TwoViewController alloc] initWithNibName:@"TwoViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
