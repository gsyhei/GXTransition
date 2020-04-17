//
//  GXAnimationTranslationType3Delegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/12.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationPushATDelegate.h"

@implementation GXAnimationPushATDelegate

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
    frame.origin.y = toVC.view.bounds.size.height;
    toVC.view.frame = frame;
    frame.origin.y = 0.0f;
    CGRect fromFrame = fromVC.view.frame;
    fromFrame.origin.y = -fromVC.view.frame.size.height;

    [self addBackgroundViewToView:fromSnapshotView];
    [self addShadowToView:toVC.view];
    [self animateWithContext:transitionContext isPresent:YES animations:^{
        toVC.view.frame = frame;
        fromSnapshotView.frame = fromFrame;
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
    frame.origin.y = 0.0f;
    fromVC.view.frame = frame;
    frame.origin.y = fromVC.view.bounds.size.height;
    CGRect toFrame = fromVC.view.frame;
    toFrame.origin.y = -toVC.view.frame.size.height;
    toVC.view.frame = toFrame;
    toFrame.origin.y = 0.0f;
    
    [self addBackgroundViewToView:toVC.view];
    [self addShadowToView:fromVC.view];
    [self animateWithContext:transitionContext isPresent:NO animations:^{
        fromVC.view.frame = frame;
        toVC.view.frame = toFrame;
    } completion:^(BOOL finished) {

    }];
}

@end
