//
//  GXAnimationSystemDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/13.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationSystemDelegate.h"

@interface GXAnimationSystemDelegate()<CAAnimationDelegate>
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) UIView *toSnapshotView;
@end

@implementation GXAnimationSystemDelegate

#pragma mark - Overwrite

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext.containerView addSubview:toVC.view];
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = self.type;
    animation.subtype = self.subtype;
    [fromVC.view.window.layer addAnimation:animation forKey:@"GXAnimationSystemPresent"];
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.isPush) {
        [transitionContext.containerView addSubview:toVC.view];
    }
    else {
        toVC.view.hidden = YES;
        self.toSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:NO];
        [transitionContext.containerView addSubview:self.toSnapshotView];
    }
    [self resetDismissAnimationType];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = self.type;
    animation.subtype = self.subtype;
    [transitionContext.containerView.layer addAnimation:animation forKey:@"GXAnimationSystemDismiss"];
}

- (void)resetDismissAnimationType {
    if ([self.type isEqualToString:@"pageCurl"]) {
        self.type = @"pageUnCurl"; //不需要逆方向
        return;
    }
    if ([self.type isEqualToString:kCATransitionMoveIn]) {
        self.type = kCATransitionReveal;
    }
    else if ([self.type isEqualToString:@"cameraIrisHollowOpen"]) {
        self.type = @"cameraIrisHollowClose";
    }
    if (self.subtype) {
        if ([self.subtype isEqualToString: kCATransitionFromTop]) {
            self.subtype = kCATransitionFromBottom;
        }
        else if ([self.subtype isEqualToString: kCATransitionFromLeft]) {
            self.subtype = kCATransitionFromRight;
        }
        else if ([self.subtype isEqualToString: kCATransitionFromRight]) {
            self.subtype = kCATransitionFromLeft;
        }
        else if ([self.subtype isEqualToString: kCATransitionFromBottom]) {
            self.subtype = kCATransitionFromTop;
        }
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.hidden = NO;
    [self.toSnapshotView removeFromSuperview];
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

@end
