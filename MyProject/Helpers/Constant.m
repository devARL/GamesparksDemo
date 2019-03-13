//
//  Constant.m
//  MyProject
//
//  Created by Ali Raza on 1/31/19.
//  Copyright © 2019 Ali Raza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"

/*
 @interface Constant : NSObject {
 
 
 }
 
 @property(nonatomic,strong) NSString *myString;
 //@property(nonatomic,readwrite) CGFloat *myCGFloat;
 //@property(nonatomic,readwrite) NSInteger *myInteger;
 //@property(nonatomic,readwrite) BOOL *myBool;
 
 @end
 */

@implementation Constant
{
    
}

-(id)init {
    self = [super init];
   // self.gs = [[GS alloc] initWithApiKey:@"Z377511JkuRX" andApiSecret:@"ghN96ht3uahh8BEomE2BGKslAlasKhLE" andCredential:@"" andPreviewMode:true];
 //  [self.gs connect];
    return self;
}

+(void)simpleClassMethod {
    NSLog(@"Class Method");
}

-(void)simpleInstanceMethod {
    NSLog(@"Instance Method");
}

-(void)connectWithGS{
    self.gs = [[GS alloc] initWithApiKey:@"Z377511JkuRX" andApiSecret:@"ghN96ht3uahh8BEomE2BGKslAlasKhLE" andCredential:@"" andPreviewMode:true];
    [self.gs connect];
}

-(void)calculateAreaForRectangleWithLength:(CGFloat)length
                                andBreadth:(CGFloat)breadth {
    NSLog(@"length: %@",length);
    NSLog(@"breadth: %@",breadth);
    
    Constant *obj = [[Constant alloc]init];
    [obj simpleInstanceMethod];

    [Constant simpleClassMethod];
    
}

@end
