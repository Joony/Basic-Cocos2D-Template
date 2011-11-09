//
//  MainMenuLayer.m
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "IntroLayer.h"

@implementation MainMenuLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	MainMenuLayer *layer = [MainMenuLayer node];
	[scene addChild:layer];
	return scene;
}

- (void)startGame:(CCMenuItem *)menuItem 
{
	CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[IntroLayer scene]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

- (void)setUpMenus
{
	CCMenuItemFont *start = [CCMenuItemFont itemFromString: @"Play game" target:self selector:@selector(startGame:)];
	CCMenu *mainMenu = [CCMenu menuWithItems:start, nil];
	[mainMenu alignItemsVertically];
	[self addChild:mainMenu];
}

- (id)init
{
	if ((self = [super init])) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Main Menu" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = ccp(size.width / 2, size.height - label.contentSize.height / 2);
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

