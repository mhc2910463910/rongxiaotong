import { buyGoods, getCartGoods } from '../../api/GoodsApi'
import router from '@ohos.router'
import { baseUrl } from '../../api/BaseData'
import { HttpManager } from '../../util/HttpManager'
import { RequestMethod } from '../../util/RequestOption'
import promptAction from '@ohos.promptAction'
// DONE,删除这个Entry
// @Entry
@Preview
@Component
export struct CarInfo {
  @State isRefreshing: boolean = false
  scroller: Scroller = new Scroller()
  @State goods: Array<any> = []
  @State selectedGoods: Array<any> = []
  @State show: boolean = false
  @State isFlag: boolean = true;
  @State totalPrice: number = 0
  @State isAllSelected: boolean = false
  @State selectedCount: number = 0;
  @State defaultAddress: any = {}
  // @State address:string = ''
  // @State addresses:Array<string> = []
  getAddress() {
    if(globalThis.info){
      this.defaultAddress.consignee = globalThis.info.nickName
      this.defaultAddress.addressDetail = globalThis.info.address,
      this.defaultAddress.phone = globalThis.info.phone
    }else{
      // TODO,去除下面这些赋值
      this.defaultAddress.consignee = '张三'
      this.defaultAddress.addressDetail = '甘肃兰州',
      this.defaultAddress.phone = '12345678901'
    }
    console.info('获取到的默认地址：',JSON.stringify(this.defaultAddress))
    // getDefaultAddress().then((res)=>{
    //   let address=JSON.parse(res.result.toString()).data
    //   //如果不为空，则更新默认地址
    //   if(address!=null){
    //     this.defaultAddress = address
    //   }
    // })
    // getAllAddress().then((res)=>{
    //   this.addresses = JSON.parse(res.result.toString()).data
    // })
  }
  //处理地址数据
  showAddress(str: string) {
    let n = str.length;
    if (n > 15) {
      return str.substring(0, 15) + '...'
    }
    return str;

  }
  //转化对象
  selectOperation(item, index) {
    //替换元素
    let newItem = {
      shoppingId: item.shoppingId,
      content: item.content,
      count: item.count,
      orderId: item.orderId,
      ownName: item.ownName,
      picture: item.picture,
      price: item.price,
      isSelected: item.isSelected,
      title: item.title
    }
    this.goods.splice(index, 1, newItem)
    this.calculateTotalPrice()
  }
  // 计算合计
  calculateTotalPrice() {
    let total = 0
    this.selectedCount = 0
    for (const item of this.goods) {
      if (item.isSelected) {
        this.selectedCount++
        total += parseFloat(item.price) * parseInt(item.count)
      }
    }
    this.totalPrice = total
    this.isAllSelected = this.selectedCount === this.goods.length
  }
  // 加/减操作
  addOrSubtractOperation(item, index: number, type: -1 | 1) {
    if (item.count == 1 && type === -1) {
      return
    }
    item.count += type
    //替换元素
    let newItem = {
      shoppingId: item.shoppingId,
      content: item.content,
      count: item.count,
      orderId: item.orderId,
      ownName: item.ownName,
      picture: item.picture,
      price: item.price,
      isSelected: item.isSelected,
      title: item.title
    }
    this.goods.splice(index, 1, newItem)
    this.calculateTotalPrice()
    this.updateCarGoodsNum(item);

  }
  //修改商品的购买数量
  updateCarGoodsNum(item) {
    // updateCarGoodsInfo(item.shoppingId, item.count).then((res) => {
    //   console.info("=============data=====", JSON.stringify(res))
    // })
  }
  //删除操作
  doDeleteGoods() {
    AlertDialog.show({
      title: '提示',
      message: this.isAllSelected ? '清空购物车？' : '删除已选中的商品？',
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('Callback when the second button is clicked')
        }
      },
      secondaryButton: {
        value: '确定',
        action: () => {
          //提交后端删除数据
          for (let item of this.goods) {
            if (item.isSelected) {
              // deleteCarGoods(item.shoppingId).then((res) => {
              //   console.log(res.toString())
              // })
            }
          }
          if (this.isAllSelected) {
            this.goods = []
            this.totalPrice = 0
            this.isAllSelected = false
          } else {
            const newArray: Array<any> = []
            for (const item of this.goods) {
              if (!item.isSelected) {
                newArray.push(item)
              }
            }
            this.goods = newArray
            this.calculateTotalPrice()
          }
        }
      }
    })
  }
  // 提交订单
  submitHandler() {
    // TODO,不知道/cart/commitOrder/{addId}/{tMoney}这个接口的addId是什么
    // buyGoods('admin',)
  }

  aboutToAppear() {
    console.info('购物车组件出现！')
    // DONE, 把全局token赋值删掉
    // globalThis.token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGUiOlt7ImF1dGhvcml0eSI6ImFkbWluIn1dLCJleHAiOjE3MjAzMjIyNzYsImlhdCI6MTcyMDMxODY3NjEzNywidXNlcm5hbWUiOiJhZG1pbiJ9.tleYxgEP-Dk4fSbXTy5xmlg0rVLUzQMdpIcvmcv1MMNNt1x1lISJ7bB5fk5YCK39M9Z9PVl819t9MN5GjEuImw'
    this.getAddress()
    this.getGoods()
    // let res = await HttpManager.getInstance()
    //    .request({
    //      url: `${baseUrl}/cart/show`,
    //      method: RequestMethod.GET,
    //      // header:
    //      // DONE, 将测试token改回全局变量
    //      header: {
    //        Authorization: globalThis.token
    //        // Authorization:'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGUiOlt7ImF1dGhvcml0eSI6ImFkbWluIn1dLCJleHAiOjE3MjAxOTU3ODYsImlhdCI6MTcyMDE5MjE4Njk3MCwidXNlcm5hbWUiOiJhZG1pbiJ9.A7-jyzOr7I1fG15fSP3fMFq1q4q1Xu_MlbTt8GYl-v2tFbNv2spjP5QWcMuyDgUat9WHPnyGEuwZMnakLTH34Q'
    //      }
    //    })

  }

  getGoods() {
    getCartGoods().then((res) => {
      this.goods = JSON.parse(res.result.toString()).data;
      console.info('长度', this.goods.length)
      // console.info('购物车长度',globalThis.cart.length)
      // console.info('购物车内容',JSON.stringify(globalThis.cart))
      console.info('购物车内容', JSON.stringify(this.goods))
    })
  }

  build() {
    Column() {
      Text('123')
      // Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      //   // !globalThis.token
      //   if (!globalThis.token) {
      //     // 未登录
      //     Column() {
      //       Image($r('app.media.illustration_3x')).width(200).height(200)
      //       Text("未登录")
      //         .fontSize(24)
      //         .fontColor('#0F172A')
      //         .height(50)
      //         .lineHeight(50)
      //         .fontWeight(400)
      //       Text('请先登录！').fontSize(16).fontColor('#64748B').height(30).lineHeight(30)
      //       Text('去登录')
      //         .fontSize(16)
      //         .fontColor('#FFFFFF')
      //         .backgroundColor('#059669')
      //         .height(60)
      //         .width(260)
      //         .borderRadius(12)
      //         .margin({ top: 30 })
      //         .textAlign(TextAlign.Center)
      //         .fontWeight(400)
      //         .onClick(() => {
      //           router.pushUrl({
      //             url: 'pages/LoginPage'
      //           })
      //         })
      //     }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
      //     .width('100%').height('100%')
      //     //   globalThis.cart.length == 0
      //     //   !globalThis.cart || globalThis.cart.length == 0
      //   } else if (this.goods.length == 0) {
      //     // 购物车为空
      //     Column() {
      //       Image($r('app.media.illustration_3x')).width(200).height(200)
      //       Text("购物车是空的")
      //         .fontSize(24)
      //         .fontColor('#0F172A')
      //         .height(50)
      //         .lineHeight(50)
      //         .fontWeight(400)
      //       Text('快去看看吧！').fontSize(16).fontColor('#64748B').height(30).lineHeight(30)
      //       Text('去购物')
      //         .fontSize(16)
      //         .fontColor('#FFFFFF')
      //         .backgroundColor('#059669')
      //         .height(60)
      //         .width(260)
      //         .borderRadius(12)
      //         .margin({ top: 30 })
      //         .textAlign(TextAlign.Center)
      //         .fontWeight(400)
      //         .onClick(() => {
      //           router.pushUrl({
      //             url: 'pages/GoodsPage',
      //             params: { 'type': 'goods' }
      //           })
      //         })
      //     }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
      //     .width('100%').height('100%')
      //   } else {
      //     //
      //     Flex({ direction: FlexDirection.Column }) {
      //       Flex({ alignItems: ItemAlign.Center }) {
      //         Image($r('app.media.map_pin')).width(48)
      //           .objectFit(ImageFit.Contain)
      //         Text(this.defaultAddress.addressDetail).fontSize(18)
      //           .flexGrow(1)
      //         // TextInput().flexGrow(1)
      //         Text('编辑')
      //           .maxLines(1)
      //           .fontColor(Color.Gray)
      //           .width(48)
      //           .margin({ right: 8 })
      //         //
      //       }.backgroundColor('#f3f3f3')
      //       .padding({ top: 20, bottom: 20 })
      //
      //       Row() {
      //         Text(`共有${this.goods.length.toString()}种`)
      //       }.width('100%').height(64)
      //
      //       Scroll(this.scroller) {
      //         Flex({ direction: FlexDirection.Column }) {
      //           ForEach(this.goods, (item, index) => {
      //             Flex({ alignItems: ItemAlign.Center }) {
      //               Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
      //                 .selectedColor('#007DFF')
      //                 .onChange((value: boolean) => {
      //                   console.info('选中的当前物品', JSON.stringify(item))
      //                   console.info('被选中的列表', JSON.stringify(this.selectedGoods))
      //                   if (!value) {
      //                     // 取消
      //                     this.selectedGoods.forEach((e, index) => {
      //                       if (e.orderId == item.orderId) {
      //                         // 删除该元素
      //                         this.selectedGoods.splice(index, 1)
      //                       }
      //                     })
      //                   } else {
      //                     this.selectedGoods.push(item)
      //                   }
      //                 })
      //                 .margin({ right: 10 })
      //                 .height(30)
      //                 .width(30)
      //               Image(`${baseUrl}/file/${item.picture}`)
      //                 .width(150)
      //                 .objectFit(ImageFit.Contain)
      //                 .margin({ right: 10 })
      //               Flex({ direction: FlexDirection.Column }) {
      //                 Text(`${item.title}`)
      //                 Text(`${item.content}`).flexGrow(1).fontSize(12)
      //                 Row() {
      //                   Text(`¥${item.price}}`).fontColor(Color.Red)
      //                   Row() {
      //                     Button({ type: ButtonType.Normal }) {
      //                       Text('-')
      //                     }
      //                     .width(24)
      //                     .borderWidth(1)
      //                     .height('100%')
      //                     .backgroundColor(Color.Transparent)
      //                     .onClick(() => {
      //                       item.count--
      //                     })
      //
      //                     Text(item.count.toString())
      //                       .width(24)
      //                       .textAlign(TextAlign.Center)
      //                       .borderWidth(1)
      //                       .height('100%')
      //                       .backgroundColor(Color.Transparent)
      //                     Button({ type: ButtonType.Normal }) {
      //                       Text('+')
      //                     }
      //                     .width(24)
      //                     .borderWidth(1)
      //                     .height('100%')
      //                     .backgroundColor(Color.Transparent)
      //                     .onClick(() => {
      //                       item.count++
      //                     })
      //                   }.height(24)
      //                 }.justifyContent(FlexAlign.SpaceBetween)
      //                 .width('100%')
      //               }
      //               .flexGrow(1)
      //               .padding({ right: 12 })
      //             }.width('100%').height(120).padding(10)
      //             .backgroundColor(Color.White)
      //           })
      //         }.width('100%').flexGrow(1)
      //         .height('100%')
      //       }.scrollable(ScrollDirection.Vertical)
      //       .flexGrow(1)
      //
      //       Row() {
      //         // 全选框
      //         CheckboxGroup({ group: 'checkboxGroup' })
      //           .selectedColor('#007DFF')
      //           .onClick(() => {
      //             this.isAllSelected = !this.isAllSelected
      //             if (this.isAllSelected) {
      //               this.selectedGoods = this.goods
      //             } else {
      //               this.selectedGoods = []
      //             }
      //           })
      //         // .onChange((itemName: CheckboxGroupResult) => {
      //         //   console.info("全选事件获得的参数" + JSON.stringify(itemName.status))
      //         // })
      //
      //         Text('全选')
      //         Blank()
      //         if (this.totalPrice > 0 && this.isFlag) {
      //           Text('合计：').fontSize(12).fontColor('#808080')
      //           Text('￥').fontSize(12).fontColor('#dc1c22').baselineOffset(-2)
      //           Text('' + this.totalPrice.toFixed(2)).fontSize(15).fontColor('#dc1c22')
      //         }
      //         // if (this.isFlag) {
      //         //   Text(this.selectedCount == 0 ? '结算' : '结算(' + this.selectedCount + ')')
      //         //     .width(80)
      //         //     .height(32)
      //         //     .backgroundColor('#dc1c22')
      //         //     .fontColor(Color.White)
      //         //     .fontSize(16)
      //         //     .textAlign(TextAlign.Center)
      //         //     .borderRadius(20)
      //         //     .margin({ left: 10 })
      //         //     .onClick(() => {
      //         //       if (this.defaultAddress.consignee == '') {
      //         //         promptAction.showToast({
      //         //           message: '请先创建默认收货地址',
      //         //           duration: 2000
      //         //         })
      //         //       }
      //         //       else {
      //         //         let buyItems = []
      //         //         let noBuyItems = []
      //         //         this.goods.forEach(item => {
      //         //           let a = item
      //         //           if (item.isSelected) {
      //         //             buyItems.push(item)
      //         //           } else {
      //         //             noBuyItems.push(item)
      //         //           }
      //         //         })
      //         //         let userId = this.defaultAddress.id;
      //         //         // buyGoods(userId, this.totalPrice, buyItems).then((res) => {
      //         //         //   let data = JSON.parse(res.result.toString());
      //         //         //   if (data.code = 20000) {
      //         //         //     this.goods = noBuyItems;
      //         //         //     router.pushUrl({ url: 'pages/BuyResultPage' })
      //         //         //   }
      //         //         //   promptAction.showToast({
      //         //         //     message: data.message,
      //         //         //     duration: 2000
      //         //         //   })
      //         //         // })
      //         //       }
      //         //     })
      //         // } else {
      //         //   Text("删除")
      //         //     .width(80)
      //         //     .height(32)
      //         //     .backgroundColor(Color.White)
      //         //     .fontColor(Color.Gray)
      //         //     .fontSize(12)
      //         //     .textAlign(TextAlign.Center)
      //         //     .borderRadius(20)
      //         //     .onClick(() => {
      //         //       this.doDeleteGoods();
      //         //     })
      //         // }
      //
      //       }
      //       .height(100)
      //       .width('100%')
      //       .justifyContent(FlexAlign.SpaceBetween)
      //       .backgroundColor('rgba(255,255,255,0.7)')
      //       // Panel(this.show) {
      //       //   Column() {
      //       //     Text('更换地址').height(50)
      //       //     Divider()
      //       //     List() {
      //       //       ForEach(this.addresses, (item, index) => {
      //       //         ListItem() {
      //       //           Row() {
      //       //             Radio({ value: item.id, group: 'addgroup' }).checked(item.isDefault)
      //       //               .onChange((isChecked: boolean) => {
      //       //                 if (isChecked) {
      //       //                   // this.selectAddressIndex = index;
      //       //                 }
      //       //               })
      //       //             Text(item.addressDetail)
      //       //             Text(item.phone)
      //       //           }.width('100%').height(50)
      //       //         }.padding(10)
      //       //       }, item => item.id)
      //       //     }
      //       //
      //       //     Button("选择地址", { type: ButtonType.Normal })
      //       //       .width('90%')
      //       //       .onClick(() => {
      //       //         // this.defaultAddress = this.addresses[this.selectAddressIndex];
      //       //         this.show = false;
      //       //       })
      //       //       .borderRadius(10)
      //       //       .height(40)
      //       //       .margin({ top: 20 })
      //       //   }
      //       // }
      //       // .type(PanelType.Foldable)
      //       // .mode(PanelMode.Half)
      //       // .dragBar(true) // 默认开启
      //       // .halfHeight(900) // 默认一半
      //       // .fullHeight(700)
      //       // .onChange((width: number, height: number, mode: PanelMode) => {
      //       //   console.info(`width:${width},height:${height},mode:${mode}`)
      //       // })
      //     }
      //   }
      // }
      // .onRefreshing(()=>{
      //   setTimeout(() => {
      //     this.getGoods()
      //     this.isRefreshing = false
      //   }, 1000)
      // })
    }.height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}