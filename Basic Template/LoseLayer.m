//
//  LoseLayer.m
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoseLayer.h"
#import "MainMenuLayer.h"

@implementation LoseLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	LoseLayer *layer = [LoseLayer node];
	[scene addChild:layer];
	return scene;
}

- (void)switchScene:(ccTime)dt
{
    CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:1.0 scene:[MainMenuLayer node]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

-(id) init
{
	if ((self = [super init])) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Lose" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = ccp(size.width / 2, size.height / 2);
		[self addChild:label];
        [self schedule:@selector(switchScene:) interval:2.0f];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
