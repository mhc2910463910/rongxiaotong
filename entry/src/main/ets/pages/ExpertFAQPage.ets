import router from '@ohos.router'
import { getExpertFAQsByPageNum } from '../api/ExpertFAQApi'

@Entry
@Component
struct ExpertFAQPage {
  @State message: string = ''
  @State faqs: Array<any> = []

  aboutToAppear() {
    getExpertFAQsByPageNum(1).then(res => {
      console.info(res.result.toString())
      let faqArray = JSON.parse(res.result.toString()).data.list;
      for (let index = 0;index < faqArray.length; index++) {
        const element = faqArray[index]
        this.faqs.push(element)
      }
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
          Button('问答信息列表', { type: ButtonType.Normal }).flexGrow(1).backgroundColor('#059669').height('100%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/ExpertFAQPage'
              })
            })
          Button('专家信息列表', { type: ButtonType.Normal }).flexGrow(1).backgroundColor('#94a3b8').height('100%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/ExpertInfoPage'
              })
            })
        }.width('100%').height(60)

        Column() {
          ForEach(this.faqs, item => {
            Row() {
              Text(`[问]${item.title}`)
              Row() {
                Text(`提问者${item.questioner}  专家:${item.expertName}`)
              }
              .alignSelf(ItemAlign.End)
              .margin({ bottom: 10 })

            }.height(80).width('100%').justifyContent(FlexAlign.SpaceBetween)
            Divider().width('90%')
            Row() {
              Text(`[答]${item.title}`)
              Row() {
                Text(`提问者${item.questioner}  专家:${item.expertName}`)
              }
              .alignSelf(ItemAlign.End)
              .margin({ bottom: 10 })

            }.height(80).width('100%').justifyContent(FlexAlign.SpaceBetween)
            .padding({ left: 15, right: 15 })
            Row() {
              Text(`[答]${item.title}`)
              Row() {
                Text(`提问者${item.questioner}  专家:${item.expertName}`)
              }
              .alignSelf(ItemAlign.End)
              .margin({ bottom: 10 })

            }.height(80).width('100%').justifyContent(FlexAlign.SpaceBetween)
            .padding({ left: 15, right: 15 })
            // 只有不为null时显示出来
            .visibility(item.answer?Visibility.Visible:Visibility.None)
            Divider().width('90%').visibility(item.answer?Visibility.Visible:Visibility.None)
          }, item => item)
        }

        Divider().width('90%')
      }
      .backgroundColor(Color.White).borderRadius(8)
      .zIndex(-1).margin({ "top": 70, "bottom": 10 })
    }
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
    .height('100%')
  }
}