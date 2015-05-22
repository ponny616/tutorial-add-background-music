//
//  GameScene.h
//  unamed
//

//  Copyright (c) 2015 Tiago Torres. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GameScene : SKScene
{
    NSArray *colors;
    AVAudioPlayer *_backgroundAudioPlayer;
}
- (int) randomEntre:(float)valor1 andValor:(float)valor2;

@property NSArray *colors2;
@property NSString *actualColor;

@property NSInteger timeColors;
@property NSInteger maxTime;

@end
