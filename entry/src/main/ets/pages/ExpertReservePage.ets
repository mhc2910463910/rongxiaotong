import router from '@ohos.router'

@Entry
@Component
struct ExpertReservePage {
  @State address: string = ''
  @State plant: string = ''
  @State detail: string = ''
  @State plantCondition: string = ''
  @State soilCondition: string = ''
  @State area: string = ''
  @State phoneNumber: string = ''
  @State expertName:string = ''
  aboutToAppear(){
    // 获取参数
    this.expertName = router.getParams()['expertName']
    console.info(this.expertName)
  }
  submit() {

  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('预约专家')
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
            Text('地址: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.address = value
              })
          }

          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('种植作物: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.plant = value
              })
          }

          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('作物详情: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.plant = value
              })
          }

          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('作物条件: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.plantCondition = value
              })
          }
          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('土壤条件: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.soilCondition = value
              })
          }
          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('面积: ').maxLines(1).width(120)
            TextInput().height(48).backgroundColor(Color.Transparent)
              .onChange(value => {
                this.area = value
              })
          }
          Divider()
          Flex({ alignItems: ItemAlign.Center }) {
            Text('电话: ').maxLines(1).width(120)
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