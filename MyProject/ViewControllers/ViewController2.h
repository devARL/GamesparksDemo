//
//  ViewController2.h
//  MyProject
//
//  Created by Ali Raza on 2/25/19.
//  Copyright © 2019 Ali Raza. All rights reserved.
//
/*
#ifndef ViewController2_h
#define ViewController2_h


#endif
*/


#import <UIKit/UIKit.h>
#import "SCLAlertView.h"
#import "Reachability.h"
#import "Constant.h"


@interface ViewController2 : UIViewController <UITextFieldDelegate,UIScrollViewDelegate>

//@property (nonatomic, strong) GS *gs;

@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@property (nonatomic, strong) UILabel *lblusername1;
@property (nonatomic, strong) UITextField *txtusername1;
@property (nonatomic, strong) UILabel *lblpassword1;
@property (nonatomic, strong) UITextField *txtpassword1;
@property (nonatomic, strong) UIButton *btn1;

@property (nonatomic, strong) UILabel *lblusername2;
@property (nonatomic, strong) UITextField *txtusername2;
@property (nonatomic, strong) UILabel *lblpassword2;
@property (nonatomic, strong) UITextField *txtpassword2;
@property (nonatomic, strong) UIButton *btn2;

@property (nonatomic, strong) UIButton *scoreBtn;
@property (nonatomic, strong) UIButton *randomBtn;
@property (nonatomic, strong) UIButton *gsBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *accountDetailsBtn;
@property (nonatomic, strong) UIButton *updateUserDetailBtn;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollVw;


@property (nonatomic, strong) Constant *constant;

-(UIView *)showProgressIndicator;
-(void)stopProgressIndicator:(UIView *)overlay;
@property (nonatomic, strong) UIView *overlay;

-(void)connectWithGS;
-(void)showAlertView:(NSString *)title andSubTitle:(NSString *)subTitle andStyle:(SCLAlertViewStyle *)style;


@end
