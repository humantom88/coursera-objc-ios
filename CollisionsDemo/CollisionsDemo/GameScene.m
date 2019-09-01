//
//  GameScene.m
//  BreakoutDemo
//
//  Created by Artyom Belov on 14/08/2019.
//  Copyright © 2019 Artyom Belov. All rights reserved.
//

#import "GameScene.h"

static const CGFloat kTrackPointsPerSecond = 1000;

static const uint32_t category_fence	= 0x1 << 3;
static const uint32_t category_paddle	= 0x1 << 2;
static const uint32_t category_block	= 0x1 << 1;
static const uint32_t category_ball		= 0x1 << 1;

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong, nullable) UITouch *motivatingTouch;

@end

@implementation GameScene {
	SKShapeNode *_spinnyNode;
	SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	SKSpriteNode *ball1 = [self createBallWithX:100.0
										   andY:self.size.height / 2
								   andVeloocity:CGVectorMake(200.0, 200.0)];
	SKSpriteNode *ball2 = [self createBallWithX:300.0
										   andY:self.size.height / 2
								   andVeloocity:CGVectorMake(0.0, 0.0)];

	SKSpriteNode *paddle = [self createPaddle];

	[self addChild:ball1];
	[self addChild:ball2];
	[self addChild:paddle];

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

- (SKSpriteNode *)createPaddle
{
	SKSpriteNode *paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle.png"];
	paddle.size = CGSizeMake(100, 20);
	paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 20)];
	paddle.position = CGPointMake(self.size.width / 2, 100);
	paddle.physicsBody.dynamic = NO;
	paddle.physicsBody.friction = 0.0;
	paddle.physicsBody.restitution = 1.0;
	paddle.physicsBody.linearDamping = 0.0;
	paddle.physicsBody.angularDamping = 0.0;
	paddle.physicsBody.allowsRotation = YES;
	paddle.physicsBody.mass = 1.0;
	paddle.physicsBody.velocity = CGVectorMake(0, 0);
	paddle.name = @"Paddle";
	return paddle;
}

- (SKSpriteNode *)createBallWithX:(CGFloat)x andY:(CGFloat)y andVeloocity:(CGVector)velocity
{
	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"blueball.png"];
	ball.size = CGSizeMake(50, 50);
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width / 2];
	ball.physicsBody.dynamic = YES;
	ball.position = CGPointMake(x, y);
	ball.physicsBody.friction = 0.0;
	ball.physicsBody.restitution = 1.0;
	ball.physicsBody.linearDamping = 0.0;
	ball.physicsBody.angularDamping = 0.0;
	ball.physicsBody.allowsRotation = YES;
	ball.physicsBody.mass = 1.0;
	ball.physicsBody.velocity = velocity;
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
	const CGRect region = CGRectMake(0, 0, self.size.width, self.size.height);
	for (UITouch *touch in touches) {
		CGPoint p = [touch locationInNode:self];
		if (CGRectContainsPoint(region, p)) {
			self.motivatingTouch = touch;
		}
	}

	[self trackPaddlesToMotivatingTouches];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self trackPaddlesToMotivatingTouches];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([touches containsObject:self.motivatingTouch]) {
		self.motivatingTouch = nil;
	}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([touches containsObject:self.motivatingTouch]) {
		self.motivatingTouch = nil;
	}
}

- (void)trackPaddlesToMotivatingTouches
{
	SKNode *node = [self childNodeWithName:@"Paddle"];
	if (!self.motivatingTouch) {
		return;
	}

	CGFloat xPos = [self.motivatingTouch locationInNode:self].x;
	NSTimeInterval duration = ABS(xPos - node.position.x) / kTrackPointsPerSecond;
	[node runAction:[SKAction moveToX:xPos duration:duration]];
}


-(void)update:(CFTimeInterval)currentTime {
	// Called before each frame is rendered
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
	NSString *nameA = contact.bodyA.node.name;
	NSString *nameB = contact.bodyB.node.name;

	if (([nameA containsString:@"Fence"] && [nameB containsString:@"Ball"]) || ([nameA containsString:@"Ball"] && [nameB containsString:@"Fence"])) {
		if (contact.contactPoint.y < 10)
		{
			SKView *view = (SKView *)self.view;

			[self removeFromParent];
		}
	}
}

@end
