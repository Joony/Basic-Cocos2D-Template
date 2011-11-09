//
//  LoseLayer.m
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoseLayer.h"

@implementation LoseLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	LoseLayer *layer = [LoseLayer node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if ((self = [super init])) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Lose" fontName:@"Marker Felt" fontSize:64];
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
