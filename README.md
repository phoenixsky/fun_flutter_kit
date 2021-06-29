# fun_flutter_kit

A fun development kit with Flutter

一个让Flutter开发变得更有趣的工具集

# 背景介绍

- 目前项目处于快速迭代状态,API可能会面临大量的Break Change,大家要有心里准备
- roadmap目前还没有规划完毕,但这个package目的主要是让Flutter开发起来身心愉悦。适合项目快速落地、迭代,想法验证。
- 项目状态管理采用了[GetX](https://github.com/jonataslaw/getx),在使用过程,需要对getx有一定了解,特别是controller的释放时机
- 项目集成了一些常用的扩展方法,后期会慢慢迭代


# 功能介绍



## 如何使用

1. 集成getX，使用GetMaterialApp。

2. (可选)在GetMaterialApp外包裹一层FunFlutterConfiguration，进行全局参数配置

3. 状态管理：根据场景选择合适的**FunStateXxxController**和**FunStateObx**。

   

## 基本功能

- 全局配置

  ```dart
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return FunFlutterConfiguration(
        funStateBehavior: FunStateBehavior(
          /// 全局分页参数设置
          paging: FunStatePaging(firstPageNo: 0, pageSize: 20),
        ),
        child: GetMaterialApp(
          title: 'Fun Flutter Kit example',
          home: FunStatePage(),
        )
      );
    }
  }
  ```

  

- 状态管理
  Flutter天生的mvvm分层结构，本方案在Get的基础上进行了二次封装

  - Action

    - FunStateActionController（ViewModel层）用来处理简单的响应事件

    - FunStateObx（View层）用来观察处理页面

      ```dart
       import 'package:flutter/material.dart';
       import 'package:fun_flutter_kit/fun_flutter_kit.dart';
       import 'package:get/get.dart';
       
       /// 1. 定义controller
       class ActionViewLogic extends FunStateActionController {
         @override
         Future onLoadData() async {
           return await doXXX();
         }
       }             
      
       class ActionViewPage extends StatelessWidget {
         @override
         Widget build(BuildContext context) {
           /// 2. 注入controller
           final ActionViewLogic logic = Get.put(ActionViewLogic());
           return Scaffold(
             /// 3. 观察controller
             body: FunStateObx(
               controller: logic,
               /// idle
               builder: () => OutlinedButton(
                 child: Text("点我加载"),
                 onPressed: logic.loadData,
               ),
               /// loading
               onLoading: CircularProgressIndicator(),
               /// error
               onError: (error) => InkWell(
                 onTap: logic.loadData,
                 child: Icon(Icons.error),
               ),
             ),
           );
         }
       }
      ```

  - List（列表层封装）

     - FunStateListController（ViewModel层）

     - FunStateListRefresherController（ViewModel层）

     - FunStateRefresherObx（View层）

       ```dart
        class RefresherLoadMoreListViewLogic
            extends FunStateListRefresherController<ArticleEntity> {
          /// 分页参数单独配置，也可全局配置
          FunStatePaging paging() => FunStatePaging(firstPageNo: 0, pageSize: 20);
        
          @override
          Future<List<ArticleEntity>> onLoadData(int pageNum, {int? pageSize}) {
            return fetchArticles(pageNum);
          }
        }

        class RefresherLoadMoreListViewPage extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            final RefresherLoadMoreListViewLogic logic =
                Get.put(RefresherLoadMoreListViewLogic());
            return Scaffold(
                appBar: AppBar(title: Text("RefresherLoadMoreListView")),
                body: FunStateRefresherObx(
                  builder: () => ListView.builder(
                      itemCount: logic.list.length,
                      itemBuilder: (context, index) {
                        return ArticleItem(
                          article: logic.list[index],
                          index: index,
                          isHomeTop: true,
                        );
                      }),
                  controller: logic,
                  enablePullUp: true,
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: Center(
                    child: InkWell(
                      onTap: () {
                        logic.pullToRefresh(isInit: true);
                      },
                      child: Text("无数据,点击重试"),
                    ),
                  ),
                  onError: (err) => Center(child: Text('$err')),
                ));
          }
        }
       ```
       
# 注意事项

1. [GetX](https://github.com/jonataslaw/getx)的controller自动释放逻辑，见原文[issue](https://github.com/jonataslaw/getx/issues/384#issuecomment-661919495)

   > You are closing and creating your instance.
   > Get.put(), unlike Get.lazyPut(), creates the instance the moment it is called, and believe me, the implicit dart constructor already initialized it the moment you closed the second parenthesis.
   >
   > Therefore, the instance will be created on the first route, and linked to it.
   >
   > This is the big problem with unnamed routes.
   > If the current syntax were:
   > Get.to(() => Page());
   > I could postpone the creation of the instance until later, but that would not please most users.
   >
   > So for now you can:
   > 1-Use named routes.
   > 2-Use in the build, as you are using
   > 3-Use Get.lazyPut instead of Get.put ();
   > 4-Use the GetX/GetBuilder widget to start your controllers.
   > 5-Use Bindings.
   >
   > Of all the combinations that exist, the only one that doesn't work is:
   > Get.put created as final + unnamed routes + no Bindings.

   简单翻译下，只有以下场景才会自动释放

   1. 使用命名路由：Get.toName()
   2. 在使用的build方法里调用Get.put，而不是全局变量
   3. 使用Get.lazyPut代替Get.put
   4. 使用GetX/GetBuilder
   5. 使用Bindings

   如果对这里有疑问，可以通过读get源码来解决你的困惑。主要原因其实是controller挂载的上下文不同。
   同样对dialog和bottomSheet适用

   