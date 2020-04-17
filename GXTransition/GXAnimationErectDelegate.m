//
//  GXAnimationErectDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/15.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationErectDelegate.h"

@implementation GXAnimationErectDelegate

#pragma mark - Overwrite

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext.containerView addSubview:toVC.view];

    CGFloat width = transitionContext.containerView.bounds.size.width;
    CGFloat height = transitionContext.containerView.bounds.size.height;
    toVC.view.layer.position = CGPointMake(width, height * 0.5);
    toVC.view.layer.anchorPoint = CGPointMake(0.0, 0.5);
    CATransform3D rotateTransform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1.0, 0);
    rotateTransform.m34 = 1.0 / -500.0;
    toVC.view.layer.transform = rotateTransform;

    [self addBackgroundViewToView:fromVC.view];
    [self addShadowToView:toVC.view];
    [self animateWithContext:transitionContext isPresent:YES animations:^{
        toVC.view.layer.transform = CATransform3DIdentity;
        toVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
        toVC.view.layer.position = CGPointMake(0, height * 0.5);
    } completion:^(BOOL finished) {
        toVC.view.layer.transform = CATransform3DIdentity;
        toVC.view.layer.position = CGPointMake(width * 0.5, height * 0.5);
        toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }];
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.isPush) {
        [transitionContext.containerView addSubview:toVC.view];
        [transitionContext.containerView bringSubviewToFront:fromVC.view];
    }
    
    CGFloat width = transitionContext.containerView.bounds.size.width;
    CGFloat height = transitionContext.containerView.bounds.size.height;
    UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:fromSnapshotView];
    fromVC.view.hidden = YES;
    fromSnapshotView.layer.anchorPoint = CGPointMake(0, 0.5);
    fromSnapshotView.layer.position = CGPointMake(0, height * 0.5);
    CATransform3D rotateTransform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1.0, 0);
    rotateTransform.m34 = 1.0 / -500.0;
    
    [self addBackgroundViewToView:toVC.view];
    [self addShadowToView:fromSnapshotView];
    [self animateWithContext:transitionContext isPresent:NO animations:^{
        fromSnapshotView.layer.position = CGPointMake(width, height * 0.5);
        fromSnapshotView.layer.transform = rotateTransform;
    } completion:^(BOOL finished) {
        fromVC.view.hidden = NO;
        [fromSnapshotView removeFromSuperview];
    }];
}

@end
