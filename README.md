# RunTimeDemo
[Demo 简书配套地址](http://www.jianshu.com/p/cc8de5d12cf5)




 这篇文字不扯淡，不讲runtime是什么，只总结下runtime 可以用来干什么。
    这几篇文章写的很好，
    [Objective-C Runtime](http://tech.glowing.com/cn/objective-c-runtime/)
    
[Method Swizzling 和 AOP 实践](http://tech.glowing.com/cn/method-swizzling-aop/)

[南大(南锋子)的一系列文章](http://southpeak.github.io/categories/objectivec/)（打开稍慢）

[[[精通Objective-C]进阶技巧：使用运行时系统API](http://blog.csdn.net/sps900608/article/details/51863147)](http://blog.csdn.net/sps900608/article/details/51863147)

然后饶神总结的也不错,里面好多干货
[iOS 基础知识点网址](http://www.jianshu.com/p/64a7c9f7f6b2)

美团技术团队
[深入理解Objective-C：Category](http://tech.meituan.com/DiveIntoCategory.html)

[深入理解Objective-C：方法缓存](http://tech.meituan.com/DiveIntoMethodCache.html)

[Obj-C Optimization: IMP Cacheing Deluxe](http://www.mulle-kybernetik.com/artikel/Optimization/opti-3-imp-deluxe.html)

#### 1，获取类属性列表、值、方法


[获取model的属性、属性值、方法列表 demo地址](https://github.com/yunisSong/RunTimeDemo/blob/master/RunTimeDemo/NSObject%2BProperty.m)
#### 2，替换已有函数(包括系统方法)
可以把系统方法替换为我们自己的方法。

[替换系统弹框方法，统一修改弹框标题  demo地址](https://github.com/yunisSong/RunTimeDemo/blob/master/RunTimeDemo/UIAlertController%2BexchangeMethod.m)

#### 3，动态挂载对象

[为View 加一个小红点的公用方法  demo地址](https://github.com/yunisSong/RunTimeDemo/blob/master/RunTimeDemo/UIView%2BredDot.m)
#### 4,动态创建类 KVO 底层实现原理
[KVO的底层实现原理](http://www.jianshu.com/p/6305af232100)
#### 5，自动归档、归档解档

            [coder encodeObject:value forKey:propertyName];

            [self setValue:value forKey:propertyName];
[统一为property添加方法 不用一个个的写 demo地址](https://github.com/yunisSong/RunTimeDemo/blob/master/RunTimeDemo/NSObject%2Bencode.m)
#### 6，给分类添加属性

[为View 加一个小红点的公用方法  demo地址](https://github.com/yunisSong/RunTimeDemo/blob/master/RunTimeDemo/UIView%2BredDot.m)
#### 7，字典转模型

[同样是获取类的属性，然后调用 [instance setValue:value forKey:key] 赋值  demo地址](https://github.com/yunisSong/RunTimeDemo/blob/master/RunTimeDemo/NSObject%2BdicToModel.m)
