//
//  GameScene.m
//  BreakoutDemo
//
//  Created by Artyom Belov on 14/08/2019.
//  Copyright © 2019 Artyom Belov. All rights reserved.
//

#import "GameOver.h"
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
	self.name = @"Fence";

	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	self.physicsBody.categoryBitMask = category_fence;
	self.physicsBody.collisionBitMask = 0x0;
	self.physicsBody.contactTestBitMask = 0x0;
	self.physicsWorld.contactDelegate = self;

	SKSpriteNode *background = (SKSpriteNode *)[self childNodeWithName:@"Background"];
	background.zPosition = 0;

	SKSpriteNode *ball1 = [self createBallWithX:60
										   andY:60
								   	andVelocity:CGVectorMake(200.0, 200.0)
										andName:@"ball1"];
	SKSpriteNode *ball2 = [self createBallWithX:60
										   andY:75
								   	andVelocity:CGVectorMake(0.0, 10.0)
										andName:@"ball2"];

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

	// Add blocks
	SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"block.png"];

	CGFloat kBlockWidth = node.size.width;
	CGFloat kBlockHeight = node.size.height;
	CGFloat kBlockHorizSpace = 20.0f;

	// Top Row Blocks

	int kBlocksPerRow = self.size.width / (kBlockWidth + kBlockHorizSpace);

	for (int i = 0; i < kBlocksPerRow; i++)
	{

		node = [SKSpriteNode spriteNodeWithImageNamed:@"block.png"];
		node.name = @"Block";
		node.position = CGPointMake(
									kBlockHorizSpace / 2 +
									kBlockWidth / 2 +
									i * kBlockWidth +
									i * kBlockHorizSpace, self.size.height - 100.0);
		node.zPosition = 1;
		node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size center:CGPointMake(0, 0)];
		node.physicsBody.dynamic = NO;
		node.physicsBody.friction = 0.0;
		node.physicsBody.restitution = 1.0;
		node.physicsBody.linearDamping = 0.0;
		node.physicsBody.angularDamping = 0.0;
		node.physicsBody.allowsRotation = NO;
		node.physicsBody.mass = 1.0;
		node.physicsBody.velocity = CGVectorMake(0, 0);
		node.physicsBody.categoryBitMask = category_block;
		node.physicsBody.collisionBitMask = 0x0;
		node.physicsBody.contactTestBitMask = category_ball;
		node.physicsBody.usesPreciseCollisionDetection = NO;

		[self addChild:node];
	}

	// Middle row of blocks

	kBlocksPerRow = (self.size.width / (kBlockWidth + kBlockHorizSpace)) - 1;

	for (int i = 0; i < kBlocksPerRow; i++)
	{
		node = [SKSpriteNode spriteNodeWithImageNamed:@"block.png"];
		node.name = @"Block";
		node.position = CGPointMake(kBlockHorizSpace + kBlockWidth + i * kBlockWidth +
									i * kBlockHorizSpace,
									self.size.height - 100.0 - (1.5 * kBlockHeight));
		node.zPosition = 1;
		node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size center:CGPointMake(0, 0)];
		node.physicsBody.dynamic = NO;
		node.physicsBody.friction = 0.0;
		node.physicsBody.restitution = 1.0;
		node.physicsBody.linearDamping = 0.0;
		node.physicsBody.angularDamping = 0.0;
		node.physicsBody.allowsRotation = NO;
		node.physicsBody.mass = 1.0;
		node.physicsBody.velocity = CGVectorMake(0, 0);
		node.physicsBody.categoryBitMask = category_block;
		node.physicsBody.collisionBitMask = 0x0;
		node.physicsBody.contactTestBitMask = category_ball;
		node.physicsBody.usesPreciseCollisionDetection = NO;

		[self addChild:node];
	}

	// Third row of blocks

	kBlocksPerRow = (self.size.width / (kBlockWidth + kBlockHorizSpace)) - 1;

	for (int i = 0; i < kBlocksPerRow; i++)
	{
		node = [SKSpriteNode spriteNodeWithImageNamed:@"block.png"];
		node.name = @"Block";
		node.position = CGPointMake(
									kBlockHorizSpace / 2 +
									kBlockWidth / 2 +
									i * kBlockWidth +
									i * kBlockHorizSpace,
									self.size.height - 100.0 - (3.0 * kBlockHeight));
		node.zPosition = 1;
		node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size center:CGPointMake(0, 0)];
		node.physicsBody.dynamic = NO;
		node.physicsBody.friction = 0.0;
		node.physicsBody.restitution = 1.0;
		node.physicsBody.linearDamping = 0.0;
		node.physicsBody.angularDamping = 0.0;
		node.physicsBody.allowsRotation = NO;
		node.physicsBody.mass = 1.0;
		node.physicsBody.velocity = CGVectorMake(0, 0);
		node.physicsBody.categoryBitMask = category_block;
		node.physicsBody.collisionBitMask = 0x0;
		node.physicsBody.contactTestBitMask = category_ball;
		node.physicsBody.usesPreciseCollisionDetection = NO;

		[self addChild:node];
	}

}

- (SKSpriteNode *)createPaddle
{
	SKSpriteNode *paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle.png"];
	paddle.name = @"Paddle";
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
	paddle.physicsBody.categoryBitMask = category_paddle;
	paddle.physicsBody.collisionBitMask = 0x0;
	paddle.physicsBody.contactTestBitMask = category_ball;
	paddle.physicsBody.usesPreciseCollisionDetection = YES;
	return paddle;
}

- (SKSpriteNode *)createBallWithX:(CGFloat)x andY:(CGFloat)y andVelocity:(CGVector)velocity andName:(NSString *)name
{
	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"blueball.png"];
	ball.zPosition = 1;
	ball.name = name;
	ball.position = CGPointMake(x, y);
	ball.size = CGSizeMake(50, 50);
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width / 2];
	ball.physicsBody.dynamic = YES;
	ball.physicsBody.friction = 0.0;
	ball.physicsBody.restitution = 1.0;
	ball.physicsBody.linearDamping = 0.0;
	ball.physicsBody.angularDamping = 0.0;
	ball.physicsBody.allowsRotation = YES;
	ball.physicsBody.mass = 1.0;
	ball.physicsBody.velocity = velocity;
	ball.physicsBody.categoryBitMask = category_ball;
	ball.physicsBody.collisionBitMask = category_ball | category_fence | category_block | category_paddle;
	ball.physicsBody.contactTestBitMask = category_fence | category_block;
	ball.physicsBody.usesPreciseCollisionDetection = YES;
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
	static const int kMaxSpeed = 1500;
	static const int kMinSpeed = 400;

	SKNode *ball1 = [self childNodeWithName:@"Ball1"];
	SKNode *ball2 = [self childNodeWithName:@"Ball2"];

	float dx = (ball1.physicsBody.velocity.dx + ball2.physicsBody.velocity.dx) / 2;
	float dy = (ball1.physicsBody.velocity.dy + ball2.physicsBody.velocity.dy) / 2;

	float speed = sqrt(dx*dx + dy*dy);
	if (speed <= kMaxSpeed) {
		ball1.physicsBody.linearDamping += 0.1f;
		ball2.physicsBody.linearDamping += 0.1f;
	} else if (speed < kMinSpeed) {
		ball1.physicsBody.linearDamping -= 0.1f;
		ball2.physicsBody.linearDamping -= 0.1f;
	} else {
		ball1.physicsBody.linearDamping = 0.0f;
		ball2.physicsBody.linearDamping = 0.0f;
	}
}

// MARK: Implements SKPhysicsContactDelegate

- (void)didBeginContact:(SKPhysicsContact *)contact
{
	NSString *nameA = contact.bodyA.node.name;
	NSString *nameB = contact.bodyB.node.name;

	if (([nameA containsString:@"Fence"] && [nameB containsString:@"Ball"]) || ([nameA containsString:@"Ball"] && [nameB containsString:@"Fence"])) {
		if (contact.contactPoint.y < 10)
		{
			SKView *view = (SKView *)self.view;

			[self removeFromParent];
			GameOver *scene = [GameOver nodeWithFileNamed:@"GameOver"];
			scene.scaleMode = SKSceneScaleModeAspectFill;

			[view presentScene:scene];
		}
	}
	NSLog(@"What collided? %@, %@", nameA, nameB);
}

@end
