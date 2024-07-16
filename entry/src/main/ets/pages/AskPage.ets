import router from '@ohos.router'

@Entry
@Component
struct AskPage {
  @State title: string = ''
  @State content: string = ''
  @State name: string = ''
  @State phoneNumber: string = ''
  @State expertName: string = ''
  aboutToAppear(){
    // 获取参数
    this.expertName = router.getParams()['expertName']
  }
  submit() {

  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('提问问题')
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

      Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween }) {
        Column() {
          Flex({ alignItems: ItemAlign.Center }) {
            Text('标题: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.title = value
              })
          }

          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('内容: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.content = value
              })
          }

          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('农作物名称: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.name = value
              })
          }

          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('手机号码: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.phoneNumber = value
              })
          }
        }
        .padding({ left: 12, right: 16 })
        .alignItems(HorizontalAlign.Center)

        Row() {
          Button() {
            Text('提交')
          }.width('100%').height(32)
          .backgroundColor(Color.Red)
          .onClick(this.submit)
        }.width('100%').justifyContent(FlexAlign.Center)
        .padding(10)
        .backgroundColor(Color.White)
      }
      .backgroundColor(Color.White)
      .borderRadius(8)
      .zIndex(-1)
      .margin({ top: 72 })
      .backgroundColor(Color.Transparent)
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}