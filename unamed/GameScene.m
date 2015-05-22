//
//  GameScene.m
//  unamed
//
//  Created by Tiago Torres on 11/05/15.
//  Copyright (c) 2015 Tiago Torres. All rights reserved.
//

#import "GameScene.h"
#import "BlockNode.h"
#import "GameOverScene.h"

#define COLUMNS      5
#define ROWS         1

//static NSString * const kBall = @"movable";

@interface GameScene () <SKPhysicsContactDelegate> {

}

@property (nonatomic) NSTimeInterval lastCheckTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval totalTimePassed;
@property SKLabelNode *showColor;
@property NSUInteger indexNewColor;
@property BlockNode *block;
@property BlockNode *color;
@property UIColor *testColor;
@property SKLabelNode* scoreLabelNode;

@end

@implementation GameScene

static const uint32_t blockCategory = 1;
static const uint32_t floorCategory = 2;


- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        colors = @[[UIColor greenColor], [UIColor blueColor], [UIColor redColor]];
        
        
        //Physics
        self.physicsWorld.gravity = CGVectorMake(0 , -5);
        self.physicsWorld.contactDelegate = self;
        
        // Create the background
        self.backgroundColor = [SKColor blackColor];
        
        // Create ground
        SKSpriteNode *floor = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(390,20)];
        floor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        floor.position = CGPointMake(180, 10);
        floor.physicsBody.dynamic = NO;
        
        [self addChild:floor];
        
        floor.physicsBody.collisionBitMask = blockCategory;
        floor.physicsBody.contactTestBitMask = blockCategory;
        floor.physicsBody.categoryBitMask = floorCategory;
        
        self.colors2 = [NSArray arrayWithObjects:@"Green", @"Blue", @"Red", nil];
        [self trocarCor];
        
        self.timeColors = 0;
        self.maxTime = 150;
        
        self.showColor = [SKLabelNode labelNodeWithFontNamed:@"Kohinoor Devanagari Light"];
        self.showColor.fontSize = 75;
        self.showColor.position = CGPointMake(180, 600);
        [self addChild:self.showColor];
        
        //Inicializa a música...
        [self startBackgroundMusic];

        //[SKAction repeatActionForever:[SKAction playSoundFileNamed:@"Darkness.mp3" waitForCompletion:YES]];
        
        self.color = colors[_indexNewColor];
        
    }
    
    return self;

}

- (void)startBackgroundMusic {
    
    NSError *err;
    NSURL *file = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Darkness.mp3" ofType:nil]];
    _backgroundAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:&err];
    if(err) {
        
        NSLog(@"error in audio play %@", [err userInfo]);
        return;
        
    }
    
    [_backgroundAudioPlayer prepareToPlay];
    
    _backgroundAudioPlayer.numberOfLoops = -1;
    [_backgroundAudioPlayer setVolume:1.0];
    [_backgroundAudioPlayer play];
    
}

- (void) trocarCor
{
    _indexNewColor = [self randomEntre:0 andValor:self.colors2.count];
    self.actualColor = self.colors2[_indexNewColor];
    [self atualizarLabelCor];
    NSLog(self.actualColor);
    self.showColor.fontColor = colors[_indexNewColor];
    self.testColor = colors[_indexNewColor];
}

- (int) randomEntre:(float)valor1 andValor:(float)valor2{
    
    return (int)((((float) arc4random() / 0xFFFFFFFFu) * (valor2 - valor1)) + valor1);
}

-(void) atualizarLabelCor
{
    self.showColor.text = self.actualColor;
}
                                
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    self.timeColors += 1;
    if (self.timeColors >= self.maxTime)
    {
        [self trocarCor];
        self.timeColors = 0;
    }
    
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    
    if(timeSinceLast > 0.3) {
        self.lastUpdateTimeInterval = currentTime;
        
        for (int row=0; row<ROWS; row++){
            for (int col=0; col<1; col++){

                NSUInteger colorIndex = arc4random() % colors.count;

                CGFloat dimension = self.scene.size.width / COLUMNS;
                
                BlockNode *node = [[BlockNode alloc] initWithRow:row andColumn:col withColor:[colors objectAtIndex:colorIndex] andSize:CGSizeMake(dimension, dimension)];
                
                [self.scene addChild:node];
            }
        }
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    
    if([node isKindOfClass:[BlockNode class]]){
        
        BlockNode *block = (BlockNode*)node;
        
        NSLog(@"Node clicked: %@ => %p", block, block.color);
        
        if (self.block.color != self.showColor.fontColor) {
            [block removeFromParent];
            
        } else {
            SKTransition *reveal = [SKTransition fadeWithDuration:1];
            SKScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size];
            [self.view presentScene:gameOverScene transition:reveal];
        }
        
    }

}

- (void)didBeginContact: (SKPhysicsContact *)contact{
    SKPhysicsBody* blockBody;
    SKPhysicsBody* floorBody;
    
    if(contact.bodyA.categoryBitMask == blockCategory) {
        blockBody = contact.bodyA;
        floorBody = contact.bodyB;
    } else {
        blockBody = contact.bodyB;
        floorBody = contact.bodyA;
    }
    
    SKNode *blockNode = blockBody.node;
    SKNode *floorNode = floorBody.node;
    
    if((blockNode.position.y > floorNode.position.y)) {
        
        [blockNode removeFromParent];
    }
    
}

-(void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    self.lastCheckTimeInterval += timeSinceLast;
    
    if(self.lastCheckTimeInterval > 1) {
        self.lastCheckTimeInterval = 0;
        self.totalTimePassed++;
    }
}

float degToRad(float degree) {
    return degree / 180.0f * M_PI;
}

- (void)didMoveToView:(SKView *)view {

}

@end
