//
//  GameScene.m
//  BreakoutDemo
//
//  Created by Artyom Belov on 14/08/2019.
//  Copyright © 2019 Artyom Belov. All rights reserved.
//

#import "GameOver.h"
#import "GameScene.h"
#import "GameWon.h"

static const CGFloat kTrackPointsPerSecond = 1000;

static const uint32_t category_fence	= 0x1 << 4;
static const uint32_t category_paddle	= 0x1 << 3;
static const uint32_t category_block	= 0x1 << 2;
static const uint32_t category_ball		= 0x1 << 1;

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong, nullable) UITouch *motivatingTouch;
@property (nonatomic, copy) NSMutableArray *blockFrames;

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
	self.name = @"Fence";

	[self createPhysicsBody];

	SKSpriteNode *background = (SKSpriteNode *)[self childNodeWithName:@"Background"];
	background.size = self.frame.size;
	background.zPosition = 0;
	background.lightingBitMask = 0x1;

	SKSpriteNode *ball1 = [self createBallWithX:60
										   andY:200
									andVelocity:CGVectorMake(50.0, 50.0) andName:@"ball1"];

	SKSpriteNode *ball2 = [self createBallWithX:60
										   andY:250
									andVelocity:CGVectorMake(0.0, 10.0) andName:@"ball2"];

	SKLightNode *light = [self createLight];
	[ball1 addChild:light];

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

	[self createBlockAnimationFrames];

	// Add blocks
	SKSpriteNode *node;

	CGFloat kBlockWidth = 80;
	CGFloat kBlockHeight = 30;
	CGFloat kBlockHorizSpace = 30.0f;

	// Top Row Blocks

	int kBlocksPerRow = self.size.width / (kBlockWidth + kBlockHorizSpace);

	for (int i = 0; i < kBlocksPerRow; i++)
	{
		node = [SKSpriteNode spriteNodeWithTexture:self.blockFrames[i % 10]];
		node.size = CGSizeMake(kBlockWidth, kBlockHeight);
		node.name = @"Block";
		node.position = CGPointMake(kBlockHorizSpace / 2 +
									kBlockWidth / 2 +
									i * kBlockWidth +
									i * kBlockHorizSpace, self.size.height - 100.0);
		node.zPosition = 1;
		node.lightingBitMask = 0x1;
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
		node = [SKSpriteNode spriteNodeWithTexture:self.blockFrames[i % 10]];
		node.size = CGSizeMake(kBlockWidth, kBlockHeight);

		node.name = @"Block";
		node.position = CGPointMake(kBlockHorizSpace + kBlockWidth + i * kBlockWidth +
									i * kBlockHorizSpace,
									self.size.height - 100.0 - (1.5 * kBlockHeight));
		node.zPosition = 1;
		node.lightingBitMask = 0x1;
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
		node = [SKSpriteNode spriteNodeWithTexture:self.blockFrames[i % 10]];
		node.size = CGSizeMake(kBlockWidth, kBlockHeight);

		node.name = @"Block";
		node.position = CGPointMake(
									kBlockHorizSpace / 2 +
									kBlockWidth / 2 +
									i * kBlockWidth +
									i * kBlockHorizSpace,
									self.size.height - 100.0 - (3.0 * kBlockHeight));
		node.zPosition = 1;
		node.lightingBitMask = 0x1;
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


#pragma mark - Private methods

- (void)createPhysicsBody
{
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	self.physicsBody.categoryBitMask = category_fence;
	self.physicsBody.collisionBitMask = 0x0;
	self.physicsBody.contactTestBitMask = 0x0;

	self.physicsWorld.contactDelegate = self;

}

- (SKLightNode *)createLight
{
	SKLightNode *light = [SKLightNode new];
	light.categoryBitMask = 0x1;
	light.falloff = 1;
	light.ambientColor = [UIColor colorWithRed:0.5
										 green:0.5
										  blue:0.5
										 alpha:1.0];
	light.lightColor = [UIColor colorWithRed:0.7
									   green:0.7
										blue:1.0
									   alpha:1.0];
	light.shadowColor = [UIColor colorWithRed:0.0
										green:0.0
										 blue:0.0
										alpha:1.0];
	light.zPosition = 1;

	return light;
}

- (void)createBlockAnimationFrames
{
	NSMutableArray *someArray = [[NSMutableArray alloc] init];

	SKTextureAtlas *blockAnimation = [SKTextureAtlas atlasNamed:@"block.atlas"];
	unsigned long numImages = blockAnimation.textureNames.count;
	for (int i = 0; i < numImages; i++) {
		NSString *textureName = [NSString stringWithFormat:@"block%02d", i];
		SKTexture *temp = [blockAnimation textureNamed:textureName];
		[someArray addObject:temp];
	}
	self.blockFrames = someArray;
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
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(ball.size.width / 2)];
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

	if (([nameA containsString:@"Block"] && [nameB containsString:@"Ball"]) || ([nameA containsString:@"Ball"] && [nameB containsString:@"Block"])) {
		SKAction *blockAudio = [SKAction playSoundFileNamed:@"sound_explode.m4a" waitForCompletion:NO];
		[self runAction:blockAudio];
	} else if (([nameA containsString:@"Paddle"] && [nameB containsString:@"Ball"]) || ([nameA containsString:@"Ball"] && [nameB containsString:@"Paddle"])) {
		SKAction *paddleAudio = [SKAction playSoundFileNamed:@"sound_paddle.m4a" waitForCompletion:NO];
		[self runAction:paddleAudio];
	} else if (([nameA containsString:@"Fence"] && [nameB containsString:@"Ball"]) || ([nameA containsString:@"Ball"] && [nameB containsString:@"Fence"])) {
		if (contact.contactPoint.y < 10)
		{
			SKView *view = (SKView *)self.view;

			[self removeFromParent];
			GameOver *scene = [GameOver nodeWithFileNamed:@"GameOver"];
			scene.scaleMode = SKSceneScaleModeAspectFill;

			[view presentScene:scene];
		} else {
			SKAction *fenceAudio = [SKAction playSoundFileNamed:@"sound_wall.m4a" waitForCompletion:NO];
			[self runAction:fenceAudio];
		}
	}
	NSLog(@"What collided? %@, %@", nameA, nameB);
}

@end
