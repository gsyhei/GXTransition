//
//  GXTransitionCubeDelegate.h
//  GXTransitionSample
//
//  Created by Gin on 2020/4/15.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationBaseDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GXAnimationCubeDirection) {
    GXAnimationCubeDirectionLeft = 0,
    GXAnimationCubeDirectionRight
};

@interface GXAnimationCubeDelegate : GXAnimationBaseDelegate

@property (nonatomic, assign) GXAnimationCubeDirection direction;

@end

NS_ASSUME_NONNULL_END
