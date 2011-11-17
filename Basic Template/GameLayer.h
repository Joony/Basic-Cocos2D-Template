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
#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"

@interface GameLayer : CCLayer <CDLongAudioSourceDelegate>
{
    GameHUDLayer *_hud;
    CCLabelTTF *_label;
    CMMotionManager *_motionManager;
    CMAttitude *_referenceFrame;
    
    NSMutableArray *_accelerationFilter;
    float _maxAcceleration;
    float _minAcceleration;
    float _restAcceleration;
    float _accel[3];
    float kFilteringFactor;
    float _distance;
    float _velocity;
    
    BOOL _bang;
    CDSoundEngine *_soundEngine;
    ALuint _bg;
    
    CDLongAudioSource *_rightChannel;
    
    CDSoundSource *_sound1;
    ALuint _buzzer;
}

@property (nonatomic, retain) GameHUDLayer *hud;
@property (nonatomic, retain) CCLabelTTF *label;
@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) CMAttitude *referenceFrame;

@property (nonatomic, retain) NSMutableArray *accelerationFilter;

+ (CCScene *)scene;

@end
