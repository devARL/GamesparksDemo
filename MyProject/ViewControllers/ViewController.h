//
//  ViewController.h
//  MyProject
//
//  Created by Ali Raza on 1/31/19.
//  Copyright © 2019 Ali Raza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GS.h"
#import "GSAPI.h"


@interface ViewController : UIViewController <UITextFieldDelegate>
{
    bool bConnecting;
}


@property (nonatomic, strong) GS *gs;

@property (nonatomic, strong) UITextView *txtVw;
@property (nonatomic, strong) UITextField *txtFld;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *lbl;

@end


/*
 //
 //  ViewController.m
 //  MyProject
 //
 //  Created by Ali Raza on 1/31/19.
 //  Copyright © 2019 Ali Raza. All rights reserved.
 //
 
 #import "ViewController.h"
 #import "GS.h"
 #import "GSAPI.h"
 
 @interface ViewController () {
 NSMutableString *usrid;
 }
 
 @end
 
 @implementation ViewController
 
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
 
 __weak typeof(self) weakSelf = self;
 
 self.txtVw = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 60.0f, 300.0f, 220.0f)];
 [self.view addSubview:self.txtVw];
 
 self.txtFld = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 20.0f)];
 self.txtFld.borderStyle = UITextBorderStyleRoundedRect;
 self.txtFld.delegate = self;
 [self.view addSubview:self.txtFld];
 
 self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
 self.btn.frame = CGRectMake(110.0f, 300.0f, 100.0f, 30.0f);
 [self.btn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
 [self.btn setTitle:@"Connect" forState:UIControlStateNormal];
 [self.view addSubview:self.btn];
 
 self.lbl = [[UILabel alloc] initWithFrame:CGRectMake(115.0f, 250.0f, 200.0f, 30.0f)];
 self.lbl.text = @"Disconnected";
 [self.view addSubview:self.lbl];
 
 bConnecting = false;
 self.gs = [[GS alloc] initWithApiKey:@"R376972k14fl" andApiSecret:@"GW1yNmWpdTbvgilz1T91BSRj5f8fF2zt" andCredential:@"" andPreviewMode:true];
 
 // self.gs = [[GS alloc] initWithApiKey:@"exampleKey12" andApiSecret:@"exampleSecret1234567890123456789" andCredential:@"" andPreviewMode:true];
 
 
 /* [self.gs setAvailabilityListener:^ (BOOL available) {
 
 NSMutableString *oldString = [NSMutableString stringWithString:weakSelf.txtVw.text];
 
 [oldString appendString:[NSString stringWithFormat:@"Availability: %d\n", available]];
 
 weakSelf.txtVw.text = oldString;
 
 if (available)
 {
 NSLog(@"available true");
 /*GSAuthenticationRequest* request = [[GSAuthenticationRequest alloc] init];
 [request setUserName:@"aliraza"];
 [request setPassword:@"1"];
 [request setCallback:^ (GSAuthenticationResponse* response) {
 NSLog(@"Response: %@",response);
 NSLog(@"auth token: %@",[response getAuthToken]);
 NSLog(@"disply name: %@",[response getDisplayName]);
 NSLog(@"isnewPlayer: %@",[response getNewPlayer]);
 NSLog(@"user id: %@",[response getUserId]);
 }];
 [self.gs send:request];
 
 //  [self userSignIn];
 
 /* GSDeviceAuthenticationRequest* dar = [[GSDeviceAuthenticationRequest alloc] init];
 
 [dar setDeviceId:@"deviceId"];
 [dar setDeviceOS:@"IOS"];
 [dar setCallback:^ (GSAuthenticationResponse* response) {
 NSMutableString *oldString = [NSMutableString stringWithString:weakSelf.txtVw.text];
 
 [oldString appendString:[NSString stringWithFormat:@"AuthenticationResponse: %@\n", [response getDisplayName]]];
 
 weakSelf.txtVw.text = oldString;
 
 GSLogEventRequest *logEventRequest = [[GSLogEventRequest alloc] init];
 [logEventRequest setEventKey:@"testMessage"];
 [logEventRequest setEventAttribute:@"foo" withString:@"bar"];
 [logEventRequest setDurable:TRUE];
 [weakSelf.gs send:logEventRequest];
 
 }];
 [weakSelf.gs send:dar];
 
 GSAuthenticationRequest* dar = [[GSAuthenticationRequest alloc] init];
 
 [dar setUserName:@"aliraza"];
 [dar setPassword:@"1"];
 [dar setCallback:^ (GSAuthenticationResponse* response) {
 NSMutableString *oldString = [NSMutableString stringWithString:weakSelf.txtVw.text];
 
 [oldString appendString:[NSString stringWithFormat:@"AuthenticationResponse: %@\n", [response getDisplayName]]];
 
 weakSelf.txtVw.text = oldString;
 
 GSLogEventRequest *logEventRequest = [[GSLogEventRequest alloc] init];
 [logEventRequest setEventKey:@"testMessage"];
 [logEventRequest setEventAttribute:@"foo" withString:@"bar"];
 [logEventRequest setDurable:TRUE];
 [self.gs send:logEventRequest];
 
 }];
 [self.gs send:dar];
 
 }
 }];


[self.gs setAuthenticatedListener:^(NSString* playerId) {
    //Your code here
    NSMutableString *oldString = [NSMutableString stringWithString:weakSelf.txtVw.text];
    
    [oldString appendString:[NSString stringWithFormat:@"Authenticated: %@\n", playerId]];
    
    weakSelf.txtVw.text = oldString;
}];

GSMessageListener* listener = [[GSMessageListener alloc] init];

[listener onGSScriptMessage:^(GSScriptMessage* message) {
    NSLog(@"msg: %@", message.getMessageId);
}];

[self.gs setMessageListener:listener];

[self.gs connect];
}

- (void)userSignIn {
    GSAuthenticationRequest* request = [[GSAuthenticationRequest alloc] init];
    [request setUserName:@"aliraza"];
    [request setPassword:@"1"];
    [request setCallback:^ (GSAuthenticationResponse* response) {
        NSLog(@"Response: %@",response);
        NSLog(@"auth token: %@",[response getAuthToken]);
        NSLog(@"disply name: %@",[response getDisplayName]);
        //NSLog(@"isnewPlayer: %@",[response getNewPlayer]);
        NSLog(@"user id: %@",[response getUserId]);
    }];
    [self.gs send:request];
}

- (void)buttonPressed {
    if (bConnecting)
    {
        bConnecting = false;
        
        [self.btn setTitle:@"Connect" forState:UIControlStateNormal];
        
        self.lbl.text = @"Disconnected";
        
        [self.gs disconnect];
    }
    else
    {
        
        if(self.gs.isAuthenticated) {
            NSLog(@"connected");
        }
        [self.gs isAuthenticated];
        bConnecting = true;
        
        
        /*       new AuthenticationRequest()
         .SetPassword(password)
         .SetUserName(userName)
         .Send((response) => {
         string authToken = response.AuthToken;
         string displayName = response.DisplayName;
         bool? newPlayer = response.NewPlayer;
         GSData scriptData = response.ScriptData;
         var switchSummary = response.SwitchSummary;
         string userId = response.UserId;
         });
         
        
        self.txtVw.text = @"";
        
        [self.btn setTitle:@"Disconnect" forState:UIControlStateNormal];
        
        self.lbl.text = @"Connecting...";
        
        [self userSignIn];
        //  [self.gs connect];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return FALSE;
}

@end


 
 */
