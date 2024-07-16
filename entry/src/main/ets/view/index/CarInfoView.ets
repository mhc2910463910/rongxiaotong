import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import { baseUrl } from '../../api/BaseData';
import {
  buyGoods,
  deleteCarGoods,
  getAllAddress,
  getCarInfoList,
  getDefaultAddress,
  updateCarGoodsInfo
} from '../../api/CarApi';
import thermal from '@ohos.thermal';
import { IAddresssModel } from '../../models/Address';

@Preview
@Component
export struct CarInfo {
  // 是否全选
  @State isAllSelected: boolean = false;
  // 商品列表
  @State goodsSrc: Array<any> = [];
  // 商品列表长度
  @State goodSrcLength: number = 0;
  // 默认收货地址
  // @State defaultAddress: IAddresssModel = new IAddresssModel({
  //   consignee: '',
  //   addressDetail: '北京市海淀区',
  //   phone: ''
  // })
  @State defaultAddress: any = {
    consignee: '1001',
    addressDetail: '甘肃兰州',
    phone: '12345678901'
  }
  // 收货地址列表
  @State addresses: Array<any> = [];
  // 选中的商品
  @State chs: Array<any> = [];
  // 是否显示地址栏
  @State show: boolean = false;
  // 总价格
  @State totalPrice: number = 0;
  @State checkBoxNames: Array<string> = []
  //控制显示完成和编辑
  @State isFlag: boolean = true;
  // 选中的总数
  @State selectedCount: number = 0;
  // 用户id
  @State userId: string = '';
  @State selectAddressIndex: number = 0;
  // 获取购物车信息
  getCarInfo() {
    getCarInfoList().then((res) => {
      let carData = JSON.parse(res.result.toString()).data;
      for (let index = 0; index < carData.length; index++) {
        let item = carData[index];
        let newItem = {
          shoppingId: item.shoppingId,
          content: item.content,
          count: item.count,
          orderId: item.orderId,
          ownName: item.ownName,
          picture: item.picture,
          price: item.price,
          isSelected: false,
          title: item.title
        }
        this.goodsSrc.push(newItem)
      }
      this.goodSrcLength = this.goodsSrc.length
      this.goodsSrc.forEach(item => {
        let a = item
        console.log('aaa')
      })
      let data = this.goodsSrc
      console.log('aaa')
    })

  }
  // 获取默认地址和所有地址
  // 获取默认地址和所有地址
  getAddress(){
    getDefaultAddress().then((res)=>{
      let address=JSON.parse(res.result.toString()).data
      //如果不为空，则更新默认地址
      if(address!=null){
        this.defaultAddress = address
      }
    })
    getAllAddress().then((res)=>{
      this.addresses = JSON.parse(res.result.toString()).data
    })
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
    this.goodsSrc.splice(index, 1, newItem)
    this.calculateTotalPrice()
  }
  // 计算合计
  calculateTotalPrice() {
    let total = 0
    this.selectedCount = 0
    for (const item of this.goodsSrc) {
      if (item.isSelected) {
        this.selectedCount++
        total += parseFloat(item.price) * parseInt(item.count)
      }
    }
    this.totalPrice = total
    this.isAllSelected = this.selectedCount === this.goodsSrc.length
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
    this.goodsSrc.splice(index, 1, newItem)
    this.calculateTotalPrice()
    this.updateCarGoodsNum(item);

  }
  //修改商品的购买数量
  updateCarGoodsNum(item) {
    updateCarGoodsInfo(item.shoppingId, item.count).then((res) => {
      console.info("=============data=====", JSON.stringify(res))
    })
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
          for (let item of this.goodsSrc) {
            if (item.isSelected) {
              deleteCarGoods(item.shoppingId).then((res) => {
                console.log(res.toString())
              })
            }
          }
          if (this.isAllSelected) {
            this.goodsSrc = []
            this.totalPrice = 0
            this.isAllSelected = false
          } else {
            const newArray: Array<any> = []
            for (const item of this.goodsSrc) {
              if (!item.isSelected) {
                newArray.push(item)
              }
            }
            this.goodsSrc = newArray
            this.calculateTotalPrice()
          }
        }
      }
    })
  }

  // 商品详情
  @Builder GoodsItem(item, index) {
    Row() {
      Row() {
        Image(item.isSelected ? $r('app.media.selected_on') : $r('app.media.selected_off')).width(22).height(22)
      }.width(45).height('100%').justifyContent(FlexAlign.Center)
      .onClick(() => {
        item.isSelected = !item.isSelected
        this.selectOperation(item, index)
      })

      Image(baseUrl + "/file/" + item.picture).width(90)
        .border({ width: 0.5, color: '#CFCFCF', radius: 5 })
        .margin({ top: 10, bottom: 10, right: 10 })
      Column() {
        Text(item.title).fontSize(14).fontColor('#ff323232')
        if (item.content != '') {
          Text(item.content)
            .fontSize(12)
            .fontColor('#ff6a6a6a')
              // .backgroundColor('#F4F4F4')
            .borderRadius(5)
            .padding({ left: 5, right: 5, top: 2, bottom: 2 })
            .margin({ top: 5 })
        }
        Blank()
        Row() {
          Text('￥' + item.price).fontSize(15).fontColor('#dc1c22')
          Blank()
          Row() {
            Text('－')
              .fontColor('#484848')
              .fontSize(10)
              .width(18)
              .height(18)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.addOrSubtractOperation(item, index, -1)
              })
            Divider().strokeWidth(1).color('#a1a1a1').vertical(true).height(18)
            Text('' + item.count)
              .width(30)
              .height(18)
              .fontSize(11)
              .fontColor('#484848')
              .textAlign(TextAlign.Center)

            Divider().strokeWidth(1).color('#a1a1a1').vertical(true).height(18)
            Text('＋')
              .fontColor('#484848')
              .fontSize(14)
              .width(18)
              .height(18)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.addOrSubtractOperation(item, index, 1)
              })
          }.border({ width: 1, color: '#a1a1a1', radius: 3 })
        }.width('100%').margin({ top: 5 }).alignItems(VerticalAlign.Bottom)
      }
      .layoutWeight(1)
      .height('100%')
      .padding({ top: 15, bottom: 15, right: 10 })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }.width('100%').height(120).backgroundColor(Color.White).margin({ bottom: 5 })
  }

  aboutToAppear() {
    console.info('购物车出现aboutToAppear')
    this.getCarInfo()
    this.getAddress()
  }

  build() {
    Column() {
      if (!globalThis.token) {
        Column() {
          Image($r('app.media.illustration_3x')).width(200).height(200)
          Text("未登录")
            .fontSize(24)
            .fontColor('#0F172A')
            .height(50)
            .lineHeight(50)
            .fontWeight(400)
          Text('请先登录！').fontSize(16).fontColor('#64748B').height(30).lineHeight(30)
          Text('去登录')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#059669')
            .height(60)
            .width(260)
            .borderRadius(12)
            .margin({ top: 30 })
            .textAlign(TextAlign.Center)
            .fontWeight(400)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/LoginPage'
              })
            })
        }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
        .width('100%').height('100%')
      }
      else if (this.goodSrcLength == 0) {
        Column() {
          Image($r('app.media.illustration_3x')).width(200).height(200)
          Text("购物车是空的")
            .fontSize(24)
            .fontColor('#0F172A')
            .height(50)
            .lineHeight(50)
            .fontWeight(400)
          Text('快去看看吧！').fontSize(16).fontColor('#64748B').height(30).lineHeight(30)
          Text('去购物')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#059669')
            .height(60)
            .width(260)
            .borderRadius(12)
            .margin({ top: 30 })
            .textAlign(TextAlign.Center)
            .fontWeight(400)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/GoodsPage',
                params: { 'type': 'goods' }
              })
            })
        }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
        .width('100%').height('100%')
      } else {
        Row() {
          Row() {
            Image($r('app.media.dingwei')).width(40).height(40).margin({ left: 0, right: 5 })
            Text(this.showAddress(this.defaultAddress.addressDetail)).fontColor(Color.Grey)
          }.onClick(() => {
            this.show = true
          })

          Blank()
          Text(this.isFlag ? '编辑' : '完成').fontSize(16).fontColor(Color.Grey)
            .onClick(() => {
              this.isFlag = !this.isFlag;
            })

        }.height(60).width('100%')
        .padding({ left: 0, right: 20 })
        .backgroundColor('#f3f3f3')

        Stack() {
          Column() {
            Row() {
              Text("全部 " + this.goodsSrc.length + " 种").margin({ left: 20 }).width('100%')
                .fontColor(Color.Red)
            }.height(50).backgroundColor('rgba(255,255,255,0.5)')
            .margin({ bottom: 5 })

            List() {
              ForEach(this.goodsSrc, (item, index) => {
                ListItem() {
                  this.GoodsItem(item, index)
                }
              }, item => JSON.stringify(item))
            }.layoutWeight(1)
            .onAppear(() => {

            })
            .visibility(this.show ? Visibility.Hidden : Visibility.Visible)

            Row() {
              Row() {
                Image(this.isAllSelected ? $r('app.media.selected_on') : $r('app.media.selected_off'))
                  .width(22)
                  .height(22)
                Text('全选').fontSize(13).margin({ left: 5, top: 3 })
              }.onClick(() => {
                let temp = this.goodsSrc;
                this.goodsSrc = new Array();
                this.isAllSelected = !this.isAllSelected
                for (const item of temp) {
                  let newItem = {
                    shoppingId: item.shoppingId,
                    content: item.content,
                    count: item.count,
                    orderId: item.orderId,
                    ownName: item.ownName,
                    picture: item.picture,
                    price: item.price,
                    isSelected: this.isAllSelected,
                    title: item.title
                  }
                  this.goodsSrc.push(newItem)
                }
                this.calculateTotalPrice()
              })

              Blank()
              if (this.totalPrice > 0 && this.isFlag) {
                Text('合计：').fontSize(12).fontColor('#808080')
                Text('￥').fontSize(12).fontColor('#dc1c22').baselineOffset(-2)
                Text('' + this.totalPrice.toFixed(2)).fontSize(15).fontColor('#dc1c22')
              }
              if (this.isFlag) {
                Text(this.selectedCount == 0 ? '结算' : '结算(' + this.selectedCount + ')')
                  .width(80)
                  .height(32)
                  .backgroundColor('#dc1c22')
                  .fontColor(Color.White)
                  .fontSize(16)
                  .textAlign(TextAlign.Center)
                  .borderRadius(20)
                  .margin({ left: 10 })
                  .onClick(()=>{
                    if(this.defaultAddress.consignee==''){
                      promptAction.showToast({
                        message:'请先创建默认收货地址',
                        duration:2000
                      })
                    }
                    else{
                      let buyItems=[]
                      let noBuyItems=[]
                      this.goodsSrc.forEach(item=>{
                        let a =item
                        if(item.isSelected){
                          buyItems.push(item)
                        }else{
                          noBuyItems.push(item)
                        }
                      })
                      let userId=this.defaultAddress.id;
                      buyGoods(userId,this.totalPrice,buyItems).then((res)=>{
                        let data=JSON.parse(res.result.toString());
                        if(data.code=20000){
                          this.goodsSrc=noBuyItems;
                          router.pushUrl({url:'pages/BuyResultPage'})
                        }
                        promptAction.showToast({
                          message:data.message,
                          duration:2000
                        })
                      })
                    }
                  })
              } else {
                Text("删除")
                  .width(80)
                  .height(32)
                  .backgroundColor(Color.White)
                  .fontColor(Color.Gray)
                  .fontSize(12)
                  .textAlign(TextAlign.Center)
                  .borderRadius(20)
                  .onClick(() => {
                    this.doDeleteGoods();
                  })
              }


            }
            .visibility(this.show ? Visibility.Hidden : Visibility.Visible)
            .width('100%')
            .height(60)
            .backgroundColor('rgba(255,255,255,0.2)')
            .padding({ left: 20, right: 20 })
          }.layoutWeight(1).padding({ bottom: 70 })


          //显示用户地址
          Panel(this.show) {
            Column() {
              Text('更换地址').height(50)
              Divider()
              List() {
                ForEach(this.addresses, (item, index) => {
                  ListItem() {
                    Row() {
                      Radio({ value: item.id, group: 'addgroup' }).checked(item.isDefault)
                        .onChange((isChecked: boolean) => {
                          if (isChecked) {
                            this.selectAddressIndex = index;
                          }
                        })
                      Text(item.addressDetail)
                      Text(item.phone)
                    }.width('100%').height(50)
                  }.padding(10)
                }, item => item.id)
              }

              Button("选择地址", { type: ButtonType.Normal })
                .width('90%')
                .onClick(() => {
                  this.defaultAddress = this.addresses[this.selectAddressIndex];
                  this.show = false;
                })
                .borderRadius(10)
                .height(40)
                .margin({ top: 20 })
            }
          }
          .type(PanelType.Foldable)
          .mode(PanelMode.Half)
          .dragBar(true) // 默认开启
          .halfHeight(900) // 默认一半
          .fullHeight(700)
          .onChange((width: number, height: number, mode: PanelMode) => {
            console.info(`width:${width},height:${height},mode:${mode}`)
          })
        }.height('100%').flexGrow(1)
      }

    }
    .width('100%')
    .height('100%')
    // .backgroundColor('#fafafa')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}