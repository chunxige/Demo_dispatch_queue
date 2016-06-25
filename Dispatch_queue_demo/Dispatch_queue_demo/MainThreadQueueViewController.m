//
//  MainThreadQueueViewController.m
//  Dispatch_group
//
//  Created by chunxi on 16/6/25.
//  Copyright © 2016年 chunxi. All rights reserved.
//

#import "MainThreadQueueViewController.h"

@interface MainThreadQueueViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tapButton;

@end

@implementation MainThreadQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 队列 任务 同步
    /*
      队列:
      串行队列: 按照FIFO原则，顺序执行,先加入队列中的任务先执行,一个任务一任务的顺序执行，只有等到队列中上一个任务完成，才能执行下一个任务
      并行队列: 任务是按照加入到队列中的顺序开始执行，但任务完成时的顺序是不确定的
      
      任务:
      就是一个一个的操作，你想要做的事情
     
     
     */
      // 队列和线程之间的关系是什么
    /*
     个人理解 ：
             队列不是线程 ，队列是用来组织任务的，将任务加到队列中，任务会按照加入到队列中先后顺序依次执行，如果是同步队列，会在当前线程中执行，如果是异步队列，则操作系统会根据系统资源去创建新的线程去处理队列中的任务，线程的创建、维护和销毁由操作系统管理，系统会给我做很多优化
     
               在一个线程内可能有多个队列，这些队列可能是串行的或者是并行的，按照同步或者异步的方式
               异步的，则会开启新的线程工作
               同步的 会在当前线程内工作，不会创建新的线程
               
               并行同步队列：不会创建新的线程 而且会是顺序执行 相当于串行同步队列
     
     */
   
    
    /*
       主线程 和 主队列
       主队列是主线中的一个串行队列
       所有的和UI的操作(刷新或者点击按钮)都必须在主线程中的主队列中去执行
       否则无法更新UI
       每一个应用程序只有唯一的一个主队列 用来update UI
     */

}

//主线程 并行队列 同步 执行
- (IBAction)mainThreadConcurrentSycAction:(id)sender {
    // 创建一个自定义 并行队列
    dispatch_queue_t mQueue = dispatch_queue_create("mainThread.syc.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(mQueue, ^{
        
        [self log:@"aaaa"];
         [self updateUI:[NSString stringWithFormat:@"主线程-并行队列-同步-执行 : %d",arc4random()%100] ];
    });
    dispatch_sync(mQueue, ^{
        [self log:@"bbbbb"];
    });
    dispatch_sync(mQueue, ^{
        [self log:@"ccccccc"];
    });
    dispatch_sync(mQueue, ^{
        [self log:@"dddddddd"];
    });
    
    NSLog(@"zzzzzzzzzz");
    
    [self logDivideline];
}

//主线程 并行队列 异步 执行
- (IBAction)mainThreadConcurrentAsycAction:(id)sender {
    // 创建一个自定义 并行队列
    dispatch_queue_t mQueue = dispatch_queue_create("mainThread.asyc.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        
        [self log:@"11111"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self log:@"xxxxxxxxxxxxx"];
            [self updateUI:@"主线程-并行队列-异步-执行"];
        });
    });
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        [self log:@"222222"];
    });
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        [self log:@"3333333"];
    });
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        [self log:@"44444444"];
    });
    
    NSLog(@"5555555555");
    
    [self logDivideline];
}

//主线程 串行队列 同步 执行
- (IBAction)mainThreadSerialSycAction:(id)sender {
    // 创建一个自定义 串行队列
    dispatch_queue_t mQueue = dispatch_queue_create("mainThread.syc.serial.queue", DISPATCH_QUEUE_SERIAL);
    // 将块加到队列中
    dispatch_sync(mQueue, ^{
        
        [self log:@"🎾🎾🎾🎾🎾"];
        [self updateUI:[NSString stringWithFormat:@"主线程-串行队列-同步-执行 : %d",arc4random()%100] ];
    });
    dispatch_sync(mQueue, ^{
        [self log:@"⚽️⚽️⚽️⚽️⚽️"];
    });
    dispatch_sync(mQueue, ^{
        [self log:@"🏀🏀🏀🏀🏀"];
    });
    dispatch_sync(mQueue, ^{
        [self log:@"🏓🏓🏓🏓🏓"];
    });
    
    NSLog(@"⛳️⛳️⛳️⛳️⛳️⛳️⛳️⛳️");
    
    [self logDivideline];
    
}
//主线程 串行队列 异步 执行
- (IBAction)mainThreadSerialAsycAction:(id)sender {
    // 创建一个自定义 串行队列
    dispatch_queue_t mQueue = dispatch_queue_create("mainThread.asyc.serial.queue", DISPATCH_QUEUE_SERIAL);
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        
        [self log:@"❤️❤️❤️❤️❤️"];
    });
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        [self log:@"💛💛💛💛💛"];
    });
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        [self log:@"💚💚💚💚💚"];
    });
    // 将块加到队列中
    dispatch_async(mQueue, ^{
        [self log:@"💙💙💙💙💙"];
    });
    
    NSLog(@"💔💔💔💔💔💔💔💔💔");
    
    [self logDivideline];
}

//主线程 主队列 同步 执行
- (IBAction)mainThreadMainQueueSycAction:(id)sender {
    dispatch_queue_t mainQueue =  dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        [self log:@"天天天天天天天天"];
        [self updateUI:@"主线程 主队列 同步 执行"];
    });
    dispatch_sync(mainQueue, ^{
        [self log:@"下下下下下下下下"];
    });
    dispatch_sync(mainQueue, ^{
        [self log:@"第第第第第第第第"];
    });
    dispatch_sync(mainQueue, ^{
        [self log:@"一一一一一一一一"];
    });
     NSLog(@"哈哈哈哈哈哈哈哈哈哈哈哈");
    [self logDivideline];
}

//主线程 主队列 异步 执行
- (IBAction)mainThreadMainQueueAsycAction:(id)sender {
    dispatch_queue_t mainQueue =  dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [self log:@"我我我我我我我我"];
        [self updateUI:@"主线程 主队列 异步 执行"];
    });
    dispatch_async(mainQueue, ^{
        [self log:@"爱爱爱爱爱爱爱爱"];
    });
    dispatch_async(mainQueue, ^{
        [self log:@"你你你你你你你你"];
    });
    dispatch_async(mainQueue, ^{
        [self log:@"吗吗吗吗吗吗吗吗"];
    });
    
    NSLog(@"不再见不再见不再见不再见不再见");
    [self logDivideline];
    [NSThread sleepForTimeInterval:2];
}



- (IBAction)tapAction:(id)sender {
    
    NSLog(@"你点我了 嘻嘻！");
}

- (void)updateUI:(NSString *)title{
    [self.tapButton setTitle:title forState:UIControlStateNormal];
    self.tapButton.titleLabel.numberOfLines = 0;
}

- (void)log:(NSString *)log{
    //NSLog(@"%@ ***** 所在线程:%@  ****** 所在队列:%s",log,[NSThread currentThread],dispatch_queue_get_label(dispatch_get_current_queue()));
    NSLog(@"%@ ***** 所在线程:%@ ",log,[NSThread currentThread]);
}

- (void)logDivideline{
    NSLog(@"***********************************************************************");

}
@end
