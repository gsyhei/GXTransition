//
//  ViewController.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+GXTransitionDelegate.h"
#import "OneViewController.h"
#import "TwoViewController.h"

#define GX_ANIMATION_CUSTOM @[@"Push", @"PushEdgeLeft", @"PushAllLeft", @"PushAllTop", @"PushAllBottom", @"Sector", @"Erect", @"Cube Left", @"Cube Right", @"OglFlip"]
#define GX_ANIMATION_SYSTEM @[@"Fade", @"Push", @"MoveInReveal", @"Cube", @"OglFlip", @"PageCurl", @"CameralIris", @"SuckEffect", @"RippleEffect"]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle  {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"GXTransition";
    self.tableView.rowHeight = 50.0;
    self.tableView.sectionHeaderHeight = 40.0;
    self.tableView.sectionFooterHeight = 0.0;
    
    self.tableView.estimatedRowHeight = 0.0;
    self.tableView.estimatedSectionHeaderHeight = 0.0;
    self.tableView.estimatedSectionFooterHeight = 0.0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50.0, 0);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return GX_ANIMATION_CUSTOM.count;
    } else {
        return GX_ANIMATION_SYSTEM.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = GX_ANIMATION_CUSTOM[indexPath.row];
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = GX_ANIMATION_SYSTEM[indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerViewID = @"headerViewID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerViewID];
    }
    if (section == 0) {
        headerView.textLabel.text = @"Custom —— Present and push";
    }
    else if (section == 1) {
        headerView.textLabel.text = @"System —— Present and push";
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        OneViewController *vc = [[OneViewController alloc] initWithNibName:@"OneViewController" bundle:nil];
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        switch (indexPath.row) {
            case 0:
//                [self gx_pushViewController:vc style:GXAnimationStylePush interacting:YES];
                [self gx_presentViewController:navc style:GXAnimationStylePush interacting:YES completion:nil];
                break;
            case 1:
                [self gx_presentViewController:navc style:GXAnimationStylePushEdgeLeft interacting:YES completion:nil];
                break;
            case 2:
                [self gx_presentViewController:navc style:GXAnimationStylePushAllLeft interacting:YES completion:nil];
                break;
            case 3:
                [self gx_presentViewController:navc style:GXAnimationStylePushAllTop interacting:YES completion:nil];
                break;
            case 4:
                [self gx_presentViewController:navc style:GXAnimationStylePushAllBottom interacting:YES completion:nil];
                break;
            case 5:
                [self gx_presentViewController:navc style:GXAnimationStyleSector interacting:YES completion:nil];
                break;
            case 6:
                [self gx_presentViewController:navc style:GXAnimationStyleErect interacting:YES completion:nil];
                break;
            case 7:
                [self gx_presentViewController:navc style:GXAnimationStyleCubeLeft interacting:YES completion:nil];
                break;
            case 8:
                [self gx_presentViewController:navc style:GXAnimationStyleCubeRight interacting:YES completion:nil];
                break;
            case 9:
                [self gx_presentViewController:navc style:GXAnimationStyleOglFlip interacting:YES completion:nil];
                break;
            default:break;
        }
    }
    else if (indexPath.section == 1) {
        TwoViewController *vc = [[TwoViewController alloc] initWithNibName:@"TwoViewController" bundle:nil];
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];

        switch (indexPath.row) {
            case 0:
                [self gx_pushViewController:vc style:GXTransitionStyleFade subtype:kCATransitionFromRight interacting:YES];
                break;
            case 1:
                [self gx_pushViewController:vc style:GXTransitionStylePush subtype:kCATransitionFromRight interacting:YES];
                break;
            case 2:
                [self gx_presentViewController:navc style:GXTransitionStyleMoveInReveal subtype:kCATransitionFromRight interacting:YES completion:nil];
                break;
            case 3:
                [self gx_presentViewController:navc style:GXTransitionStyleCube subtype:kCATransitionFromRight interacting:YES completion:nil];
                break;
            case 4:
                [self gx_presentViewController:navc style:GXTransitionStyleOglFlip subtype:kCATransitionFromRight interacting:YES completion:nil];
                break;
            case 5:
                [self gx_presentViewController:navc style:GXTransitionStylePageCurl subtype:kCATransitionFromRight interacting:YES completion:nil];
                break;
            case 6:
                [self gx_pushViewController:vc style:GXTransitionStyleCameralIris subtype:kCATransitionFromRight interacting:YES];
                break;
            case 7:
                [self gx_pushViewController:vc style:GXTransitionStyleSuckEffect subtype:kCATransitionFromRight interacting:YES];
                break;
            case 8:
                [self gx_pushViewController:vc style:GXTransitionStyleRippleEffect subtype:kCATransitionFromRight interacting:YES];
                break;
            default:break;
        }
    }
}

@end
