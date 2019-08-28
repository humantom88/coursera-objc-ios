//
//  GameScene.m
//  BreakoutDemo
//
//  Created by Artyom Belov on 14/08/2019.
//  Copyright © 2019 Artyom Belov. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	SKSpriteNode *ball1 = [self createBallWithX:100.0 andY:self.size.height / 2];
	SKSpriteNode *ball2 = [self createBallWithX:300.0 andY:self.size.height / 2];
	[self addChild:ball1];
	[self addChild:ball2];

	CGPoint ball1Anchor = CGPointMake(ball1.position.x, ball1.position.y);
	CGPoint ball2Anchor = CGPointMake(ball2.position.x, ball2.position.y);
	SKPhysicsJointSpring *joint = [SKPhysicsJointSpring jointWithBodyA:ball1.physicsBody
																 bodyB:ball2.physicsBody
															   anchorA:ball1Anchor
															   anchorB:ball2Anchor];
	joint.damping = 0.0;
	joint.frequency = 1.5;

	[self.scene.physicsWorld addJoint:joint];
}

- (SKSpriteNode *)createBallWithX:(CGFloat)x andY:(CGFloat)y;
{
	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"blueball.png"];
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width / 2];
	ball.physicsBody.dynamic = YES;
	ball.position = CGPointMake(x, y);
	ball.physicsBody.friction = 0.0;
	ball.physicsBody.restitution = 1.0;
	ball.physicsBody.linearDamping = 0.0;
	ball.physicsBody.angularDamping = 0.0;
	ball.physicsBody.allowsRotation = YES;
	ball.physicsBody.mass = 1.0;
	ball.physicsBody.velocity = CGVectorMake(200.0, 200.0);
	return ball;
}


- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Run 'Pulse' action from 'Actions.sks'
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
    
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
