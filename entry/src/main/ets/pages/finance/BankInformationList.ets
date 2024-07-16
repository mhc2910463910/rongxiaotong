/**
 * 银行信息列表
 */
import router from '@ohos.router';
import { getBankApi } from '../../api/finance';
import { IResponse } from '../../models/common';
import { IBank } from '../../models/finance';

@Entry
@Component
struct BankInformationList {
  @State bankList: Array<IBank> = [];
  @State bankMap: Array<IBank> = [];
  private scroller: Scroller = new Scroller()

  async handleLoadBank() {
    try {
      const res = await getBankApi()
      const data: IResponse<Array<IBank>> = <IResponse<Array<IBank>>> JSON.parse(res.result.toString())
      // data.data.forEach((item: IBank) => {
      //   this.bankList.push(item)
      //   this.bankMap[item.bankId] = item
      // })
      for(let item of data.data) {
        this.bankList.push(item)
        this.bankMap[item.bankId] = item
      }
      globalThis.bankMap = this.bankMap;
    } catch (error) {
      console.error('handleLoadBank.error: ', error.message)
    }
  }

  aboutToAppear() {
    console.info('bankList出现')
    this.handleLoadBank()
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('银行信息列表')
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
              // router.replaceUrl({ url: routerUrl })
              router.back()
            })
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })
        //信息列表
        Scroll(this.scroller) {
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.bankList, (item: IBank) => {
              Row() {
                Image(`assets/bank${item.bankId}.jpg`)
                  .objectFit(ImageFit.Cover)
                  .borderRadius(10)
              }
              .width('47%')
              .height(188)
              .borderRadius(5)
              .borderWidth(1)
              .borderColor(Color.Gray)
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .shadow({ radius: 5, color: Color.Gray, offsetX: 5, offsetY: 5 })
              .margin(5)
              .onClick(() => {
                // const routerList: Array<string> = globalThis.routerList;
                // routerList.push(`${router.getState().path}${router.getState().name}`)
                // globalThis.routerList = routerList
                router.pushUrl({ url: 'pages/finance/BankInformation', params: { 'bankDetail': item } })
              })
            })
          }
          .padding({ bottom: 20 })
          .margin({ bottom: 80 })
        }
        .width('100%')
        .height('100%')
        .scrollable(ScrollDirection.Vertical)
      }
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}