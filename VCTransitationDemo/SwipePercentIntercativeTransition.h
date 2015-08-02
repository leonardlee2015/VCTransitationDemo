//
//  SwipePercentIntercativeTransition.h
//  VCTransitationDemo
//
//  Created by 李南 on 15/7/31.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  descibes the operation the swipe gesture will trigger
 */
typedef NS_ENUM(NSUInteger, SwipeInteractionOperation){
    /**
     *  indicates will tigger a Navigation pop operation.
     */
    SwipeInteractionOperationNav,
    /**
     *  indicates will tigger a tab bar selecctedviewcontroller swap operation..
     */
    SwipeInteractionOperationTab,
    /**
     *  indicates will tigger a modal dismiss operation.
     */
    SwipeInteractionOperationModal
};

@interface SwipePercentIntercativeTransition : UIPercentDrivenInteractiveTransition
@property(nonatomic) BOOL interacting;
@property(nonatomic, weak) UIViewController *toVc;
-(instancetype)initWithOperation:(SwipeInteractionOperation)operation;
-(void)writeToViewController:(UIViewController*)ViewController;
@end
