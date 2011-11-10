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
@synthesize tileMap = _tileMap;
@synthesize grass = _grass;
@synthesize background = _background;
@synthesize sprite = _sprite;
@synthesize meta = _meta;

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
        
        self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"CannonFodder.tmx"];
        self.grass = [_tileMap layerNamed:@"grass"];
        self.background = [_tileMap layerNamed:@"background"];
        self.sprite = [_tileMap layerNamed:@"sprite"];
        self.meta = [_tileMap layerNamed:@"meta"];
        _meta.visible = NO;
        [_tileMap setScale:2.0f];
        [self addChild:_tileMap z:-1];
        
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
    self.tileMap = nil;
    self.grass = nil;
    self.background = nil;
    self.sprite = nil;
    self.meta = nil;
	[super dealloc];
}

@end
