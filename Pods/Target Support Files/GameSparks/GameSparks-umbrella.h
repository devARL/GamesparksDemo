#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GS.h"
#import "GSAPI.h"
#import "GSData.h"
#import "JFRSecurity.h"
#import "JFRWebSocket.h"
#import "PreviewViewController.h"

FOUNDATION_EXPORT double GameSparksVersionNumber;
FOUNDATION_EXPORT const unsigned char GameSparksVersionString[];

