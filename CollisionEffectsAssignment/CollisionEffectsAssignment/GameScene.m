//
//  GameScene.m
//  CollisionEffectsAssignment
//
//  Created by Tom Belov on 10/10/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "GameScene.h"

static const uint32_t category_fence	= 0x1 << 2;
static const uint32_t category_ball		= 0x1 << 1;

@interface GameScene () <SKPhysicsContactDelegate>

@end

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
	self.name = @"Fence";
	[self createPhysicsBody];

	SKSpriteNode *background = (SKSpriteNode *)[self childNodeWithName:@"Background"];
	background.size = self.frame.size;
	background.zPosition = 0;
	background.lightingBitMask = 0x1;

	SKSpriteNode *ball = [self createBallWithX:60
										   andY:700
									andVelocity:CGVectorMake(600.0, 20.0) andName:@"Ball"];
	SKLightNode *light = [self createLight];
	[ball addChild:light];

	[self addChild:ball];
}

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

- (SKSpriteNode *)createBallWithX:(CGFloat)x andY:(CGFloat)y andVelocity:(CGVector)velocity andName:(NSString *)name
{
	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"blueball.png"];
	ball.zPosition = 1;
	ball.name = name;
	ball.position = CGPointMake(x, y);
	ball.size = CGSizeMake(100, 100);
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(ball.size.width / 2)];
	ball.physicsBody.dynamic = YES;
	ball.physicsBody.friction = 0.0;
	ball.physicsBody.restitution = 1.0;
	ball.physicsBody.linearDamping = 2.0;
	ball.physicsBody.angularDamping = 0.0;
	ball.physicsBody.allowsRotation = YES;
	ball.physicsBody.mass = 1.0;
	ball.physicsBody.velocity = velocity;
	ball.physicsBody.categoryBitMask = category_ball;
	ball.physicsBody.collisionBitMask = category_ball | category_fence;
	ball.physicsBody.contactTestBitMask = category_fence;
	ball.physicsBody.usesPreciseCollisionDetection = YES;
	return ball;
}


- (void)didBeginContact:(SKPhysicsContact *)contact {
	NSString *nameA = contact.bodyA.node.name;
	NSString *nameB = contact.bodyB.node.name;

	SKNode *ball, *fence;

	if ([nameA containsString:@"Ball"]) {
		ball = contact.bodyA.node;
		fence = contact.bodyB.node;
	} else {
		fence = contact.bodyA.node;
		ball = contact.bodyB.node;
	}

	NSString *particleRampPath = [[NSBundle mainBundle] pathForResource:@"BallFall" ofType:@"sks"];
	SKEmitterNode *particleRamp = [NSKeyedUnarchiver unarchiveObjectWithFile:particleRampPath];

	particleRamp.position = CGPointMake(ball.position.x, 0);
	particleRamp.zPosition = 1;
	SKAction *actionAudioExplode = [SKAction playSoundFileNamed:@"sound_fence.m4a"
											  waitForCompletion:NO];
	SKAction *actionParticleRamp = [SKAction runBlock:^{
		[fence addChild:particleRamp];
	}];

	[fence runAction:[SKAction sequence:@[actionAudioExplode, actionParticleRamp, [SKAction fadeInWithDuration:1]]]];
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
	static const int kMaxSpeed = 500;
	static const int kMinSpeed = 0;

	SKNode *ball = [self childNodeWithName:@"Ball"];

	float speedball = sqrt(ball.physicsBody.velocity.dx * ball.physicsBody.velocity.dx +
						   ball.physicsBody.velocity.dy * ball.physicsBody.velocity.dy);

	float dx = (ball.physicsBody.velocity.dx + ball.physicsBody.velocity.dx) / 2;
	float dy = (ball.physicsBody.velocity.dy + ball.physicsBody.velocity.dy) / 2;

	float speed = sqrt(dx*dx + dy*dy);

	if ((speedball > kMaxSpeed) || (speed > kMaxSpeed)) {
		ball.physicsBody.linearDamping += 0.2f;
	} else {
		ball.physicsBody.linearDamping = 10.0f;
	}
}

@end
