//
//  GXAnimatedBaseDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationBaseDelegate.h"

@interface GXAnimationBaseDelegate ()
@property(nonatomic,   weak) UIViewController *presentingViewController;
@property(nonatomic, assign) BOOL isPush;
@property(nonatomic, assign) BOOL isPresentAnimationing;
@property(nonatomic, assign) BOOL interacting;
@property(nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property(nonatomic, strong) UIView *backgroundView;

@property(nonatomic,   weak) UIView *shadowSuperView;
@end

@implementation GXAnimationBaseDelegate

- (void)configureTransition:(UIViewController*)presentingViewController isPush:(BOOL)isPush interacting:(BOOL)interacting {
    self.presentingViewController = presentingViewController;
    self.isPush = isPush;
    if (presentingViewController && interacting) {
        UIScreenEdgePanGestureRecognizer *panEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGestureHandler:)];
        panEdgeGesture.edges = UIRectEdgeLeft;
        [presentingViewController.view addGestureRecognizer:panEdgeGesture];
    }
}

- (void)screenEdgePanGestureHandler:(UIScreenEdgePanGestureRecognizer*)gesture {
    UIViewController *formVC = self.presentingViewController;
    CGFloat progress = [gesture translationInView:formVC.view].x / (formVC.view.bounds.size.width);
    CGFloat velocity = [gesture velocityInView:[[UIApplication sharedApplication] keyWindow]].x;
    progress = MIN(1.0, MAX(0.0, progress));
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        self.interactivePopTransition.completionCurve = UIViewAnimationCurveEaseInOut;
        if (self.isPush) {
            [formVC.navigationController popViewControllerAnimated:YES];
        }
        else {
            [formVC dismissViewControllerAnimated:YES completion:NULL];
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        self.interacting = NO;
        if (progress > 0.4) {
            self.interactivePopTransition.completionSpeed = progress;
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else if (velocity > 800.0) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            self.interactivePopTransition.completionSpeed = progress;
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

#pragma mark - Public

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresentAnimationing = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresentAnimationing = NO;
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return (self.interacting && !self.type) ? self.interactivePopTransition : nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return (self.interacting && !self.type) ? self.interactivePopTransition : nil;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.isPresentAnimationing ? [self presentViewAnimation:transitionContext] : [self dismissViewAnimation:transitionContext];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return (self.interacting && !self.type) ? self.interactivePopTransition : nil;
}

- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //push的时候用我们自己定义的customPush
    if (operation == UINavigationControllerOperationPush) {
        self.isPresentAnimationing = YES;
        return self;
    } else if (operation == UINavigationControllerOperationPop) {
        self.isPresentAnimationing = NO;
        return self;
    }
    return nil;
}

#pragma mark - Public

- (void)addShadowToView:(UIView*)view {
    self.shadowSuperView = view;
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(-1.0f, 0.0f);
    view.layer.shadowRadius = 5.0f;
    view.layer.shadowOpacity = 0.2f;
    view.layer.shouldRasterize = YES;
    view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
}

- (void)addBackgroundViewToView:(UIView*)view {
    self.backgroundView.frame = view.bounds;
    [view addSubview:self.backgroundView];
}

- (void)animateWithContext:(id<UIViewControllerContextTransitioning>)transitionContext isPresent:(BOOL)isPresent animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isPresent) {
            self.backgroundView.alpha = 0.3f;
        }
        else {
            self.backgroundView.alpha = 0.0f;
        }
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self removeShadowToView:self.shadowSuperView];
        if (completion) {
            completion(finished);
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

#pragma mark - Private

- (void)removeShadowToView:(UIView*)view {
    view.layer.shadowOffset = CGSizeMake(0.0, -3.0);
    view.layer.shadowRadius = 3.0;
    view.layer.shadowOpacity = 0.0;
    view.layer.shouldRasterize = NO;
    view.layer.shadowPath = nil;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0f;
    }
    return _backgroundView;
}

@end
