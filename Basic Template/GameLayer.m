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

- (id)init
{
	if ((self = [super init])) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = ccp(size.width / 2, size.height - label.contentSize.height / 2);
		[self addChild:label];
        [self setUpMenus];
	}
	return self;
}

- (void) dealloc
{
    self.hud = nil;
	[super dealloc];
}

@end
