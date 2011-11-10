//
//  GameLayer.m
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameHUDLayer.h"
#import "WinLayer.h"
#import "LoseLayer.h"
#import "MainMenuLayer.h"

@implementation GameLayer

@synthesize hud = _hud;
@synthesize label = _label;
@synthesize motionManager = _motionManager;

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

- (void)update:(ccTime)delta
{
    CMDeviceMotion *currentDeviceMotion = _motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    float roll = currentAttitude.roll;
    float pitch = currentAttitude.pitch;
    float yaw = currentAttitude.yaw;
    [_label setString:[NSString stringWithFormat:@"roll:%.2f pitch:%.2f yaw:%.2f", roll, pitch, yaw]];
    _label.rotation = CC_RADIANS_TO_DEGREES(pitch);
}

- (id)init
{
	if ((self = [super init])) {
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"Game" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		title.position = ccp(size.width / 2, size.height - title.contentSize.height / 2);
		[self addChild:title];
        //[self setUpMenus];
        
        self.label = [CCLabelTTF labelWithString:@"This Way Up" fontName:@"Marker Felt" fontSize:28];
        _label.position = ccp(size.width / 2, size.height / 2);
        [self addChild:_label];
        
        self.motionManager = [[[CMMotionManager alloc] init] autorelease];
        _motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        if (_motionManager.isDeviceMotionAvailable) {
            [_motionManager startDeviceMotionUpdates];
        }
        [self scheduleUpdate];
        
	}
	return self;
}

- (void) dealloc
{
    self.hud = nil;
    self.label = nil;
    self.motionManager = nil;
	[super dealloc];
}

@end
