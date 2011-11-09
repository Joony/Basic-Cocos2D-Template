//
//  GameLayer.m
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "WinLayer.h"
#import "LoseLayer.h"
#import "MainMenuLayer.h"

@implementation GameLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild:layer];
	return scene;
}

- (void)winGame:(CCMenuItem *)menuItem 
{
	CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[WinLayer node]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

- (void)loseGame:(CCMenuItem *)menuItem 
{
	CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[LoseLayer node]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

- (void)quitGame:(CCMenuItem *)menuItem 
{
	CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[MainMenuLayer node]];
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

-(id) init
{
	if ((self = [super init])) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = ccp(size.width / 2, size.height - 32);
		[self addChild:label];
        [self setUpMenus];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
