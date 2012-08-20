//
//  PXCustomInteractionTableView.h
//  PXParallaxViewController
//
//  Created by Paddy O'Brien on 2012-08-20.
//  Copyright (c) 2012 500px. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXCustomInteractionScrollViewDelegate.h"

@interface PXCustomInteractionTableView : UITableView
@property (nonatomic, weak) id <PXCustomInteractionScrollViewDelegate> interactionDelegate;
@end
