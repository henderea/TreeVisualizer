//
//  BinaryNode.m
//  TreeVisualizer
//
//  Created by Eric Henderson on 2/2/12.
//

#import "BinaryNode.h"

@interface BinaryNode()

- (void)removeElementStep2:(int)element
                withParent:(BinaryNode *)P
            andGrandparent:(BinaryNode *)G
                andSibling:(BinaryNode *)T
                   andBool:(BOOL *)b
                   andRoot:(BinaryNode **)root;
- (void)removeElementStep2A:(int)element
                 withParent:(BinaryNode *)P
             andGrandparent:(BinaryNode *)G
                 andSibling:(BinaryNode *)T
                    andBool:(BOOL *)b
                    andRoot:(BinaryNode **)root;
- (void)removeElementStep2A1:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root;
- (void)removeElementStep2A2:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root;
- (void)removeElementStep2A3:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root;
- (void)removeElementStep2B:(int)element
                 withParent:(BinaryNode *)P
             andGrandparent:(BinaryNode *)G
                 andSibling:(BinaryNode *)T
                    andBool:(BOOL *)b
                    andRoot:(BinaryNode **)root;
- (void)removeElementStep2B1:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root;
- (void)removeElementStep2B2:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root;
- (void)removeElementStep3:(BinaryNode *)P
            andGrandparent:(BinaryNode *)G
                andSibling:(BinaryNode *)T
                   andBool:(BOOL *)b
                   andRoot:(BinaryNode **)root;
- (BOOL)bothChildrenBlack;
- (BOOL)isInsideChildRed:(BinaryNode *)P;
- (BOOL)isOutsideChildRed:(BinaryNode *)P;
- (BinaryNode *)rotateWithLeftChild:(BOOL)changeColors;
- (BinaryNode *)rotateWithRightChild:(BOOL)changeColors;
- (BinaryNode *)doubleRotateWithLeftChild:(BOOL)changeColors;
- (BinaryNode *)doubleRotateWithRightChild:(BOOL)changeColors;

@end

@implementation BinaryNode

@synthesize element = _element;
@synthesize isBlack = _isBlack;
@synthesize leftChild = _leftChild;
@synthesize rightChild = _rightChild;

- (int)nodeHeight
{
    int lh = 0;
    if(self.leftChild)
        lh = self.leftChild.nodeHeight;
    int rh = 0;
    if(self.rightChild)
        rh = self.rightChild.nodeHeight;
    if(lh > rh)
        return lh;
    else
        return rh;
}

- (int)nodeSize
{
    int ls = 0;
    if(self.leftChild)
        ls = self.leftChild.nodeSize;
    int rs = 0;
    if(self.rightChild)
        rs = self.rightChild.nodeSize;
    return ls + rs;
}

- (void)removeElement:(int)element
             withBool:(BOOL *)b
              andRoot:(BinaryNode **)root
{
    if([self bothChildrenBlack])
    {
        self.isBlack = NO;
        int ct = element - self.element;
        if(ct == 0)
            [self removeElementStep3:nil andGrandparent:nil andSibling:nil andBool:b andRoot:root];
        else if(ct < 0 && self.leftChild)
            [self.leftChild removeElementStep2:element withParent:self andGrandparent:nil andSibling:self.rightChild andBool:b andRoot:root];
        else if(ct > 0 && self.rightChild)
            [self.rightChild removeElementStep2:element withParent:self andGrandparent:nil andSibling:self.leftChild andBool:b andRoot:root];
    }
    else
    {
        [self removeElementStep2B:element withParent:nil andGrandparent:nil andSibling:nil andBool:b andRoot:root];
    }
    if(root)
        (*root).isBlack = YES;
}

- (void)removeElementStep2:(int)element
                withParent:(BinaryNode *)P
            andGrandparent:(BinaryNode *)G
                andSibling:(BinaryNode *)T
                   andBool:(BOOL *)b
                   andRoot:(BinaryNode **)root
{
    if([self bothChildrenBlack])
        [self removeElementStep2A:element withParent:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    else
        [self removeElementStep2B:element withParent:P andGrandparent:G andSibling:T andBool:b andRoot:root];
}

- (void)removeElementStep2A:(int)element
                 withParent:(BinaryNode *)P
             andGrandparent:(BinaryNode *)G
                 andSibling:(BinaryNode *)T
                    andBool:(BOOL *)b
                    andRoot:(BinaryNode **)root
{
    if(!T || [T bothChildrenBlack])
        [self removeElementStep2A1:element withParent:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    if(T && [T isOutsideChildRed:P])
        [self removeElementStep2A3:element withParent:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    if(T && [T isInsideChildRed:P])
        [self removeElementStep2A2:element withParent:P andGrandparent:G andSibling:T andBool:b andRoot:root];
}

- (void)removeElementStep2A1:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root
{
    self.isBlack = NO;
    if(P)
        P.isBlack = YES;
    if(T)
        T.isBlack = NO;
    int ct = element - self.element;
    if(ct == 0)
        [self removeElementStep3:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    else if(ct < 0 && self.leftChild)
        [self.leftChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
    else if(ct > 0 && self.rightChild)
        [self.rightChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.leftChild andBool:b andRoot:root];
    else
        *b = NO;
}

- (void)removeElementStep2A2:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root
{
    BOOL isleft = (self == P.leftChild);
    BOOL isleftP = (G && P == G.leftChild);
    BOOL isPRoot = (!G);
    if(!isPRoot)
    {
        if(isleftP)
            G.leftChild = (isleft ? [P doubleRotateWithRightChild:NO] : [P doubleRotateWithLeftChild:NO]);
        else
            G.rightChild = (isleft ? [P doubleRotateWithRightChild:NO] : [P doubleRotateWithLeftChild:NO]);
    }
    else
        *root = (isleft ? [P doubleRotateWithRightChild:NO] : [P doubleRotateWithLeftChild:NO]);
    self.isBlack = NO;
    P.isBlack = YES;
    int ct = element - self.element;
    if(ct == 0)
        [self removeElementStep3:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    else if(ct < 0 && self.leftChild)
        [self.leftChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
    else if(ct > 0 && self.rightChild)
        [self.rightChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.leftChild andBool:b andRoot:root];
    else
        *b = NO;
}

- (void)removeElementStep2A3:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root
{
    BOOL isleft = (self == P.leftChild);
    BOOL isleftP = (G && P == G.leftChild);
    BOOL isPRoot = (!G);
    BinaryNode *o = (isleft ? T.rightChild : T.leftChild);
    if(!isPRoot)
    {
        if(isleftP)
            G.leftChild = (isleft ? [P rotateWithRightChild:NO] : [P rotateWithLeftChild:NO]);
        else
            G.rightChild = (isleft ? [P rotateWithRightChild:NO] : [P rotateWithLeftChild:NO]);
    }
    else
        *root = (isleft ? [P rotateWithRightChild:NO] : [P rotateWithLeftChild:NO]);
    self.isBlack = NO;
    P.isBlack = YES;
    T.isBlack = NO;
    o.isBlack = YES;
    int ct = element - self.element;
    if(ct == 0)
        [self removeElementStep3:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    else if(ct < 0 && self.leftChild)
        [self.leftChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
    else if(ct > 0 && self.rightChild)
        [self.rightChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.leftChild andBool:b andRoot:root];
    else
        *b = NO;
}

- (void)removeElementStep2B:(int)element
                 withParent:(BinaryNode *)P
             andGrandparent:(BinaryNode *)G
                 andSibling:(BinaryNode *)T
                    andBool:(BOOL *)b
                    andRoot:(BinaryNode **)root
{
    int ct = element - self.element;
    if(ct == 0)
        [self removeElementStep3:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    else if(ct < 0 && self.leftChild)
    {
        if(!self.leftChild.isBlack)
            [self.leftChild removeElementStep2B1:element withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
        else
            [self.leftChild removeElementStep2B2:element withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
    }
    else if(ct > 0 && self.rightChild)
    {
        if(!self.rightChild.isBlack)
            [self.rightChild removeElementStep2B1:element withParent:self andGrandparent:P andSibling:self.leftChild andBool:b andRoot:root];
        else
            [self.rightChild removeElementStep2B2:element withParent:self andGrandparent:P andSibling:self.leftChild andBool:b andRoot:root];
    }
    else
        *b = NO;
}

- (void)removeElementStep2B1:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root
{
    int ct = element - self.element;
    if(ct == 0)
        [self removeElementStep3:P andGrandparent:G andSibling:T andBool:b andRoot:root];
    else if(ct < 0 && self.leftChild)
        [self.leftChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
    else if(ct > 0 && self.rightChild)
        [self.rightChild removeElementStep2:element withParent:self andGrandparent:P andSibling:self.leftChild andBool:b andRoot:root];
    else
        *b = NO;
}

- (void)removeElementStep2B2:(int)element
                  withParent:(BinaryNode *)P
              andGrandparent:(BinaryNode *)G
                  andSibling:(BinaryNode *)T
                     andBool:(BOOL *)b
                     andRoot:(BinaryNode **)root
{
    BOOL isleft = (P && self == P.leftChild);
    BOOL isleftP = (G && P == G.leftChild);
    BOOL isPRoot = (!G);
    if(!isPRoot)
    {
        if(isleftP)
            G.leftChild = (isleft ? [P rotateWithRightChild:NO] : [P rotateWithLeftChild:NO]);
        else
            G.rightChild = (isleft ? [P rotateWithRightChild:NO] : [P rotateWithLeftChild:NO]);
    }
    else
        *root = (isleft ? [P rotateWithRightChild:NO] : [P rotateWithLeftChild:NO]);
    P.isBlack = NO;
    T.isBlack = YES;
    [self removeElementStep2:element withParent:P andGrandparent:G andSibling:T andBool:b andRoot:root];
}

- (void)removeElementStep3:(BinaryNode *)P
            andGrandparent:(BinaryNode *)G
                andSibling:(BinaryNode *)T
                   andBool:(BOOL *)b
                   andRoot:(BinaryNode **)root
{
    BOOL isleft = (P && self == P.leftChild);
    BOOL isroot = (!P);
    *b = YES;
    if(self.leftChild && self.rightChild)
    {
        int e = [RedBlackTree findGreatest:self.leftChild];
        if(!self.leftChild.isBlack)
            [self.leftChild removeElementStep2B1:e withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
        else if(!self.rightChild.isBlack)
            [self.leftChild removeElementStep2B2:e withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
        else
            [self.leftChild removeElementStep2:e withParent:self andGrandparent:P andSibling:self.rightChild andBool:b andRoot:root];
        self.element = e;
    }
    else if(self.leftChild)
    {
        if(self.isBlack)
            self.leftChild.isBlack = YES;
        if(!isroot)
        {
            if(isleft)
                P.leftChild = self.leftChild;
            else
                P.rightChild = self.leftChild;
        }
        else
            *root = self.leftChild;
    }
    else if(self.rightChild)
    {
        if(self.isBlack)
            self.rightChild.isBlack = YES;
        if(!isroot)
        {
            if(isleft)
                P.leftChild = self.rightChild;
            else
                P.rightChild = self.rightChild;
        }
        else
            *root = self.rightChild;
    }
    else
    {
        if(!isroot)
        {
            if(isleft)
                P.leftChild = nil;
            else
                P.rightChild = nil;
        }
        else
            *root = nil;
    }
}

- (BOOL)bothChildrenBlack
{
    return ((!self.leftChild || self.leftChild.isBlack) && (!self.rightChild || self.rightChild.isBlack));
}

- (BOOL)isInsideChildRed:(BinaryNode *)P
{
    if(self == P.leftChild)
        return (self.rightChild && !self.rightChild.isBlack);
    else
        return (self.leftChild && !self.leftChild.isBlack);
}

- (BOOL)isOutsideChildRed:(BinaryNode *)P
{
    if(self == P.leftChild)
        return (self.leftChild && !self.leftChild.isBlack);
    else
        return (self.rightChild && !self.rightChild.isBlack);
}

- (BinaryNode *)rotateWithLeftChild:(BOOL)changeColors
{
    BinaryNode *temp = self.leftChild;
    self.leftChild = temp.rightChild;
    temp.rightChild = self;
    if(changeColors)
    {
        temp.isBlack = YES;
        self.isBlack = NO;
    }
    return temp;
}

- (BinaryNode *)rotateWithRightChild:(BOOL)changeColors
{
    BinaryNode *temp = self.rightChild;
    self.rightChild = temp.leftChild;
    temp.leftChild = self;
    if(changeColors)
    {
        temp.isBlack = YES;
        self.isBlack = NO;
    }
    return temp;
}

- (BinaryNode *)doubleRotateWithLeftChild:(BOOL)changeColors
{
    self.leftChild = [self.leftChild rotateWithRightChild:NO];
    return [self rotateWithLeftChild:changeColors];
}

- (BinaryNode *)doubleRotateWithRightChild:(BOOL)changeColors
{
    self.rightChild = [self.rightChild rotateWithLeftChild:NO];
    return [self rotateWithRightChild:changeColors];
}

@end
