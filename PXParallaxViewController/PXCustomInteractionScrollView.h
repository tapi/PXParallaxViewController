//
//  PXCustomInteractionScrollView.h
//  PXParallaxViewController
//
//  Created by Paddy O'Brien on 2012-08-17.
//  Copyright (c) 2012 500px. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXCustomInteractionScrollViewDelegate.h"

@interface PXCustomInteractionScrollView : UIScrollView <UIGestureRecognizerDelegate>
@property (nonatomic, weak) id <PXCustomInteractionScrollViewDelegate> interactionDelegate;
@end
