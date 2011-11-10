//
//  GameLayer.h
//  Basic Template
//
//  Created by Joony on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GameHUDLayer.h"

@interface GameLayer : CCLayer
{
    GameHUDLayer *_hud;
    
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_grass;
    CCTMXLayer *_background;
    CCTMXLayer *_sprite;
    CCTMXLayer *_meta;
}

@property (nonatomic, retain) GameHUDLayer *hud;
@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *grass;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic, retain) CCTMXLayer *sprite;
@property (nonatomic, retain) CCTMXLayer *meta;

+ (CCScene *)scene;

@end
