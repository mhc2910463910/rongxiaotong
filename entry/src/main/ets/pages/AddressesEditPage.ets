/**
 * 我的收货地址编辑
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { addAddressApi, deleteAddressApi, editAddressApi } from '../api/AddressApi';
// import {  } from '../models/address';
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
struct MineShippingAddressEdit {
  @State addressDetail: IAddress = { isDefault: false };
  @State type: string = ''
  @State title: string = '编辑收货地址'

  handleDeleteAddress() {
    AlertDialog.show({
      title: '提示',
      message: "你确定要删除该地址吗？",
      primaryButton: {
        value: '取消',
        action: () => {
        }
      },
      secondaryButton: {
        value: '删除',
        action: async () => {
          try {
            const res = await deleteAddressApi(this.addressDetail.id)
            const code = JSON.parse(res.result.toString()).code;
            if (code == 20000) {
              promptAction.showToast({
                message: '删除成功!',
                duration: 1000,
              });
              setTimeout(() => {
                // const routerList: Array<string> = globalThis.routerList
                // const routerUrl = routerList.pop();
                // globalThis.routerList = routerList;
                router.replaceUrl({ url: 'pages/AddressesEditPage' })
              }, 1000)
            } else {
              promptAction.showToast({
                message: '删除失败!',
                duration: 2000,
              });
            }
          } catch (error) {
            console.error('handleDeleteAddress.error: ', error.message)
          }
        }
      }
    })
  }

  async handleSaveAddress() {
    console.info('handleSaveAddress: ', JSON.stringify(this.addressDetail))
    if (!/^1[3-9][0-9]{9}$/.test(this.addressDetail.phone)) {
      promptAction.showToast({
        message: '手机号码输入有误!',
        duration: 2000,
      });
      return;
    }
    if (this.type == 'edit') {
      try {
        const res = await editAddressApi(this.addressDetail)
        const code = JSON.parse(res.result.toString()).code;
        if (code == 20000) {
          promptAction.showToast({
            message: '修改成功!',
            duration: 1000,
          });
          setTimeout(() => {
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          }, 1000)
        } else {
          promptAction.showToast({
            message: '修改失败!',
            duration: 2000,
          });
        }
      } catch (error) {
        console.error('handleSaveAddress.editAddressApi.error: ', error.message)
      }
    } else {
      try {
        const res = await addAddressApi(this.addressDetail)
        const code = JSON.parse(res.result.toString()).code;
        if (code == 20000) {
          promptAction.showToast({
            message: '添加成功!',
            duration: 1000,
          });
          setTimeout(() => {
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          }, 1000)
        } else {
          promptAction.showToast({
            message: '添加失败!',
            duration: 2000,
          });
        }
      } catch (error) {
        console.error('handleSaveAddress.editAddressApi.error: ', error.message)
      }
    }
  }

  aboutToAppear() {
    this.type = router.getParams()['type']

    if (this.type == 'edit') {
      this.addressDetail = router.getParams()['addressDetail']
    } else {
      this.title = '新建收货地址'
    }
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text(this.title)
            .width('100%')
            .height(60)
            .fontSize(20)
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontColor(Color.Grey)
          Row() {
            if (this.type == 'edit') {
              Text('删除')
                .margin({ right: 10 })
                .onClick(() => this.handleDeleteAddress())
            }
          }
          .justifyContent(FlexAlign.End).width('100%')

          Image($r('app.media.iv_back_selected'))
            .width(40)
            .height(40)
            .margin({ left: 10 })
            .onClick(() => {
              // const routerList: Array<string> = globalThis.routerList
              // const routerUrl = routerList.pop();
              // globalThis.routerList = routerList;
              // router.replaceUrl({ url: routerUrl })
              router.back()
            })
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })

        Column() {
          List() {
            ListItem() {
              Row() {
                Text('收货人:')
                  .width(100)
                TextInput({ text: this.addressDetail.consignee })
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
                  .onChange((value: string) => this.addressDetail.consignee = value)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Text('收货地址:')
                  .width(100)
                TextInput({ text: this.addressDetail.addressDetail })
                  .onChange((value: string) => this.addressDetail.addressDetail = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Text('手机号码:')
                  .width(100)
                TextInput({ text: this.addressDetail.phone })
                  .onChange((value: string) => this.addressDetail.phone = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')

          Column() {
            Row() {
              Column() {
                Text('设置为默认地址')
                  .height(60)
                Text('提醒:下单会优先使用该地址')
                  .fontSize(12)
                  .fontColor('rgba(0,0,0,0.4)')
                  .height(30)
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Toggle({ type: ToggleType.Switch, isOn: this.addressDetail.isDefault })
                  .selectedColor(Color.Red)
                  .switchPointColor(0xe5ffffff)
                  .onChange((value: boolean) => this.addressDetail.isDefault = value)
              }
            }
            .width("100%")
            .justifyContent(FlexAlign.SpaceBetween)

          }
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')
          .padding({ left: 20, right: 20 })
        }
        .layoutWeight(1)

        Row() {
          Button("保存")
            .fontColor(Color.White)
            .backgroundColor(Color.Red)
            .type(ButtonType.Normal)
            .width('100%')
            .borderRadius(20)
            .onClick(() => this.handleSaveAddress())
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