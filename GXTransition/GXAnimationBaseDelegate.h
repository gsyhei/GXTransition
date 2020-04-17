//
//  GXAnimatedBaseDelegate.h
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXAnimationBaseDelegate : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>

@property(readonly) BOOL isPush;

/** 自带转场动画属性（设置GXTransitionStyle时有效）*/
@property(nonatomic, copy) CATransitionType type;
@property(nonatomic, nullable, copy) CATransitionSubtype subtype;

- (void)configureTransition:(UIViewController*)presentingViewController isPush:(BOOL)isPush interacting:(BOOL)interacting;

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)addShadowToView:(UIView*)view;
- (void)addBackgroundViewToView:(UIView*)view;
- (void)animateWithContext:(id<UIViewControllerContextTransitioning>)transitionContext isPresent:(BOOL)isPresent animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
