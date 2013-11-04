
#import <UIKit/UIKit.h>
#import "FaceViewController.h"
@class BaseTabBarController;

@interface ChatViewController : LNViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
	NSString                   *_titleString;
	NSMutableString            *_messageString;
	NSString                   *_phraseString;
	NSMutableArray		       *_chatArray;
	
	UITableView                *_chatTableView;
	UITextField                *_messageTextField;
	BOOL                       _isFromNewSMS;
	FaceViewController      *_phraseViewController;
	NSDate                     *_lastTime;
}
@property (nonatomic, strong) BaseTabBarController *basetempController;
@property (nonatomic, strong) FaceViewController   *phraseViewController;
@property (nonatomic, strong) UITableView            *chatTableView;
@property (nonatomic, strong) UITextField            *messageTextField;
@property (nonatomic, strong) NSString               *phraseString;
@property (nonatomic, strong) NSString               *titleString;
@property (nonatomic, strong) NSMutableString        *messageString;
@property (nonatomic, strong) NSMutableArray		 *chatArray;

@property (nonatomic, strong) NSDate                 *lastTime;



-(void)sendMessage_Click:(id)sender;
-(void)showPhraseInfo:(id)sender;


-(void)sendMassage:(NSString *)message;
-(void)deleteContentFromTableView;

- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf;

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array;
-(UIView *)assembleMessageAtIndex : (NSString *) message from: (BOOL)fromself;


@end
