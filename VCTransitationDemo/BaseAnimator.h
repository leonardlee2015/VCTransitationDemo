//
//  Animator.h
//  VCTransitationDemo
//
//  Created by 李南 on 15/7/29.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  an emumeration that discribes the animation move orientation.
 */
typedef NS_ENUM(NSInteger, AnimationOrientation){
    /**
     *  indicates the animation move from  left side horizontally.
     */
    AnimationOrientationHorizontalLeft,
    /**
     *  indicate the animation move from right side horizontally.
     */
    AnimationOrientationHorizontalRight,
    /**
     *  indicate the animation move up to the top  from  bottom vertically.
     */
    AnimationOrientationVerticalUp,
    /**
     *  indicate the animation move down to the bottom from the top  vertically.
     */
    AnimationOrientationVerticalDown
};
@interface BaseAnimator : NSObject <UIViewControllerAnimatedTransitioning>
/**
 *  a initialization mathod initializes with AnimationOrientation;
 *
 *  @param option an option indicates the animation transition orinetation;
 *
 *  @return an initializd object.
 */
-(instancetype)initWithAnimationOption:(AnimationOrientation)option;
@property (nonatomic) AnimationOrientation option;
@end
