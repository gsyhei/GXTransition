//
//  GXAnimatedSPushDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/7.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationPushELDelegate.h"

#define GX_ANIMATED_SCALE 0.95f

@implementation GXAnimationPushELDelegate

#pragma mark - Overwrite

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext.containerView addSubview:toVC.view];

    UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:fromSnapshotView];
    [transitionContext.containerView bringSubviewToFront:toVC.view];
    fromVC.view.hidden = YES;
    
    CGRect frame = toVC.view.frame;
    frame.origin.x = toVC.view.bounds.size.width;
    toVC.view.frame = frame;
    frame.origin.x = 0.0f;

    [self addBackgroundViewToView:fromSnapshotView];
    [self addShadowToView:toVC.view];
    [self animateWithContext:transitionContext isPresent:YES animations:^{
        toVC.view.frame = frame;
        fromSnapshotView.transform = CGAffineTransformMakeScale(GX_ANIMATED_SCALE, GX_ANIMATED_SCALE);
    } completion:^(BOOL finished) {
        fromVC.view.hidden = NO;
        [fromSnapshotView removeFromSuperview];
    }];
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.isPush) {
        [transitionContext.containerView addSubview:toVC.view];
        [transitionContext.containerView bringSubviewToFront:fromVC.view];
    }

    CGRect frame = fromVC.view.frame;
    frame.origin.x = 0.0f;
    fromVC.view.frame = frame;
    frame.origin.x = fromVC.view.bounds.size.width;
    CGAffineTransform transform = CGAffineTransformMakeScale(GX_ANIMATED_SCALE, GX_ANIMATED_SCALE);
    toVC.view.transform = transform;
    
    [self addBackgroundViewToView:toVC.view];
    [self addShadowToView:fromVC.view];
    [self animateWithContext:transitionContext isPresent:NO animations:^{
        fromVC.view.frame = frame;
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        toVC.view.transform = CGAffineTransformIdentity;
    }];
}

@end
