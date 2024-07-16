/**
 * 银行信息详情
 */
import router from '@ohos.router';
import { IBank } from '../../models/finance';

@Entry
@Component
struct BankInformation {
  @State bankDetail: IBank = {};
  @State bankIdList: Array<string> = [];

  async handleLoadUserFinanceBankId() {
    try {
      this.bankIdList = []
      // const res = await ()
      // const data: IResponse<Array<IIntention>> = <IResponse<Array<IIntention>>> JSON.parse(res.result.toString())
      // if (data?.data.length > 0) {
      //   this.intention = data?.data[0] || {}
      //   this.hasIntention = true
      // }
    } catch (error) {
      console.error('handleLoadUserFinanceBankId.error: ', error.message)
    }
  }

  aboutToAppear() {
    // console.info('globalThis.routerList: ', globalThis.routerList)
    this.bankDetail = router.getParams()['bankDetail'];
    this.handleLoadUserFinanceBankId()
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text(this.bankDetail.bankName)
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

        Row() {
          Text("     " + this.bankDetail.introduce)
            .fontSize(16)
            .lineHeight(30)
        }
        .layoutWeight(1)
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .padding(10)

        Column() {
          Text('请选择贷款方式')
            .width('100%')
            .textAlign(TextAlign.Start)
          Row() {
            if (this.bankIdList.indexOf("[" + this.bankDetail.bankId + "]") == -1) {
              Button('个人贷款')
                .margin({ right: 10 })
                .onClick(() => {
                  // const routerList: Array<string> = globalThis.routerList;
                  // routerList.push(`${router.getState().path}${router.getState().name}`)
                  // globalThis.routerList = routerList
                  router.replaceUrl({
                    url: 'pages/finance/PersonalLoanInformationEdit',
                    params: { bankDetail: this.bankDetail }
                  })
                })
              Button('组合贷款')
                .onClick(() => {
                  // const routerList: Array<string> = globalThis.routerList;
                  // routerList.push(`${router.getState().path}${router.getState().name}`)
                  // globalThis.routerList = routerList
                  router.replaceUrl({
                    url: 'pages/finance/PortfolioLoanInformationEdit',
                    params: { bankDetail: this.bankDetail }
                  })
                })
            } else {
              Text("已申贷款")
                .backgroundColor("#f3d19e")
                .fontColor("#ffffff")
                .width(96)
                .height(40)
                .borderRadius(10)
                .textAlign(TextAlign.Center)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .height(60)
          .alignItems(VerticalAlign.Center)
        }
        .padding(10)
      }
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}