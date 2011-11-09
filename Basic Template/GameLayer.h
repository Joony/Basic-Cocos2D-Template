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
}

@property (nonatomic, retain) GameHUDLayer *hud;

+ (CCScene *)scene;

@end
