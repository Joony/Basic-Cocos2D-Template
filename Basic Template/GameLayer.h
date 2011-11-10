//
//  GameLayer.h
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GameHUDLayer.h"
#import <CoreMotion/CoreMotion.h>

@interface GameLayer : CCLayer
{
    GameHUDLayer *_hud;
    CCLabelTTF *_label;
    CMMotionManager *_motionManager;
}

@property (nonatomic, retain) GameHUDLayer *hud;
@property (nonatomic, retain) CCLabelTTF *label;
@property (nonatomic, retain) CMMotionManager *motionManager;

+ (CCScene *)scene;

@end
