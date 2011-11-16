//
//  GameLayer.m
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

#import "GameLayer.h"
#import "GameHUDLayer.h"
#import "WinLayer.h"
#import "LoseLayer.h"
#import "MainMenuLayer.h"
#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"


@implementation GameLayer

@synthesize hud = _hud;
@synthesize label = _label;
@synthesize motionManager = _motionManager;
@synthesize referenceFrame = _referenceFrame;
@synthesize accelerationFilter = _accelerationFilter;

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild:layer];
    GameHUDLayer *hud = [GameHUDLayer node];    
    [scene addChild:hud];
    layer.hud = hud;
	return scene;
}

- (void)winGame:(CCMenuItem *)menuItem 
{
	CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[WinLayer scene]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

- (void)loseGame:(CCMenuItem *)menuItem 
{
	CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[LoseLayer scene]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

- (void)quitGame:(CCMenuItem *)menuItem 
{
	CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[MainMenuLayer scene]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

- (void)setUpMenus
{
	CCMenuItemFont *win = [CCMenuItemFont itemFromString: @"Win" target:self selector:@selector(winGame:)];
	CCMenuItemFont *lose = [CCMenuItemFont itemFromString: @"Lose" target:self selector:@selector(loseGame:)];
  	CCMenuItemFont *quit = [CCMenuItemFont itemFromString: @"Quit" target:self selector:@selector(quitGame:)];
	CCMenu *mainMenu = [CCMenu menuWithItems:win, lose, quit, nil];
	[mainMenu alignItemsVertically];
	[self addChild:mainMenu];
}


- (float)sum:(NSMutableArray *)array
{ 
	int i;
    float sum, value;
	sum = 0;
	value = 0;
    
	for (i = 0; i < [array count]; i++) {
		value = [[array objectAtIndex: i] floatValue];
		sum += value;
	}
    
	return sum;
}

- (void)update:(ccTime)delta
{
    CMDeviceMotion *currentDeviceMotion = _motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    CMAcceleration currentAcceleration = currentDeviceMotion.userAcceleration;
    
    if (_referenceFrame) {
        [currentAttitude multiplyByInverseOfAttitude:_referenceFrame];
    } else {
        //self.referenceFrame = currentAttitude;
    }
    float roll = currentAttitude.roll;
    float pitch = currentAttitude.pitch;
    float yaw = currentAttitude.yaw;
    
    float magnitude = sqrtf(currentAcceleration.x * currentAcceleration.x + currentAcceleration.y * currentAcceleration.y + currentAcceleration.z * currentAcceleration.z);
    
    _accel[0] = currentAcceleration.x * kFilteringFactor + _accel[0] * (1.0f - kFilteringFactor);
    _accel[1] = currentAcceleration.y * kFilteringFactor + _accel[1] * (1.0f - kFilteringFactor);
    _accel[2] = currentAcceleration.z * kFilteringFactor + _accel[2] * (1.0f - kFilteringFactor);
    float resultX = currentAcceleration.x - _accel[0];
    float resultY = currentAcceleration.y - _accel[1];
    float resultZ = currentAcceleration.z - _accel[2];
    float filteredMagnitude = floor(sqrt(resultX * resultX + resultY * resultY + resultZ * resultZ) * 100) / 100;
    
    if (filteredMagnitude > _maxAcceleration) {
        _maxAcceleration = filteredMagnitude;
    }
    
    if (_maxAcceleration > .2) {
        [_label setString:[NSString stringWithFormat:@"BANG! %.2f", _maxAcceleration]];
        if (!_bang) {
            SimpleAudioEngine *ae = [SimpleAudioEngine sharedEngine];
            [ae playBackgroundMusic:@"buzzer.mp3"];
            _bang = YES;
        }
    } else {
        [_label setString:[NSString stringWithFormat:@"%.2f, %.2f", filteredMagnitude, _maxAcceleration]];
    }
    
    
    /*
    float totalAcceleration = sqrtf((currentAcceleration.x * currentAcceleration.x) + (currentAcceleration.y * currentAcceleration.y) + (currentAcceleration.z * currentAcceleration.z));
    //NSLog(@"testing _accelerationFilter %@", _accelerationFilter);
    if (_accelerationFilter == nil) {
        //NSLog(@"nil");
        self.accelerationFilter = [NSMutableArray arrayWithObject:[NSNumber numberWithFloat:totalAcceleration]];
    } else if ([_accelerationFilter count] < 30) {
        //NSLog(@"< 60");
        [_accelerationFilter addObject:[NSNumber numberWithFloat:totalAcceleration]];
    } else {
        //NSLog(@"else");
        [_accelerationFilter removeObjectAtIndex:0];
        [_accelerationFilter addObject:[NSNumber numberWithFloat:totalAcceleration]];
    }
    float averageAcceleration = [self sum:_accelerationFilter] / [_accelerationFilter count];
 
    kFilteringFactor = 0.2f;
    //ramp-speed - play with this value until satisfied
    
    //high-pass filter to eleminate gravity
    _accel[0] = currentAcceleration.x * kFilteringFactor + _accel[0] * (1.0f - kFilteringFactor);
    _accel[1] = currentAcceleration.y * kFilteringFactor + _accel[1] * (1.0f - kFilteringFactor);
    _accel[2] = currentAcceleration.z * kFilteringFactor + _accel[2] * (1.0f - kFilteringFactor);
    float resultX = currentAcceleration.x - _accel[0];
    float resultY = currentAcceleration.y - _accel[1];
    float resultZ = currentAcceleration.z - _accel[2];
    totalAcceleration = sqrt((resultX * resultX + resultY * resultY + resultZ * resultZ));
    //totalAcceleration = resultX;
    //NSLog(@"%.4f %.4f %.4f %.4f", resultX, resultY, resultZ, totalAcceleration);
    
    //_velocity += floorf(totalAcceleration);
    //_distance += _velocity;
    
    //velocity[i] = (acceleration[i] + acceleration[i-1])/2 * interval + velocity[i-1] distance[i] = (velocity[i] + velocity[i-1])/2 * interval + distance[i-1]
    
    if (floor(totalAcceleration * 100) / 100 > _maxAcceleration) {
        _maxAcceleration = floorf(totalAcceleration * 100) / 100;
    }
    if (floor(totalAcceleration * 100) / 100 < _minAcceleration) {
        _minAcceleration = floorf(totalAcceleration * 100) / 100;
    }
    
    //[_label setString:[NSString stringWithFormat:@"roll:%.2f pitch:%.2f yaw:%.2f", roll, pitch, yaw]];
    [_label setString:[NSString stringWithFormat:@"acc:%.2f, floorAcc:%.2f, min:%.2f, max:%.2f, d:%.2f", totalAcceleration, floorf(totalAcceleration * 100) / 100, _minAcceleration, _maxAcceleration, _distance]];
    //_label.rotation = CC_RADIANS_TO_DEGREES(yaw);
     
     */
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CMDeviceMotion *currentDeviceMotion = _motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    self.referenceFrame = currentAttitude;
    _maxAcceleration = 0;
    _minAcceleration = 0;
    _distance = 0;
    _velocity = 0;
    _bang = NO;
    SimpleAudioEngine *ae = [SimpleAudioEngine sharedEngine];
    [ae stopBackgroundMusic];
    
    [_soundEngine playSound:1 sourceGroupId:0 pitch:1.0f pan:0.0f gain:1.0f loop:YES];
}

- (id)init
{
	if ((self = [super init])) {
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"Game" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		title.position = ccp(size.width / 2, size.height - title.contentSize.height / 2);
		[self addChild:title];
        //[self setUpMenus];
        
        self.label = [CCLabelTTF labelWithString:@"This Way Up" fontName:@"Marker Felt" fontSize:14];
        _label.position = ccp(size.width / 2, size.height / 2);
        [self addChild:_label];
        
        self.motionManager = [[[CMMotionManager alloc] init] autorelease];
        _motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        if (_motionManager.isDeviceMotionAvailable) {
            [_motionManager startDeviceMotionUpdates];
        }
        [self registerWithTouchDispatcher];
        [self scheduleUpdate];
        
        
        
	}
	return self;
}

- (void) dealloc
{
    self.hud = nil;
    self.label = nil;
    self.motionManager = nil;
    self.referenceFrame = nil;
    self.accelerationFilter = nil;
	[super dealloc];
}

@end
