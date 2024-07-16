/**
 * 我的收货地址管理
 */
import router from '@ohos.router'
import { getAllAddressApi } from '../api/AddressApi'
import { IResponse } from '../models/common'
type IAddress = {
  addressDetail?: string
  consignee?: string
  id?: number
  isDefault?: boolean
  ownName?: string
  phone?: string
}
@Entry
@Component
struct MineShippingAddressManage {
  @State addressList: Array<IAddress> = []

  async handleLoadAddressList() {
    try {
      const res = await getAllAddressApi()
      const data: IResponse<Array<IAddress>> = <IResponse<Array<IAddress>>> JSON.parse(res.result.toString())
      // .forEach((item: IAddress) => this.addressList.push(item))
      for(let item of data?.data){
        this.addressList.push(item)
      }
    } catch (error) {
      console.error('handleLoadAddressList.error: ', error.message)
    }
  }

  handleShowPhone(phone: string) {
    return phone.substring(0, 3) + "****" + phone.substring(7);
  }

  aboutToAppear() {
    this.addressList = [];
    this.handleLoadAddressList();
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('地址管理')
            .width('100%')
            .height(60)
            .fontSize(20)
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontColor(Color.Grey)
          Image($r('app.media.iv_back_selected'))
            .width(40)
            .height(40)
            .margin({ left: 10 })
            .onClick(() => {
              // const routerList: Array<string> = globalThis.routerList
              // const routerUrl = routerList.pop();
              // globalThis.routerList = routerList;
              // router.({ url: routerUrl })
              router.back()
            })
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })

        Row() {
          List() {
            ForEach(this.addressList, (item: IAddress) => {
              if (item.isDefault) {
                ListItem() {
                  Row() {
                    Column() {
                      Text(item.addressDetail)
                        .fontColor(Color.Black)
                        .fontSize(16)
                        .height(50)
                      Row() {
                        Text(item.consignee)
                          .fontSize(12)
                          .fontColor(Color.Gray)
                          .margin({ right: 10 })
                        Text(this.handleShowPhone(item.phone))
                          .fontSize(12)
                          .fontColor(Color.Gray)
                          .margin({ right: 10 })
                        if (item.isDefault) {
                          Text('默认')
                            .backgroundColor(Color.Red)
                            .fontColor(Color.White)
                            .fontSize(12)
                        }
                      }
                      .height(30)
                    }
                    .layoutWeight(1)
                    .alignItems(HorizontalAlign.Start)

                    Column() {
                      Text()
                        .backgroundImage($r('app.media.edit'))
                        .width(20)
                        .height(20)
                        .backgroundImageSize(ImageSize.Cover)
                        .backgroundImagePosition({ x: 0, y: -115 })
                    }
                  }
                  .padding({ left: 20, right: 20, bottom: 10, top: 10 })
                  .justifyContent(FlexAlign.SpaceBetween)
                  .width('100%')
                  .onClick(() => {
                    // const routerList: Array<string> = globalThis.routerList;
                    // routerList.push(`${router.getState().path}${router.getState().name}`)
                    // globalThis.routerList = routerList
                    router.replaceUrl({
                      url: "pages/AddressesEditPage",
                      params: { type: 'edit', addressDetail: item }
                    })
                  })
                }
              }
            })
            ForEach(this.addressList, (item: IAddress) => {
              if (!item.isDefault) {
                ListItem() {
                  Row() {
                    Column() {
                      Text(item.addressDetail)
                        .fontColor(Color.Black)
                        .fontSize(16)
                        .height(50)
                      Row() {
                        Text(item.consignee)
                          .fontSize(12)
                          .fontColor(Color.Gray)
                          .margin({ right: 10 })
                        Text(this.handleShowPhone(item.phone))
                          .fontSize(12)
                          .fontColor(Color.Gray)
                          .margin({ right: 10 })
                        if (item.isDefault) {
                          Text('默认')
                            .backgroundColor(Color.Red)
                            .fontColor(Color.White)
                            .fontSize(12)
                        }
                      }
                      .height(30)
                    }
                    .layoutWeight(1)
                    .alignItems(HorizontalAlign.Start)

                    Column() {
                      Text()
                        .backgroundImage($r('app.media.edit'))
                        .width(20)
                        .height(20)
                        .backgroundImageSize(ImageSize.Cover)
                        .backgroundImagePosition({ x: 0, y: -115 })
                    }
                  }
                  .padding({ left: 20, right: 20, bottom: 10, top: 10 })
                  .justifyContent(FlexAlign.SpaceBetween)
                  .width('100%')
                  .onClick(() => {
                    // const routerList: Array<string> = globalThis.routerList;
                    // routerList.push(`${router.getState().path}${router.getState().name}`)
                    // globalThis.routerList = routerList
                    router.replaceUrl({
                      url: "pages/AddressesEditPage",
                      params: { type: 'edit', addressDetail: item }
                    })
                  })
                }
              }
            })

          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')

        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(VerticalAlign.Top)

        Row() {
          Button("新建收货地址")
            .fontColor(Color.White)
            .backgroundColor(Color.Red)
            .type(ButtonType.Normal)
            .width('100%')
            .borderRadius(20)
            .onClick(() => {
              // const routerList: Array<string> = globalThis.routerList;
              // routerList.push(`${router.getState().path}${router.getState().name}`)
              // globalThis.routerList = routerList
              console.info('新建收货地址')
              router.pushUrl({
                // url: 'pages/AddressesEditPage',
                url: "pages/AddressesEditPage",
                params: { type: 'add' }
              })
              console.info('router后')
            })
        }
        .alignItems(VerticalAlign.Bottom)
        .padding(10)
        .backgroundColor('#ffffff')
        .width('100%')
      }
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}