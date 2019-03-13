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
    NSString *usrid;
    NSString *authToken;
    NSString *userName;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
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

    [self.gs setAuthenticatedListener:^(NSString* playerId) {
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

-(void)callsOnDisConnect{
    NSLog(@"username: %@",userName);
    NSLog(@"auth token: %@",authToken);
    NSLog(@"user id: %@",usrid);
}

-(void)callSetPlayerPositionEvent{
    GSLogEventRequest* request = [[GSLogEventRequest alloc] init];
    [request setEventKey:@"Set_Pos"];
    [request setEventAttribute:@"POS" withDictionary:@{
                                                     @"x": @5,
        @"y": @5,
        @"z": @5
    }];
    [request setEventAttribute:@"POS" withNumber:@1];
    [request setCallback:^ (GSLogEventResponse* resposne){
        NSLog(@"response: %@",resposne);
    }];
    [self.gs send:request];
}

-(void)CustomMethod{
    /*
    GSData* data = [[GSData alloc] init];
    data._data = */
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
        BOOL newPlayer = [response getNewPlayer];
        NSDictionary* scriptData = [response getScriptData];
        GSPlayer* switchSummary = [response getSwitchSummary];
        NSLog(@"script data: %@",scriptData);
        NSLog(@"switch summary: %@",switchSummary);
    }];
    [self.gs send:request];
}

-(void)userRegistration{
    GSRegistrationRequest* request = [[GSRegistrationRequest alloc] init];
    [request setDisplayName:@"alilakhani"];
    [request  setUserName:@"alilakhani"];
    [request setPassword:@"1"];
    [request setCallback:^ (GSRegistrationResponse* response) {
        NSLog(@"response: %@",response._data);
        NSLog(@"data: %@",[response _data]);
        NSLog(@"auth token: %@",[response getAuthToken]);
        NSLog(@"user id: %@",[response getUserId]);
        NSLog(@"display name: %@",[response getDisplayName]);
    }];
    [self.gs send:request];
}

-(void)logOut {
    [self.gs reset];
}

-(void)connectToGS{
    [self.gs connect];
}

-(void)disconnectFromGS{
    [self.gs disconnect];
}

- (void)buttonPressed {
    if (bConnecting)
    {
         [self callsOnDisConnect];
        bConnecting = false;
        [self.btn setTitle:@"Connect" forState:UIControlStateNormal];
        self.lbl.text = @"Disconnected";
      //  [self.gs reset];
        [self.gs disconnect];
    }
    else
    {
        bConnecting = true;
      self.txtVw.text = @"";
        [self.btn setTitle:@"Disconnect" forState:UIControlStateNormal];
        self.lbl.text = @"Connecting...";
        //[self userSignIn];
       // [self userRegistration];
        //[self.gs connect];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return FALSE;
}

@end
