//
//  GXCardAnimationDelegate.m
//  GXMediaBrowserSample
//
//  Created by Gin on 2020/3/31.
//  Copyright © 2020 protruly. All rights reserved.
//

#import "GXAnimationSectorDelegate.h"

@implementation GXAnimationSectorDelegate

#pragma mark - Overwrite

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext.containerView addSubview:toVC.view];

    CGFloat width = transitionContext.containerView.bounds.size.width;
    CGFloat height = transitionContext.containerView.bounds.size.height;
    toVC.view.layer.anchorPoint = CGPointMake(0.0f, 1.0f);
    toVC.view.layer.position = CGPointMake(0, height);
    toVC.view.transform = CGAffineTransformMakeRotation(M_PI_2);

    [self addBackgroundViewToView:fromVC.view];
    [self addShadowToView:toVC.view];
    [self animateWithContext:transitionContext isPresent:YES animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        toVC.view.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
        toVC.view.layer.position = CGPointMake(width * 0.5, height * 0.5);
        toVC.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.isPush) {
        [transitionContext.containerView addSubview:toVC.view];
        [transitionContext.containerView bringSubviewToFront:fromVC.view];
    }

    CGFloat height = transitionContext.containerView.bounds.size.height;
    UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:fromSnapshotView];
    fromVC.view.hidden = YES;
    fromSnapshotView.layer.anchorPoint = CGPointMake(0.0f, 1.0f);
    fromSnapshotView.layer.position = CGPointMake(0, height);
    
    [self addBackgroundViewToView:toVC.view];
    [self addShadowToView:fromSnapshotView];
    [self animateWithContext:transitionContext isPresent:NO animations:^{
        fromSnapshotView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        fromVC.view.hidden = NO;
        [fromSnapshotView removeFromSuperview];
    }];
}

@end
