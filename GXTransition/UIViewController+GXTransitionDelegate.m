//
//  UIViewController+GXTransitionDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import "UIViewController+GXTransitionDelegate.h"
#import <objc/runtime.h>
#import "GXAnimationPushDelegate.h"
#import "GXAnimationPushELDelegate.h"
#import "GXAnimationPushALDelegate.h"
#import "GXAnimationPushATDelegate.h"
#import "GXAnimationPushABDelegate.h"
#import "GXAnimationSectorDelegate.h"
#import "GXAnimationErectDelegate.h"
#import "GXAnimationCubeDelegate.h"
#import "GXAnimationOglFlipDelegate.h"
#import "GXAnimationSystemDelegate.h"

@implementation UIViewController (GXTransitionDelegate)

static const char GX_DELEGATE = '\0';
- (void)setGx_animatedDelegate:(GXAnimationBaseDelegate *)gx_animatedDelegate {
    objc_setAssociatedObject(self, &GX_DELEGATE, gx_animatedDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GXAnimationBaseDelegate *)gx_animatedDelegate {
    return objc_getAssociatedObject(self, &GX_DELEGATE);
}

#pragma mark - Utility

- (void)gx_pushViewController:(UIViewController *)viewController style:(GXAnimationStyle)style interacting:(BOOL)interacting {
    [self gotoViewController:viewController isPush:YES style:style interacting:interacting completion:nil];
}

- (void)gx_presentViewController:(UIViewController *)viewControllerToPresent style:(GXAnimationStyle)style interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion {
    [self gotoViewController:viewControllerToPresent isPush:NO style:style interacting:interacting completion:completion];
}

- (void)gx_pushViewController:(UIViewController *)viewController style:(GXTransitionStyle)style subtype:(nullable CATransitionSubtype)subtype interacting:(BOOL)interacting {
    [self gotoViewController:viewController isPush:YES style:style subtype:subtype interacting:interacting completion:nil];
}

- (void)gx_presentViewController:(UIViewController *)viewControllerToPresent style:(GXTransitionStyle)style subtype:(nullable CATransitionSubtype)subtype interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion {
    [self gotoViewController:viewControllerToPresent isPush:NO style:style subtype:subtype interacting:interacting completion:completion];
}

#pragma mark - Private

- (void)gotoViewController:(UIViewController*)vc isPush:(BOOL)isPush style:(GXAnimationStyle)style interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion {
    switch (style) {
        case GXAnimationStylePush:
            self.gx_animatedDelegate = [[GXAnimationPushDelegate alloc] init];
            break;
        case GXAnimationStylePushEdgeLeft:
            self.gx_animatedDelegate = [[GXAnimationPushELDelegate alloc] init];
            break;
        case GXAnimationStylePushAllLeft:
            self.gx_animatedDelegate = [[GXAnimationPushALDelegate alloc] init];
            break;
        case GXAnimationStylePushAllTop:
            self.gx_animatedDelegate = [[GXAnimationPushATDelegate alloc] init];
            break;
        case GXAnimationStylePushAllBottom:
            self.gx_animatedDelegate = [[GXAnimationPushABDelegate alloc] init];
            break;
        case GXAnimationStyleSector:
            self.gx_animatedDelegate = [[GXAnimationSectorDelegate alloc] init];
            break;
        case GXAnimationStyleErect:
            self.gx_animatedDelegate = [[GXAnimationErectDelegate alloc] init];
            break;
        case GXAnimationStyleCube:
            self.gx_animatedDelegate = [[GXAnimationCubeDelegate alloc] init];
            break;
        case GXAnimationStyleOglFlip:
            self.gx_animatedDelegate = [[GXAnimationOglFlipDelegate alloc] init];
            break;
        default:break;
    }
    [self.gx_animatedDelegate configureTransition:vc isPush:isPush interacting:interacting];
    if (isPush) {
        self.navigationController.delegate = self.gx_animatedDelegate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        vc.transitioningDelegate = self.gx_animatedDelegate;
        vc.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:vc animated:YES completion:completion];
    }
}

- (void)gotoViewController:(UIViewController*)vc isPush:(BOOL)isPush style:(GXTransitionStyle)style subtype:(CATransitionSubtype)subtype interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion {
    self.gx_animatedDelegate = [[GXAnimationSystemDelegate alloc] init];
    switch (style) {
        case GXTransitionStyleFade: {
            self.gx_animatedDelegate.type = kCATransitionFade;
        }
            break;
        case GXTransitionStylePush: {
            self.gx_animatedDelegate.type = kCATransitionPush;
            self.gx_animatedDelegate.subtype = subtype;
        }
            break;
        case GXTransitionStyleMoveInReveal: {
            self.gx_animatedDelegate.type = kCATransitionMoveIn;
            self.gx_animatedDelegate.subtype = subtype;
        }
            break;
        case GXTransitionStyleCube: {
            self.gx_animatedDelegate.type = @"cube";
            self.gx_animatedDelegate.subtype = subtype;
        }
            break;
        case GXTransitionStyleOglFlip: {
            self.gx_animatedDelegate.type = @"oglFlip";
            self.gx_animatedDelegate.subtype = subtype;
        }
            break;
        case GXTransitionStylePageCurl: {
            self.gx_animatedDelegate.type = @"pageCurl";
            self.gx_animatedDelegate.subtype = subtype;
        }
            break;
        case GXTransitionStyleCameralIris: {
            self.gx_animatedDelegate.type = @"cameraIrisHollowOpen";
        }
            break;
        case GXTransitionStyleSuckEffect: {
            self.gx_animatedDelegate.type = @"suckEffect";
        }
            break;
        case GXTransitionStyleRippleEffect: {
            self.gx_animatedDelegate.type = @"rippleEffect";
        }
            break;
        default:break;
    }
    [self.gx_animatedDelegate configureTransition:vc isPush:isPush interacting:interacting];
    if (isPush) {
        self.navigationController.delegate = self.gx_animatedDelegate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        vc.transitioningDelegate = self.gx_animatedDelegate;
        vc.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:vc animated:YES completion:completion];
    }
}

@end
