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

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGFloat width = transitionContext.containerView.bounds.size.width;
    
    if (self.direction == GXAnimationCubeDirectionLeft) {
        UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        fromVC.view.hidden = YES;
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, 0, 0, width * 0.5);
        transform = CATransform3DRotate(transform, 0, 0, 0, 0);
        fromSnapshotView.layer.transform = transform;
        [transitionContext.containerView addSubview:fromSnapshotView];
        
        [transitionContext.containerView addSubview:toVC.view];
        transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, width * 0.5, 0, 0);
        transform = CATransform3DRotate(transform, M_PI_2, 0, 1.0, 0);
        toVC.view.layer.transform = transform;
        
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
    else {
        UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        [transitionContext.containerView addSubview:fromSnapshotView];
        fromVC.view.hidden = YES;
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, width * 0.5, 0, 0);
        transform = CATransform3DRotate(transform, M_PI_2, 0, 1.0, 0);
        fromSnapshotView.layer.transform = transform;
        
        [transitionContext.containerView addSubview:toVC.view];
        transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, 0, 0, width * 0.5);
        transform = CATransform3DRotate(transform, 0, 0, 0, 0);
        toVC.view.layer.transform = transform;
        
        CATransform3D transform3D = CATransform3DIdentity;
        transform3D.m34 = 1.0 / -1200;
        transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5);
        transform3D = CATransform3DRotate(transform3D, -M_PI_2, 0, 1.0, 0);
        transitionContext.containerView.layer.sublayerTransform = transform3D;
        transform3D = CATransform3DIdentity;
        transform3D.m34 = 1.0 / -1200;
        transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5);
        
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
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.isPush) {
        [transitionContext.containerView addSubview:toVC.view];
        [transitionContext.containerView bringSubviewToFront:fromVC.view];
    }
    CGFloat width = transitionContext.containerView.bounds.size.width;
    
    if (self.direction == GXAnimationCubeDirectionLeft) {
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
    else {
        UIView *fromSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        [transitionContext.containerView addSubview:fromSnapshotView];
        fromVC.view.hidden = YES;
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, 0, 0, width * 0.5);
        transform = CATransform3DRotate(transform, 0, 0, 0, 0);
        fromSnapshotView.layer.transform = transform;
        
        UIView *toSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:NO];
        [transitionContext.containerView addSubview:toSnapshotView];
        toVC.view.hidden = YES;
        transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, width * 0.5, 0, 0);
        transform = CATransform3DRotate(transform, M_PI_2, 0, 1.0, 0);
        toSnapshotView.layer.transform = transform;
        
        CATransform3D transform3D = CATransform3DIdentity;
        transform3D.m34 = 1.0 / -1200;
        transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5);
        transitionContext.containerView.layer.sublayerTransform = transform3D;
        transform3D = CATransform3DRotate(transform3D, -M_PI_2, 0, 1.0, 0);
        
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
}

@end
