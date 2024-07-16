/*
  预约详情
 */
import router from '@ohos.router'
@Entry
@Component
struct ReversePage{
  @State type: string="预约信息"
  @State reverse: any={}
  aboutToAppear(){
    const params = router.getParams(); // 获取传递过来的参数对象
    this.reverse = params['reverse']; // 获取属性的值
  }
  build(){
    Flex({direction: FlexDirection.Column}) {
      Stack({ alignContent: Alignment.Start }) {
        Text(this.type)
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.back()
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })
      Flex({direction: FlexDirection.Column}){
        Row(){
            Text("种植作物:")
              .width('35%')
            Text(this.reverse.plantName)
              .width('65%')
        }.padding(10)
        .height(80)
        Divider()
        Row(){
            Text("作物详细信息:")
              .width('35%')
            Text(this.reverse.plantDetail)
              .width('65%')
        }.padding(10)
        .height(80)
        Divider()
        Row(){
          Text("地址:")
            .width('35%')
          Text(this.reverse.address)
            .width('65%')
        }.padding(10)
        .height(80)
        Divider()
        Row(){
          Text("土壤条件:")
            .width('35%')
          Text(this.reverse.soilCondition)
            .width('65%')
        }.padding(10)
        .height(80)
        Divider()
        Row(){
          Text("面积:")
            .width('35%')
          Text(this.reverse.area)
            .width('65%')
        }.padding(10)
        .height(80)
        Divider()
        Row(){
          Text("作物条件:")
            .width('35%')
          Text(this.reverse.plantCondition)
            .width('65%')
        }.padding(10)
        .height(80)
        Divider()
        Row(){
          Text("当前状态:")
            .width('35%')
          if (this.reverse.answer == null) {
            Text("未处理")
              .width(70)
              .backgroundColor('#FFE4E1')
              .fontColor('#CD5C5C')
              .textAlign(TextAlign.Center)
              .borderRadius(10)
          } else {
            Text("已处理")
              .width(70)
              .backgroundColor('#00CDCD')
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
          }
        }.padding(10)
        .height(80)
        Divider()
      }
    }
  }
}