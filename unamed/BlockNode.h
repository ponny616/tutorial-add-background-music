//
//  BlockNode.h
//  unamed
//
//  Created by Tiago Torres on 14/05/15.
//  Copyright (c) 2015 Tiago Torres. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BlockNode : SKSpriteNode

- (int) randomEntre:(float)valor1 andValor:(float)valor2;

@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) NSUInteger colum;

- (BlockNode*) initWithRow:(NSUInteger)row
                 andColumn:(NSUInteger)colum
                 withColor:(UIColor*)color
                   andSize:(CGSize)size;

@end
