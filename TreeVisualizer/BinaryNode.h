//
//  BinaryNode.h
//  TreeVisualizer
//
//  Created by Eric Henderson on 2/2/12.
//

#import <Foundation/Foundation.h>
#import "RedBlackTree.h"

@interface BinaryNode : NSObject

@property (nonatomic) int element;
@property (nonatomic) BOOL isBlack;
@property (nonatomic, strong) BinaryNode *leftChild;
@property (nonatomic, strong) BinaryNode *rightChild;
@property (readonly) int nodeHeight;
@property (readonly) int nodeSize;
- (void)removeElement:(int)element
             withBool:(BOOL *)b
              andRoot:(BinaryNode **)root;

@end
