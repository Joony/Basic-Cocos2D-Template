//
//  GameHUDLayer.m
//  Basic Template
//
//  Created by Jonathan McAllister on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameHUDLayer.h"

@implementation GameHUDLayer

- (id)init
{
	if ((self = [super init])) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game HUD" fontName:@"Marker Felt" fontSize:18];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = ccp(0 + label.contentSize.width / 2, size.height - label.contentSize.height / 2);
		[self addChild:label];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
