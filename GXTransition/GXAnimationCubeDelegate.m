//
//  GXTransitionCubeDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/15.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationCubeDelegate.h"

@interface GXAnimationCubeDelegate ()
@end

@implementation GXAnimationCubeDelegate

#pragma mark - Overwrite

//- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    CGFloat width = transitionContext.containerView.bounds.size.width;
//    CGFloat height = transitionContext.containerView.bounds.size.height;
//    UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    fromVC.view.hidden = YES;
//    [transitionContext.containerView addSubview:fromSnapshotView];
//    fromSnapshotView.layer.anchorPoint = CGPointMake(1.0, 0.5);
//    fromSnapshotView.layer.position = CGPointMake(width, height * 0.5);
//    CATransform3D rotateTransform1 = CATransform3DRotate(CATransform3DIdentity, M_PI_2, 0, 1.0, 0);
//    rotateTransform1.m34 = 1.0 / -500.0;
//
//    [transitionContext.containerView addSubview:toVC.view];
//    toVC.view.layer.anchorPoint = CGPointMake(0.0, 0.5);
//    toVC.view.layer.position = CGPointMake(width, height * 0.5);
//    CATransform3D rotateTransform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1.0, 0);
//    rotateTransform.m34 = 1.0 / -500.0;
//    toVC.view.layer.transform = rotateTransform;
//
//    [self addBackgroundViewToView:fromSnapshotView];
//    [self addShadowToView:toVC.view];
//    [self animateWithContext:transitionContext isPresent:YES animations:^{
//        toVC.view.layer.transform = CATransform3DIdentity;
//        toVC.view.layer.position = CGPointMake(0, height * 0.5);
//        fromSnapshotView.layer.transform = rotateTransform1;
//        fromSnapshotView.layer.position = CGPointMake(0, height * 0.5);
//    } completion:^(BOOL finished) {
//        fromVC.view.hidden = NO;
//        [fromSnapshotView removeFromSuperview];
//        toVC.view.layer.transform = CATransform3DIdentity;
//        toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
//        toVC.view.layer.position = CGPointMake(width * 0.5, height * 0.5);
//    }];
//}

//- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    if (self.isPush) {
//        [transitionContext.containerView addSubview:toVC.view];
//        [transitionContext.containerView bringSubviewToFront:fromVC.view];
//    }
//
//    CGFloat width = transitionContext.containerView.bounds.size.width;
//    CGFloat height = transitionContext.containerView.bounds.size.height;
//    UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    fromVC.view.hidden = YES;
//    [transitionContext.containerView addSubview:fromSnapshotView];
//    fromSnapshotView.layer.anchorPoint = CGPointMake(0, 0.5);
//    fromSnapshotView.layer.position = CGPointMake(0, height * 0.5);
//    CATransform3D rotateTransform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1.0, 0);
//    rotateTransform.m34 = 1.0 / -500.0;
//
//    toVC.view.layer.anchorPoint = CGPointMake(1.0, 0.5);
//    toVC.view.layer.position = CGPointMake(0, height * 0.5);
//    CATransform3D rotateTransform1 = CATransform3DRotate(CATransform3DIdentity, M_PI_2, 0, 1.0, 0);
//    rotateTransform1.m34 = 1.0 / -500.0;
//    toVC.view.layer.transform = rotateTransform1;
//
//    [self addBackgroundViewToView:toVC.view];
//    [self addShadowToView:fromSnapshotView];
//    [self animateWithContext:transitionContext isPresent:NO animations:^{
//        fromSnapshotView.layer.transform = rotateTransform;
//        fromSnapshotView.layer.position = CGPointMake(width, height * 0.5);
//        toVC.view.layer.transform = CATransform3DIdentity;
//        toVC.view.layer.position = CGPointMake(width, height * 0.5);
//    } completion:^(BOOL finished) {
//        fromVC.view.hidden = NO;
//        [fromSnapshotView removeFromSuperview];
//        toVC.view.layer.transform = CATransform3DIdentity;
//        toVC.view.layer.position = CGPointMake(width * 0.5, height * 0.5);
//        toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    }];
//}

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    CGFloat width = transitionContext.containerView.bounds.size.width;
    UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromVC.view.hidden = YES;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 0, width * 0.5);
    transform = CATransform3DRotate(transform, 0, 0, 0, 0);
    fromSnapshotView.layer.transform = transform;
    [transitionContext.containerView addSubview:fromSnapshotView];

    transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, width * 0.5, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1.0, 0);
    toVC.view.layer.transform = transform;
    [transitionContext.containerView addSubview:toVC.view];

    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = 1.0 / -1200;
    transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5);
    transitionContext.containerView.layer.sublayerTransform = transform3D;
    transform3D = CATransform3DRotate(transform3D, -M_PI_2, 0, 1.0, 0);

    [self addBackgroundViewToView:fromSnapshotView];
    [self addShadowToView:toVC.view];
    [self animateWithContext:transitionContext isPresent:YES animations:^{
        transitionContext.containerView.layer.sublayerTransform = transform3D;
    } completion:^(BOOL finished) {
        fromVC.view.hidden = NO;
        [fromSnapshotView removeFromSuperview];
        transitionContext.containerView.layer.sublayerTransform = CATransform3DIdentity;
        toVC.view.layer.transform = CATransform3DIdentity;
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

    UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:fromSnapshotView];
    fromVC.view.hidden = YES;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, width * 0.5, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1.0, 0);
    fromSnapshotView.layer.transform = transform;
    
    UIView *toSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:toSnapshotView];
    toVC.view.hidden = YES;
    transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 0, width * 0.5);
    transform = CATransform3DRotate(transform, 0, 0, 0, 0);
    toSnapshotView.layer.transform = transform;
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = 1.0 / -1200;
    transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5);
    transform3D = CATransform3DRotate(transform3D, -M_PI_2, 0, 1.0, 0);
    transitionContext.containerView.layer.sublayerTransform = transform3D;
    transform3D = CATransform3DIdentity;
    transform3D.m34 = 1.0 / -1200;
    transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5);
    
    [self addBackgroundViewToView:toSnapshotView];
    [self addShadowToView:fromSnapshotView];
    [self animateWithContext:transitionContext isPresent:NO animations:^{
        transitionContext.containerView.layer.sublayerTransform = transform3D;
    } completion:^(BOOL finished) {
        toVC.view.hidden = NO;
        fromVC.view.hidden = NO;
        [toSnapshotView removeFromSuperview];
        [fromSnapshotView removeFromSuperview];
        transitionContext.containerView.layer.sublayerTransform = CATransform3DIdentity;
    }];
}

@end
