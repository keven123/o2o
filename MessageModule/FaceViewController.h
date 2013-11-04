

#import <UIKit/UIKit.h>

@class ChatViewController;


@interface FaceViewController : LNViewController {
	NSMutableArray            *_phraseArray;
	ChatViewController        *_chatViewController;
    
    
}

@property (strong, nonatomic) UIScrollView *faceScrollView;
@property (nonatomic, strong) NSMutableArray            *phraseArray;
@property (nonatomic, strong) ChatViewController        *chatViewController;

-(void)dismissMyselfAction:(id)sender;
- (void)showEmojiView;
@end
