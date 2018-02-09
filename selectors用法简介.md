# selectors模块用法简介

它的功能与linux的epoll，还是select模块,poll等类似；实现高效的I/O multiplexing,常用于非阻塞的socket的编程中； 简单介绍一下这个模块，更多内容查看 python文档：https://docs.python.org/3/library/selectors.html

    1. 模块定义了一个 BaseSelector的抽象基类， 以及它的子类，包括：SelectSelector， PollSelector, EpollSelector, DevpollSelector, KqueueSelector.    
    另外还有一个DefaultSelector类，它其实是以上其中一个子类的别名而已，它自动选择为当前环境中最有效的Selector，所以平时用 DefaultSelector类就可以了，其它用不着。
    
    2. 模块定义了两个常量，用于描述 event Mask
    EVENT_READ ：      表示可读的； 它的值其实是1；
    EVENT_WRITE：      表示可写的； 它的值其实是2；
    
    3. 模块定义了一个 SelectorKey类， 一般用这个类的实例 来描述一个已经注册的文件对象的状态， 这个类的几个属性常用到：
    fileobj：表示已经注册的文件对象；
    fd:    表示文件对象的描述符，是一个整数，它是文件对象的 fileno()方法的返回值；
    events:表示注册一个文件对象时，我们等待的events, 即上面的event Mask, 是可读呢还是可写呢！！
    data:  表示注册一个文件对象是邦定的data；
    
    4. 最后说说抽象基类中的方法；
    register(fileobj, events, data=None)  作用：注册一个文件对象。
                                          参数： fileobj——即可以是fd 也可以是一个拥有fileno()方法的对象； 
                                          events——上面的event Mask 常量；

    data                                  返回值： 一个SelectorKey类的实例；

    unregister(fileobj)                   作用： 注销一个已经注册过的文件对象；
                                          返回值：一个SelectorKey类的实例；

    modify(fileobj, events, data=None)    作用：用于修改一个注册过的文件对象，比如从监听可读变为监听可写；它其实就是register() 后再跟unregister(),       但是使用modify() 更高效；
                                          返回值：一个SelectorKey类的实例；
    
    select(timeout=None)                  作用： 用于选择满足我们监听的event的文件对象；
                                          返回值： 是一个(key, events)的元组， 其中key是一个SelectorKey类的实例， 而events 就是 event Mask（EVENT_READ或EVENT_WRITE,或者二者的组合)
    
    close()                               作用：关闭 selector。 最后一定要记得调用它，要确保所有                                       的资源被释放；
    
    get_key(fileobj)                      作用： 返回注册文件对象的 key；
                                          返回值 ：一个SelectorKey类的实例；