//
//  Constant.h
//  MyProject
//
//  Created by Ali Raza on 1/31/19.
//  Copyright © 2019 Ali Raza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GS.h"
#import "GSAPI.h"


@interface Constant : NSObject {
    

    
}
@property (nonatomic, strong) GS *gs;

@property (nonatomic,strong) NSString *myString;

//@property(nonatomic,readwrite) CGFloat *myCGFloat;
//@property(nonatomic,readwrite) NSInteger *myInteger;
//@property(nonatomic,readwrite) BOOL *myBool;

-(void)connectWithGS;
-(void)calculateAreaForRectangleWithLength:(CGFloat)length andBreadth:(CGFloat)breadth;

+(void)simpleClassMethod;
-(void)simpleInstanceMethod;



@end
