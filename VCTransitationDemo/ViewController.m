//
//  ViewController.m
//  VCTransitationDemo
//
//  Created by 李南 on 15/7/29.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "BaseAnimator.h"
#import "SwipePercentIntercativeTransition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
//@property (nonatomic, strong) Animator *animator;
@property(nonatomic, strong) SwipePercentIntercativeTransition * interactiveController;
//@property(nonatomic, strong) UIPercentDrivenInteractiveTransition * interactiveController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //  configure  storyboard view by code test.
    UIButton *button = (UIButton*)[self.view viewWithTag:2];
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor]];
    button.layer.cornerRadius = 5.0f;
    // init animation
    // self.animator = [[Animator alloc]init];
    // init an adopt interactiveTransitioning object.
    //_interactiveController = [[UIPercentDrivenInteractiveTransition alloc] init];
    //_interactiveController.completionCurve = UIViewAnimationCurveLinear;
    _interactiveController = [[SwipePercentIntercativeTransition alloc]initWithOperation:SwipeInteractionOperationModal];

    
}
/*
-(void)pan:(UIPanGestureRecognizer*)gesture{
    CGPoint transilation = [gesture translationInView:gesture.view.superview];
    static CGFloat perComplete ;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            perComplete = 0.0f;
            [self  dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            // caculate the  interaction transition complete percentage
            if (self.presentedViewController) {
               // NSLog(@"bounds with : %f", self.view.bounds.size.width);
            }
            
            perComplete = transilation.x / 375;
            
            perComplete = fminf(fmaxf(perComplete, 0.0f), 1.0f);
            
            
            [self.interactiveController updateInteractiveTransition:perComplete];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            //NSLog(@"per:%f",perComplete);
            if (perComplete >= 0.5) {
                [self.interactiveController finishInteractiveTransition];
            }
            else{
                [self.interactiveController cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
    
}
 */
- (IBAction)click:(UIButton *)sender {
    // push a modal view by modal style.
    ModalViewController * mvc = [[ModalViewController alloc]init];
    //mvc.modalTransitionStyle = UIModalPresentationCustom;
    mvc.transitioningDelegate = self;
    // add a gesture recognizer for seconds for interaction animation.
    //UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    //[mvc.view addGestureRecognizer:pan];
    [self.interactiveController writeToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[BaseAnimator alloc] initWithAnimationOption:AnimationOrientationHorizontalRight];
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[BaseAnimator alloc]initWithAnimationOption:AnimationOrientationHorizontalLeft];
}
/* 
 * everytimes presented view controller dismiss itself ,if implement this mathod, the sys will invole  this mathods, no matter how tigger this event.
 *
 */
 -(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    static int count = 0;
    count++;
    NSLog(@"count: %d", count);
     return self.interactiveController.interacting? self.interactiveController : nil;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

@end
