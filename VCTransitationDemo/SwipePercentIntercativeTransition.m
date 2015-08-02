//
//  SwipePercentIntercativeTransition.m
//  VCTransitationDemo
//
//  Created by 李南 on 15/7/31.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import "SwipePercentIntercativeTransition.h"

@interface SwipePercentIntercativeTransition ()
@property (nonatomic,strong) UIViewController* presentingVC;
@property (nonatomic) BOOL shouldComplete;
@end

@implementation SwipePercentIntercativeTransition{
    SwipeInteractionOperation _opeation;
}

-(instancetype)initWithOperation:(SwipeInteractionOperation)operation{
    self = [super init];
    if (self) {
        _opeation = operation;
    }
    return self;
}
-(void)writeToViewController:(UIViewController *)ViewController
{
    self.presentingVC = ViewController;
    [self prepareGestureRecognizerInView:ViewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            if (SwipeInteractionOperationTab == _opeation) {
                UITabBarController *TBBC = self.presentingVC.tabBarController;
                if (velocity.x < 0) {
                    if (TBBC.selectedIndex < TBBC.viewControllers.count-1) {
                        //TBBC.selectedIndex++;
                        UIViewController *vc = [TBBC.viewControllers objectAtIndex:TBBC.selectedIndex+1];
                        TBBC.selectedViewController = vc;
                                            }
                }else {
                    
                    if (TBBC.selectedIndex > 0){
                        UIViewController *vc = [TBBC.viewControllers objectAtIndex:TBBC.selectedIndex - 1];
                        TBBC.selectedViewController = vc;
                        //TBBC.selectedIndex--;
                        
                    }
                }
            }
            else if(SwipeInteractionOperationModal == _opeation){
                
                [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            }else if (SwipeInteractionOperationNav == _opeation){
                
                [self.presentingVC.navigationController popViewControllerAnimated:YES];
            }
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = fabs( translation.x / 320);
            //Limit it between 0 and 1
            fraction = fminf(fraction, 1.0);
            self.shouldComplete = (fraction > 0.5);
            if (fraction >= 1.0)
                fraction = 0.99;
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {

                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
