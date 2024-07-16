import router from '@ohos.router'
import { baseUrl } from '../api/BaseData';
import { getExpertInfosByPageNum } from '../api/ExpertInfoAPI'

@Entry
@Component
struct ExpertInfoPage {
  @State pageNum: number = 1;
  @State infos: Array<any> = []

  aboutToAppear() {
    // 请求
    this.getData()
  }

  getData() {
    getExpertInfosByPageNum(this.pageNum).then((res) => {
      this.infos = JSON.parse(res.result.toString()).data.list;
    })
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('专家指导')
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
        Flex() {
          Button('问答信息列表', { type: ButtonType.Normal }).flexGrow(1).backgroundColor('#94a3b8').height('100%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/ExpertFAQPage'
              })
            })
          Button('专家信息列表', { type: ButtonType.Normal }).flexGrow(1).backgroundColor('#059669').height('100%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/ExpertInfoPage'
              })
            })
        }.width('100%').height(60)

        Column() {
          ForEach(this.infos, (item,index) => {
            Flex({ alignItems: ItemAlign.Center }) {
              Image($r('app.media.experta')).width(64).objectFit(ImageFit.Contain)
                .margin({ right: 8 })
              Row() {
                Column() {
                  Text('专家姓名: ' + item.realName).fontSize(18).lineHeight(18)
                  Text('职称: ' + item.position).fontSize(12).margin({bottom: 8})
                  Text('从事专业: ' + item.profession).fontSize(12).margin({bottom: 8})
                  Text('联系电话: ' + item.phone).fontSize(12).margin({bottom: 8})
                  Text('单位: ' + item.belong).fontSize(12)
                }.height('100%').alignItems(HorizontalAlign.Start)

                Column() {
                  Text('向我提问').margin({ bottom: 24 }).onClick(()=>{
                    router.pushUrl({
                      url: 'pages/AskPage',
                      params: {
                        expertName: item.realName
                      }
                    })
                  })
                  Text('线下预约').onClick(()=>{
                    router.pushUrl({
                      url: 'pages/ExpertReservePage',
                      params: {
                        expertName: item.realName
                      }
                    })
                  })
                }.height('100%').justifyContent(FlexAlign.Center)
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .flexGrow(1)
            }.width('100%')
            .height(120)
            .padding({ left: 10, top: 10, bottom: 10, right: 24 })

            Divider().width('90%')
            // Text(String(index))

          }, item => item)
        }
      }.backgroundColor(Color.White).borderRadius(8)
      .zIndex(-1).margin({ "top": 70, "bottom": 10 })
    }.width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
    .height('100%')
  }
}