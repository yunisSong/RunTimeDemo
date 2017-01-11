# RunTimeDemo

> 这篇文字不扯淡，不讲runtime是什么，只总结下runtime 可以用来干什么。
    这几篇文章写的很好，
    [Objective-C Runtime](http://tech.glowing.com/cn/objective-c-runtime/)
[Method Swizzling 和 AOP 实践](http://tech.glowing.com/cn/method-swizzling-aop/)
[南大(南锋子)的一系列文章](http://southpeak.github.io/categories/objectivec/)（打开稍慢）
[[[精通Objective-C]进阶技巧：使用运行时系统API](http://blog.csdn.net/sps900608/article/details/51863147)](http://blog.csdn.net/sps900608/article/details/51863147)
然后饶神总结的也不错,里面好多干货
[iOS 基础知识点网址](http://www.jianshu.com/p/64a7c9f7f6b2)

#### 1，获取类属性列表、值、方法

####2，替换已有函数(包括系统方法)
http://tech.glowing.com/cn/change-uinavigationbar-backgroundcolor-dynamically/
可以把系统方法替换为我们自己的方法。

####3，动态挂载对象
objc_setAssociatedObject
objc_getAssociatedObject

####4,动态创建类 KVO 底层实现原理
[KVO的底层实现原理](http://www.jianshu.com/p/6305af232100)
####5，自动归档、归档解档

####6，给分类添加属性

####7，字典转模型(KVC)

####8，KVC 动态获取属性–下拉刷新

####9，动态创建函数
有时候会根据项目需求动态创建某个函数，没错Runtime完全能做到

参考文档

http://blog.csdn.net/qq_30513483/article/details/54090498

NSClassFromString

http://www.2cto.com/kf/201611/570834.html

http://wenku.baidu.com/link?url=W5HerYP1UebdVIoqJndBv1gJPPMWph5Eebkop44WMVLPLXUZvVFyjXX_E-6Cc0jz90YiOLDgl-BhTOTEhrGkVfIBgiGcrzm4Gd8GcoIrS0VTjeC8e1_Q_rBKhTCaGljc

http://mozhenhau.com/2016/02/25/IOS%E5%BC%80%E5%8F%91%E4%B9%8Bruntime%E8%BF%90%E8%A1%8C%E6%97%B6%E5%8F%AF%E4%BB%A5%E5%B9%B2%E4%BB%80%E4%B9%88/
