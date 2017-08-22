

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
@protected
    UITableView *_tableView;
    NSMutableArray *_rows;
    
}
-(id)init;

@property(nonatomic ,readonly) UITableView *tableView;
@property(nonatomic ,readonly) NSMutableArray *rows;



-(void)realoadData;

-(Class)tableViewClass;

-(UITableViewStyle)tableViewStyle;

-(void)setHideGetMore:(BOOL)hide;


/*
 子类完成请求后需要调用finishRequest方法来让此类剩余操作
 */

-(void)finishRequest;

-(void)toTriggerRequestRefresh;
-(void)toTriggerRequestGetMore;


/*
 触发下拉刷新时，将会调用这个方法，如果子类不重写这个方法，默认调用requestRefresh方法,子类重写这个方法时，请先调用super方法
 */
-(void)willTriggerRequestRefresh;

/**
 触发上拉加载更多时，将会调用这个方法,如果子类不重写这个方法，默认调用requestGetMore方法，子类重写这个方法时，请先调用super方法，
 */
-(void)willTriggerRequestGetMore;

#pragma mark  --以下方法可以被子类重写
/**
 *  如果不想要下拉刷新，子类需要重写这个方法并返回NO
 *
 *  @return 默认为YES
 */
-(BOOL)shouldShowRefresh;
/**
 *  如果不想要上拉加载更多，子类需要重写这个方法并返回NO
 *
 *  @return 默认为YES
 */
-(BOOL)shouldShowGetMore;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
-(void)requestRefresh;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
-(void)requestGetMore;

/**
 *  子类可以创建bottomView，如果bottomView返回不为nil，则会根据view的高度添加到底部并调整tableView高度，注意复用保护
 *  if(!view){
 *     create a view
 *  }
 *
 *  @return 返回nil则不会做任何添加
 */
-(UIView *)bottomView;

-(UIView *)topView;



@end
