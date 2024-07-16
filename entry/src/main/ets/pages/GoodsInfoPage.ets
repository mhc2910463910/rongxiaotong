import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import http from '@ohos.net.http'
import { baseUrl } from '../api/BaseData'
import { addGoodsToCart, getCartGoods } from '../api/GoodsApi'

@Entry
@Component
struct GoodsInfoPage {
  @State info: any = {
    // picture:'e1fad02305704a4db5586b13c52283b7.jpg',
    // createTime:'2021-08-27',
    // updateTime:'2021-08-27'
  };
  @State isShow: boolean = false
  @State isShowBuyPopup: boolean = false
  @State message: string = ''

  aboutToAppear() {
    this.info = router.getParams()['info']
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('详细信息')
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.back()
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 }).zIndex(1)

      Column() {
        Image(`${baseUrl}/file/${this.info.picture}`)
          .width('100%')
          .height(300)
          .margin({ bottom: 10 })
          .borderRadius(10)
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text(this.info.title).fontSize(30)
        }.height(60)

        Divider().margin(10).color(Color.Gray)
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Start }) {
          Text(this.info.content).fontSize(20)
        }.height(180).padding({ left: 10 })

        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text(`¥${this.info.price}`).fontSize(25).fontColor(Color.Red)
        }.height(40).padding({ left: 10 })

        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Text(`发布时间:${this.info.createTime.substring(0, 10)}`).fontSize(16)
          Text(`最近修改时间:${this.info.updateTime.substring(0, 10)}`).fontSize(16)
        }.height(50).padding({ left: 10 }).margin({ bottom: 10 })

        Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
          Column() {
            Image($r('app.media.pl')).width(20).height(20).margin({ bottom: 5 })
            Text('评论').fontSize(14)
          }

          Column() {
            Button(`加入购物车`)
              .visibility(this.info.type == 'goods' ? Visibility.Visible : Visibility.None)
              .backgroundColor(Color.Red)
              .onClick(() => {
                // 添加到购物车
                if(!globalThis.token){
                  router.pushUrl({
                    url: 'pages/LoginPage'
                  })
                  return
                }
                console.info('当前info的id',this.info.orderId)
                console.info(this.info.orderId)
                addGoodsToCart(this.info.orderId).then(res => {
                  console.info('请求成功',res.result.toString())
                  let data = JSON.parse(res.result.toString())
                  this.isShowBuyPopup = true
                  if (data && data.flag) {
                    this.message = '添加成功'
                    getCartGoods().then(res=>{
                      let data = JSON.parse(res.result.toString())
                      globalThis.cart = data.list
                    })
                  } else {
                    this.message = '添加失败'
                  }
                  setTimeout(() => {
                    this.isShowBuyPopup = false
                  }, 1000)
                }).catch(error => {
                  console.info('请求失败',JSON.stringify(error))
                  this.message = '添加失败'
                  this.isShowBuyPopup = true
                  setTimeout(() => {
                    this.isShowBuyPopup = false
                  }, 1000)
                })
              })
              .bindPopup(this.isShowBuyPopup,{
                message: this.message
              })
            Button('联系卖家')
              .visibility(this.info.type == 'needs' ? Visibility.Visible : Visibility.None)
              .onClick(() => {
                this.isShow = true
              })
          }
        }.margin({ bottom: 10 })
      }.zIndex(-1).margin({ top: 70, bottom: 10, left: 10, right: 10 })

      Panel(this.isShow) {
        Column() {
          List() {
            ListItem() {
              Text('买家姓名:' + this.info.ownName)
            }.padding({ left: 20, right: 20 }).height(60)

            ListItem() {
              Text('买家地址:' + this.info.address)
            }

            ListItem() {
              Row() {
                Button('取消').type(ButtonType.Normal).onClick(() => {
                  this.isShow = false
                })
              }.width('100%').justifyContent(FlexAlign.Center)
            }.padding({ left: 20, right: 20 }).height(60)
          }.divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundImage($r('app.media.bg'))
      .backgroundImageSize(ImageSize.Cover)
    }
  }
}

/** 弹窗组件 */
@Component
struct AlertDialogExample {
  build() {

  }
}