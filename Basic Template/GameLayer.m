//
//  GameLayer.m
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if ((self = [super init])) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = ccp(size.width / 2, size.height / 2);
		[self addChild:label];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
