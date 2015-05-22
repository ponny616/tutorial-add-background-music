//
//  BlockNode.m
//  unamed
//
//  Created by Tiago Torres on 14/05/15.
//  Copyright (c) 2015 Tiago Torres. All rights reserved.
//

#import "BlockNode.h"

@implementation BlockNode


static const uint32_t blockCategory = 1;
static const uint32_t floorCategory = 2;

- (int) randomEntre:(float)valor1 andValor:(float)valor2{
    
    return (int)((((float) arc4random() / 0xFFFFFFFFu) * (valor2 - valor1)) + valor1);
}


- (BlockNode*) initWithRow:(NSUInteger)row
                 andColumn:(NSUInteger)colum
                 withColor:(UIColor*)color
                   andSize:(CGSize)size;

{
    self = [super initWithColor:color size:size];
    
    if(self){
        _row = row;
        _colum = colum;
        
        int i = 1;
        
        for (int j=0; j<100;j++) {
       
            i = [self randomEntre:2 andValor:10];
            CGFloat xPosition = i*(size.width);
            
            self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
            self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:3];
            self.position = CGPointMake(xPosition, 700);
            self.physicsBody.allowsRotation = NO;
            
            self.physicsBody.categoryBitMask = blockCategory;
            self.physicsBody.contactTestBitMask = floorCategory;
            self.physicsBody.collisionBitMask = floorCategory;
        }
        
    }
    return self;
}
@end
