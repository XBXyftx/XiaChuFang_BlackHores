import { Food, FoodList } from '../../ets/data/FoodData';
import router from '@ohos.router';

interface ParamsType {
  id: string
  title: string
}

@Entry
@Component
struct CategoryPage {
  // 渲染食物列表
  @State foods: Food[] = []
  // 封面图片
  @State cover: string = ''
  // 分类名
  @State cateTitle: string = ''

  aboutToAppear(): void {
    // 接收路由传递而来的数据
    // console.log(JSON.stringify(router.getParams()))

    // 转为对应的类型
    const params = router.getParams() as ParamsType

    // 筛选 食物数组
    const arr = FoodList.filter((item: Food) => {
      // 食物的分类 id 和 携带过来的分类 id 比较
      if (item.categoryId == params.id) {
        return true
      } else {
        return false
      }
    })
    // console.log('', JSON.stringify(arr))
    // 封面
    this.cover = arr[0].cover
    // 分类名字
    this.cateTitle = params.title

    // 筛选出来的数组 赋值给 状态变量
    this.foods = arr

  }

  build() {
    Column() {
      // 顶部
      TopCom({
        // 传递数据给 子组件
        cover: this.cover,
        cateTitle: this.cateTitle
      })

      // 列表
      List({ space: 20 }) {
        ForEach(this.foods, (food: Food) => {
          ListItem() {
            Row() {
              Image(food.cover)
                .width(150)
                .height(110)
                .borderRadius(10)
              Column() {
                Text(food.title)
                Text() {
                  Span(`评分:${food.score}    `)
                  Span(`${food.count} 人做过`)
                }
                .fontSize(12)

                Row({ space: 10 }) {
                  // 作者头像
                  Image(food.author.avatar)
                    .width(20)
                    .height(20)
                    .borderRadius(10)
                  // 作者昵称
                  Text(food.author.nickname)
                    .fontSize(10)
                    .fontColor(Color.Gray)
                }
              }
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.SpaceBetween)
              .layoutWeight(1)
              .padding({ top: 5, bottom: 5, left: 10 })
              .height(110)
            }
          }
        })
      }
      .padding(20)
      .layoutWeight(1)
    }
    .height('100%')
  }
}

@Component
struct TopCom {
  // 定义状态变量 接收数据
  @Prop cover: string
  @Prop cateTitle: string

  build() {
    Stack() {
      // 顶部封面
      Image(this.cover)
        .height('100%')
        .width('100%')
      Column() {
        // 返回按钮
        Image($r('app.media.ic_public_arrow_left'))
          .fillColor(Color.White)
          .width(30)
          .onClick(() => {
            router.back()
          })

        // 顶部标题
        Text(this.cateTitle)
          .fontColor(Color.White)
          .fontSize(30)
      }
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(HorizontalAlign.Start)
      .padding(20)
      .backgroundColor('rgba(0,0,0,0.4)')
      .width('100%')
      .height('100%')
    }
    .height(220)
  }
}