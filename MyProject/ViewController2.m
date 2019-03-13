//
//  ViewController2.m
//  MyProject
//
//  Created by Ali Raza on 2/25/19.
//  Copyright © 2019 Ali Raza. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewController2.h"
#import "GS.h"
#import "GSAPI.h"
#import "SCLAlertView.h"
#import "Reachability.h"

@interface ViewController2 () {
    
}

@end

@implementation ViewController2

-(void)viewDidLoad {
    [super viewDidLoad];
    
   _constant = [[Constant alloc] init];
    
   // self.gs = [[GS alloc] initWithApiKey:@"Z377511JkuRX" andApiSecret:@"ghN96ht3uahh8BEomE2BGKslAlasKhLE" andCredential:@"" andPreviewMode:true];
    //[self.gs connect];

    [self connectWithGS];
    
    [self createUser1UI];
    [self createUser2UI];
    [self scoreBtnUI];
   [self randomBtnUI];
    [self btnGS];
    [self registerUI];
   [self accountDetailsBtnUI];
    [self updateUserDetailBtnUI];
    
}

-(void)checkInternetConnectivity{
    if (![[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable){
        //connected with internet
         [self showAlertView:@"Internet Connected" andSubTitle:@"You are connected to the internet" andStyle:SCLAlertViewStyleInfo];
    }
    else {
        //not connected with inbternet
        [self showAlertView:@"Internet Problem" andSubTitle:@"The internet conenction appears to be offline" andStyle:SCLAlertViewStyleInfo];
    }
}

-(void)btnGS{
    self.gsBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.gsBtn.backgroundColor = UIColor.blueColor;
    //[self.gsBtn setTitle:@"Call Random API" forState:UIControlStateNormal];
    [self.gsBtn setTitle:@"Connect With GS" forState:UIControlStateNormal];
    
    self.gsBtn.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 380.0f, 200.0f, 30.0f);
    [self.gsBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.gsBtn.titleLabel.textColor = UIColor.whiteColor;
    self.gsBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.gsBtn addTarget:self action:@selector(connectWithGS) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.gsBtn];
}

-(void)connectWithGS{
    
//    _constant = [[Constant alloc] init];
    [_constant connectWithGS];
    NSLog(@"%@",[[_constant gs] isAuthenticated]);
    
     //self.gs = [[GS alloc] initWithApiKey:@"Z377511JkuRX" andApiSecret:@"ghN96ht3uahh8BEomE2BGKslAlasKhLE" andCredential:@"" andPreviewMode:true];
    
   /*[self.gs setAvailabilityListener:^(BOOL available) {
        if(available){
            NSLog(@"GS available");
        }
    }];*/
    
   // [self.gs connect];
}

-(void)registerUI{
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.registerBtn.backgroundColor = UIColor.blueColor;
    [self.registerBtn setTitle:@"Register User" forState:UIControlStateNormal];
    self.registerBtn.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 420.0f, 200.0f, 30.0f);
    [self.registerBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.registerBtn.titleLabel.textColor = UIColor.whiteColor;
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.registerBtn];
}

-(void)registerUser{
 self.overlay = [self showProgressIndicator];
    
    GSRegistrationRequest* request = [[GSRegistrationRequest alloc] init];
    [request setDisplayName:@"player13"];
    [request setPassword:@"1"];
    [request setUserName:@"player13"];
    [request setCallback:^ (GSRegistrationResponse* response){
        NSDictionary *dict = response._data;
        if(dict[@"error"] != nil){
            [self stopProgressIndicator:self.overlay];
            //check error and show pop up (SCLAlertView)
            NSDictionary *d2 = dict[@"error"];
            if(d2[@"USERNAME"] != nil){
                //show pop up : username is taken
                     [self showAlertView:@"Registration Error" andSubTitle:@"Username is already taken" andStyle:SCLAlertViewStyleError];
            }
            else if(d2[@"error"] != nil){
                NSString *s = d2[@"error"];
                NSLog(@"error: %@",s);
                 [self showAlertView:@"Registration Error" andSubTitle:s andStyle:SCLAlertViewStyleError];
            }
        }
        else{
            [self setUserDetail];
        }
    }];
    [[_constant gs] send:request];
    
}

-(void)setUserDetail{
    GSLogEventRequest* request = [[GSLogEventRequest alloc] init];
    [request setEventKey:@"setDetails"];
    [request setEventAttribute:@"name" withString:@"player7"];
    [request setEventAttribute:@"gender" withString:@"male"];
    [request setEventAttribute:@"email" withString:@"player7@gmail.com"];
    [request setEventAttribute:@"age" withNumber:[NSNumber numberWithInt:10]];
    [request setCallback:^ (GSLogEventResponse* response){
        [self stopProgressIndicator:self.overlay];
        
        NSLog(@"Set User Detail Response: %@",response._data);
        NSDictionary *dict = response._data;
        if(dict[@"error"] != nil){
            NSDictionary *d2 = dict[@"error"];
            if(d2[@"error"] != nil){
                NSString *s = d2[@"error"];
                NSLog(@"error: %@",s);
                 [self showAlertView:@"Registration Error" andSubTitle:s andStyle:SCLAlertViewStyleError];
            }
        }
        else {
            NSDictionary *data = response._data;
            NSDictionary *scriptData = data[@"scriptData"];
            NSNumber *age = scriptData[@"age"];
            NSString *email = scriptData[@"email"];
            NSString *gender = scriptData[@"gender"];
            NSString *name = scriptData[@"name"];
            NSLog(@"age: %@",age);
            NSLog(@"email: %@",email);
            NSLog(@"gender: %@",gender);
            NSLog(@"name: %@",name);
             [self showAlertView:@"Congratulations!" andSubTitle:@"Registration Successfull" andStyle:SCLAlertViewStyleSuccess];
        }
    }];
    [[_constant gs] send:request];
}

-(void)accountDetailsBtnUI{
    self.accountDetailsBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.accountDetailsBtn.backgroundColor = UIColor.blueColor;
    [self.accountDetailsBtn setTitle:@"User Details" forState:UIControlStateNormal];
    self.accountDetailsBtn.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 460.0f, 200.0f, 30.0f);
    [self.accountDetailsBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.accountDetailsBtn.titleLabel.textColor = UIColor.whiteColor;
    self.accountDetailsBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.accountDetailsBtn addTarget:self action:@selector(userAccountDetailRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.accountDetailsBtn];
}

-(void)userAccountDetailRequest{
    self.overlay = [self showProgressIndicator];
    
    GSAccountDetailsRequest* request = [[GSAccountDetailsRequest alloc] init];
    [request setCallback:^ (GSAccountDetailsResponse* response){
         [self stopProgressIndicator:self.overlay];
        NSDictionary *data = response._data;
        
        NSDictionary *currenciesDict = data[@"currencies"];
        NSNumber *currecncy1 = data[@"currency1"];
        NSNumber *currecncy2 = data[@"currency2"];
        NSNumber *currecncy3 = data[@"currency3"];
        NSNumber *currecncy4 = data[@"currency4"];
        NSNumber *currecncy5 = data[@"currency5"];
        NSNumber *currecncy6 = data[@"currency6"];
        NSString *displayName = data[@"displayName"];
        NSDictionary *externalIds = data[@"externalIds"];
        NSDictionary *location = data[@"location"];
        NSString *city = location[@"city"];
        NSString *country = location[@"country"];
        NSString *latitude = location[@"latitide"];
        NSString *longitude = location[@"longditute"];
        NSDictionary *reservedCurrencies = data[@"reservedCurrencies"];
        NSDictionary *reservedCurrency1 = data[@"reservedCurrency1"];
        NSDictionary *reservedCurrency2 = data[@"reservedCurrency2"];
        NSDictionary *reservedCurrency3 = data[@"reservedCurrency3"];
        NSDictionary *reservedCurrency4 = data[@"reservedCurrency4"];
        NSDictionary *reservedCurrency5 = data[@"reservedCurrency5"];
        NSDictionary *reservedCurrency6 = data[@"reservedCurrency6"];
        NSDictionary *scriptData = data[@"scriptData"];
        NSNumber *age = scriptData[@"age"];
        NSString *email = scriptData[@"email"];
        NSString *gender = scriptData[@"gender"];
        NSString *name = scriptData[@"name"];
        NSString *userId = data[@"userId"];
        NSDictionary *virtualGoods = data[@"virtualGoods"];
        
        NSLog(@"response: %@",response);
    }];
    
    [[_constant gs] send:request];
}

-(void)authenticateUser{
    
}

-(void)randomBtnUI{
    self.randomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.randomBtn.backgroundColor = UIColor.blueColor;
    [self.randomBtn setTitle:@"Call Random API" forState:UIControlStateNormal];
    self.randomBtn.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 340.0f, 200.0f, 30.0f);
    [self.randomBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.randomBtn.titleLabel.textColor = UIColor.whiteColor;
    self.randomBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    //[self.randomBtn addTarget:self action:@selector(callRandomAPI) forControlEvents:UIControlEventTouchUpInside];
    [self.randomBtn addTarget:self action:@selector(checkInternetConnectivity) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.randomBtn];
}

-(void)scoreBtnUI{
    self.scoreBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.scoreBtn.backgroundColor = UIColor.blueColor;
    [self.scoreBtn setTitle:@"Score" forState:UIControlStateNormal];
    self.scoreBtn.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 300.0f, 200.0f, 30.0f);
    [self.scoreBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.scoreBtn.titleLabel.textColor = UIColor.whiteColor;
    self.scoreBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.scoreBtn addTarget:self action:@selector(scoreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.scoreBtn];
}

-(void)scoreBtnAction{
    [self.txtusername1 setText:@"username 1"];
    [self.txtpassword1 setText:@"password 1"];
    [self.txtusername2 setText:@"username 2"];
    [self.txtpassword2 setText:@"password 2"];
}

-(void)sclAlertViewLib{
    //https://cocoapods.org/pods/SCLAlertView-Objective-C
    
    //easy to use:
    // SCLAlertView *alert = [[SCLAlertView alloc] init];
    // [alert showSuccess:@"" subTitle:@"Hello world" closeButtonTitle:@"Done" duration:0.0f];
    
    //  [alert showSuccess:self title:@"Success" subTitle:@"sub title" closeButtonTitle:@"clos button title" duration:0.0f];
    //[alert showEdit:self title:@"Edit" subTitle:@"sub title" closeButtonTitle:@"clos button title" duration:0.0f];
    
    //[alert showInfo:self title:@"Info" subTitle:@"sub title" closeButtonTitle:@"close button title" duration:0.0f];
    //[alert showError:self title:@"Error" subTitle:@"sub title" closeButtonTitle:@"close button title" duration:0.0f];
    
    //[alert showNotice:self title:@"Notice" subTitle:@"sub title" closeButtonTitle:@"close button title" duration:0.0f];
    // [alert showWaiting:self title:@"Waiting" subTitle:@"sub title" closeButtonTitle:@"close button title" duration:0.0f];
    
    //  [alert showWarning:self title:@"Warning" subTitle:@"sub title" closeButtonTitle:@"close button title" duration:0.0f];
    //  [alert showQuestion:self title:@"Question" subTitle:@"sub title" closeButtonTitle:@"close button title" duration:10.0f];
    
    // [alert showTitle:self title:@"title" subTitle:@"sub title" style:SCLAlertViewStyleInfo closeButtonTitle:@"close button title" duration:0.0f];
    /*
     [alert showCustom:self image:<#(UIImage *)#> color:<#(UIColor *)#> title:<#(NSString *)#> subTitle:<#(NSString *)#> closeButtonTitle:<#(NSString *)#> duration:<#(NSTimeInterval)#>];
     */
    
    
    //Fluent style:
    /*UIImageView *imgVw = [[UIImageView alloc] init];
     UIImage *img = [[UIImage alloc]
     [imgVw setImage:];
     */
    
    
    //
    /* SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
     .addButtonWithActionBlock(@"Send", ^{
     NSLog(@"hello world");
     });
     
     SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
     .style(SCLAlertViewStyleWarning)
     .title(@"Title")
     .subTitle(@"Subtitle")
     .duration(0);
     
     // [showBuilder showAlertView:builder.alertView onViewController:self];
     showBuilder.show(builder.alertView, self);
     */
    
    //complex:
    NSString *title = @"Title";
    NSString *message = @"Message";
    NSString *cancel = @"Cancel";
    NSString *done = @"Done";
    
    SCLALertViewTextFieldBuilder *textField = [SCLALertViewTextFieldBuilder new].title(@"Code");
    SCLALertViewButtonBuilder *doneButton = [SCLALertViewButtonBuilder new].title(done)
    .validationBlock(^BOOL{
        NSLog(@"validate block");
        NSString *code = [textField.textField.text copy];
        //return [code isVisible];
        return true;
    })
    .actionBlock(^{
        NSString *code = [textField.textField.text copy];
        //[self confirmPhoneNumberWithCode:code];
        NSLog(@"action block");
        NSLog(@"text: %@",textField.textField.text);
    });
    
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .showAnimationType(SCLAlertViewShowAnimationFadeIn)
    .hideAnimationType(SCLAlertViewHideAnimationFadeOut)
    .shouldDismissOnTapOutside(NO)
    .addTextFieldWithBuilder(textField)
    .addButtonWithBuilder(doneButton);
    
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleCustom)
    .color([UIColor blueColor])
    .title(title)
    .subTitle(message)
    .closeButtonTitle(cancel)
    .duration(0.0f);
    
    [showBuilder showAlertView:builder.alertView onViewController:self];
    
}

-(void)callRandomAPI{

    /*[self.txtusername1 setText:@""];
    [self.txtpassword1 setText:@""];
    [self.txtusername2 setText:@""];
    [self.txtpassword2 setText:@""];*/
}

-(void)createUser1UI{
    self.lblusername1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 50.0f, 110.0f, 30.0f)];
    [self.lblusername1 setText:@"Player1 username:"];
    self.lblusername1.font = [UIFont systemFontOfSize:12.0];
    self.lblusername1.textColor = UIColor.blackColor;
    [self.scrollVw addSubview:self.lblusername1];
    
    self.txtusername1 = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 50.0f, (self.view.frame.size.width - 140.0), 30.0f)];
    self.txtusername1.borderStyle = UITextBorderStyleRoundedRect;
    self.txtusername1.delegate  = self;
    [self.scrollVw addSubview:self.txtusername1];
    
    self.lblpassword1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 90.0f, 110.0f, 30.0f)];
    [self.lblpassword1 setText:@"Player1 password:"];
    self.lblpassword1.font = [UIFont systemFontOfSize:12.0];
    self.lblpassword1.textColor = UIColor.blackColor;
    [self.scrollVw addSubview:self.lblpassword1];
    
    self.txtpassword1 = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 90.0f, (self.view.frame.size.width - 140.0), 30.0f)];
    self.txtpassword1.borderStyle = UITextBorderStyleRoundedRect;
    self.txtpassword1.delegate  = self;
    [self.scrollVw addSubview:self.txtpassword1];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn1.backgroundColor = UIColor.blueColor;
    [self.btn1 setTitle:@"Login Player 1" forState:UIControlStateNormal];
    self.btn1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 130.0f, 200.0f, 30.0f);
    [self.btn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.btn1.titleLabel.textColor = UIColor.whiteColor;
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.btn1 addTarget:self action:@selector(loginUser1) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.btn1];

}

-(void)loginUser1{
     self.overlay = [self showProgressIndicator];
    
    GSAuthenticationRequest* request = [[GSAuthenticationRequest alloc] init];
    [request setUserName:@"player13"];
    [request setPassword:@"1"];
    [request setCallback:^ (GSAuthenticationResponse* response){
         [self stopProgressIndicator:self.overlay];
        NSDictionary *data = response._data;
        if(data[@"error"] != nil){
            NSDictionary *d2 = data[@"error"];
            if([d2[@"DETAILS"]  isEqual: @"UNRECOGNISED"]){
                [self showAlertView:@"Login Error" andSubTitle:@"Username or password is incorrect" andStyle:SCLAlertViewStyleError];
            }
        }
        else {
            NSString *authToken = data[@"authToken"];
            NSString *displayName = data[@"displayName"];
            NSString *userId = data[@"userId"];
            NSNumber *isNewPlayer = data[@"newPlayer"];
        }
        
    }];
    [[_constant gs] send:request];
    
    //[self.gs send:request];
    
 /*   UIImage *img = [UIImage imageNamed:@"info"];
    UIImageView *imgVw = [[UIImageView alloc] initWithImage:img];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert showCustom:self image:img color:UIColor.blueColor title:@"Title" subTitle:@"SubTitle" closeButtonTitle:@"" duration:0.0f];
*/
   // [self showAlertView:@"title" andSubTitle:@"sub title!" andStyle:SCLAlertViewStyleWarning];
    
  // self.overlay = [self showProgressIndicator];
    /*SCLAlertView *alert = [[SCLAlertView alloc] init];
   // [alert showInfo:self title:@"Registration Error" subTitle:s closeButtonTitle:@"Dismiss" duration:0.0f];
    [alert showWaiting:self title:@"Waiting" subTitle:@"" closeButtonTitle:@"dismiss" duration:5.0f];*/
    
  /*  self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //self.spinner.center = CGPointMake(self.view.frame.size.width/4, self.view.frame.size.height/4);
    self.spinner.center = self.view.center;
    self.view.alpha = 0.4;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    
    [self.txtusername1 setText:@"username 1"];
    [self.txtpassword1 setText:@"password 1"];
    */
}

-(void)createUser2UI{
    self.lblusername2 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 180.0f, 110.0f, 30.0f)];
    [self.lblusername2 setText:@"Player2 username:"];
    self.lblusername2.font = [UIFont systemFontOfSize:12.0];
    self.lblusername2.textColor = UIColor.blackColor;
    [self.scrollVw addSubview:self.lblusername2];
    
    self.txtusername2 = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 180.0f, (self.view.frame.size.width - 140.0), 30.0f)];
    self.txtusername2.borderStyle = UITextBorderStyleRoundedRect;
    self.txtusername2.delegate  = self;
    [self.scrollVw addSubview:self.txtusername2];
    
    self.lblpassword2 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 220.0f, 110.0f, 30.0f)];
    [self.lblpassword2 setText:@"Player2 password:"];
    self.lblpassword2.font = [UIFont systemFontOfSize:12.0];
    self.lblpassword2.textColor = UIColor.blackColor;
    [self.scrollVw addSubview:self.lblpassword2];
    
    self.txtpassword2 = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 220.0f, (self.view.frame.size.width - 140.0), 30.0f)];
    self.txtpassword2.borderStyle = UITextBorderStyleRoundedRect;
    self.txtpassword2.delegate  = self;
    [self.scrollVw addSubview:self.txtpassword2];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn2.backgroundColor = UIColor.blueColor;
    [self.btn2 setTitle:@"Login Player 2" forState:UIControlStateNormal];
    self.btn2.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 260.0f, 200.0f, 30.0f);
    [self.btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.btn2.titleLabel.textColor = UIColor.whiteColor;
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.btn2 addTarget:self action:@selector(loginUser2) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.btn2];
    
    
}


-(void)loginUser2{
    
    self.overlay = [self showProgressIndicator];
    
    GSAuthenticationRequest* request = [[GSAuthenticationRequest alloc] init];
    [request setUserName:@"player1"];
    [request setPassword:@"1"];
    [request setCallback:^ (GSAuthenticationResponse* response){
        [self stopProgressIndicator:self.overlay];
        NSDictionary *data = response._data;
        if(data[@"error"] != nil){
            NSDictionary *d2 = data[@"error"];
            if([d2[@"DETAILS"]  isEqual: @"UNRECOGNISED"]){
                [self showAlertView:@"Login Error" andSubTitle:@"Username or password is incorrect" andStyle:SCLAlertViewStyleError];
            }
        }
        else {
            NSString *authToken = data[@"authToken"];
            NSString *displayName = data[@"displayName"];
            NSString *userId = data[@"userId"];
            NSNumber *isNewPlayer = data[@"newPlayer"];
        }
        
    }];
    [[_constant gs] send:request];
    //[self.gs send:request];
    
    //[self stopProgressIndicator:self.overlay];
   /* SCLAlertView *alert = [[SCLAlertView alloc] init];
    // [alert showInfo:self title:@"Registration Error" subTitle:s closeButtonTitle:@"Dismiss" duration:0.0f];
    [alert showWaiting:self title:@"Waiting" subTitle:@"" closeButtonTitle:@"dismiss" duration:0.0f];
    */
    
    /*
    [self.spinner stopAnimating];
    [self.spinner removeFromSuperview];
    self.view.alpha = 1.0;
    [self.txtusername2 setText:@"username 2"];
    [self.txtpassword2 setText:@"password 2"];*/
}


-(void)updateUserDetailBtnUI{
    self.updateUserDetailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.updateUserDetailBtn.backgroundColor = UIColor.blueColor;
    [self.updateUserDetailBtn setTitle:@"Update Details" forState:UIControlStateNormal];
    self.updateUserDetailBtn.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50.0, 500.0f, 200.0f, 30.0f);
    [self.updateUserDetailBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.updateUserDetailBtn.titleLabel.textColor = UIColor.whiteColor;
    self.updateUserDetailBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.updateUserDetailBtn addTarget:self action:@selector(updateUserName) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollVw addSubview:self.updateUserDetailBtn];
}

-(void)updateuserDetailRequest{
    self.overlay = [self showProgressIndicator];
    
    GSLogEventRequest *request = [[GSLogEventRequest alloc] init];
    [request setEventKey:@"updateEmail"];
    [request setEventAttribute:@"email" withString:@"a@a.com"];
    [request setCallback:^ (GSLogEventResponse* response){
        [self stopProgressIndicator:self.overlay];
        NSLog(@"response %@",response._data);
    }];
 [[_constant gs] send:request];
//    [self.gs send:request];
    
 /*   GSLogEventRequest *request = [[GSLogEventRequest alloc] init];
    [request setEventKey:@"updateFirstName"];
    [request setEventAttribute:@"firstName" withString:@"sdas"];
    [request setCallback:^ (GSLogEventResponse* response){
        [self stopProgressIndicator:self.overlay];
        NSLog(@"response %@",response._data);
    }];
    [self.gs send:request];
  
  
    GSLogEventRequest *request = [[GSLogEventRequest alloc] init];
    [request setEventKey:@"updateLastName"];
    [request setEventAttribute:@"email" withString:@"asgs"];
    [request setCallback:^ (GSLogEventResponse* response){
        [self stopProgressIndicator:self.overlay];
        NSLog(@"response %@",response._data);
    }];
    [self.gs send:request];*/
}

-(void)updateUserName{
    self.overlay = [self showProgressIndicator];
    
    GSChangeUserDetailsRequest *request = [[GSChangeUserDetailsRequest alloc] init];
    [request setUserName:@"player13"];
    [request setCallback:^ (GSChangeUserDetailsResponse* response){
        [self stopProgressIndicator:self.overlay];
        NSDictionary *data = response._data;
        if(data[@"error"] != nil){
            NSDictionary *d2 = data[@"error"];
            if([d2[@"error"]  isEqual: @"timeout"]){
                [self showAlertView:@"Error" andSubTitle:@"Timeout" andStyle:SCLAlertViewStyleError];
            }
            else if([d2[@"USERNAME"] isEqual: @"TAKEN"]){
                  [self showAlertView:@"Error" andSubTitle:@"This username is already taken" andStyle:SCLAlertViewStyleError];
            }
        }
        else{
              NSLog(@"response %@",response._data);
        }
      
        
    }];
  //  [self.gs send:request];
[[_constant gs] send:request];

}

-(void)updateDisplayName{
    self.overlay = [self showProgressIndicator];
    
    GSChangeUserDetailsRequest *request = [[GSChangeUserDetailsRequest alloc] init];
    [request setDisplayName:@"player13"];
    [request setCallback:^ (GSChangeUserDetailsResponse* response){
        [self stopProgressIndicator:self.overlay];
        NSLog(@"response %@",response._data);
        
    }];
    [[_constant gs] send:request];
//    [self.gs send:request];
}

-(void)updatePassword{
    self.overlay = [self showProgressIndicator];
    
    GSChangeUserDetailsRequest *request = [[GSChangeUserDetailsRequest alloc] init];
    [request setOldPassword:@"1"];
    [request setNewPassword:@"1"];
    [request setCallback:^ (GSChangeUserDetailsResponse* response){
        [self stopProgressIndicator:self.overlay];
        NSLog(@"response %@",response._data);
        
    }];
    [[_constant gs] send:request];
//    [self.gs send:request];
}


-(void)viewWillAppear:(BOOL)animated{
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return false;
}

-(UIView *)showProgressIndicator{
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.frame];
    overlay.backgroundColor = UIColor.blackColor;
    overlay.alpha = 0.8;
    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingIndicator.frame = CGRectMake(0.0,0.0,40.0,40.0);
    loadingIndicator.center = self.view.center;
    loadingIndicator.hidesWhenStopped = true;
    [loadingIndicator startAnimating];
    [overlay addSubview:loadingIndicator];
    [self.view addSubview:overlay];
    return overlay;
}

-(void)stopProgressIndicator:(UIView *)overlayView{
    [overlayView removeFromSuperview];
}

-(void)showAlertView:(NSString *)title andSubTitle:(NSString *)subTitle andStyle:(SCLAlertViewStyle *)style{
    
    /* SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
     .addButtonWithActionBlock(@"Send", ^{
     NSLog(@"hello world");
     });*/
    
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new];
    
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(style)
    .title(title)
    .subTitle(subTitle)
    .duration(3.0);
    
    // [showBuilder showAlertView:builder.alertView onViewController:self];
    showBuilder.show(builder.alertView, self);
    
    /*
     SCLAlertView *alert = [[SCLAlertView alloc] init];
     [alert showInfo:self title:@"Internet Connected" subTitle:@"You are connected to the internet" closeButtonTitle:@"Dismiss" duration:0.0f];
     
     SCLAlertView *alert = [[SCLAlertView alloc] init];
     [alert showInfo:self title:@"Internet Problem" subTitle:@"The internet conenction appears to be offline" closeButtonTitle:@"Dismiss" duration:0.0f];
     
     SCLAlertView *alert = [[SCLAlertView alloc] init];
     [alert showInfo:self title:@"Registration Error" subTitle:@"Username is already taken" closeButtonTitle:@"Dismiss" duration:2.0f];
     
     */
}

@end

