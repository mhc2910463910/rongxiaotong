/*
我买的
 */
import router from '@ohos.router'
import { baseUrl } from '../api/BaseData'
import {getMyBuysList} from '../api/ExpertFAQApi'
@Entry
@Component
struct MyBuys{
  @State type: string="我买的"
  @State mybuysList: Array<any> =[]
  async aboutToAppear(){
    this.getQuestions()
  }
  getQuestions(){
    getMyBuysList().then((res)=>{
      let DataArray=JSON.parse(res.result.toString())
        .data;
      for(let index=0;index<DataArray.length;index++){
        const element=DataArray[index];
        this.mybuysList.push(element);
      }
    })
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
      Grid() {
        ForEach(this.mybuysList, (item, i) => {
          GridItem() {
            Flex({direction: FlexDirection.Row}) {
              Column(){
                Image(`${baseUrl}/file/${item.picture}`)
                  .width(100)
                  .height(100)
                  .borderRadius(10)
              }
              Column() {
                Text(`姓名: ${item.ownName}`)
                  .fontSize(18)
                  .fontWeight(600)
                Text(`创建日期: ${item.createTime.split('T')[0]}`)
                Text(`更新日期: ${item.updateTime.split('T')[0]}`)
                Text(`收货地址: ${item.address}`)
                Row() {
                  Text(`￥: ${item.totalPrice}`)
                    .fontColor(Color.Red)
                  Blank()
                  if (item.purchaseStatus) {
                    Text("已发货")
                      .width(70)
                      .height(30)
                      .backgroundColor('#00CDCD')
                      .fontColor(Color.White)
                      .textAlign(TextAlign.Center)
                      .borderRadius(10)
                  } else {
                    Text("未发货")
                      .width(70)
                      .height(30)
                      .backgroundColor('#FFE4E1')
                      .fontColor('#CD5C5C')
                      .textAlign(TextAlign.Center)
                      .borderRadius(10)
                  }
                }.width('50%')
              }.alignItems(HorizontalAlign.Start)
              .padding(10)
            }.width('100%')
          }.height(130)
          .padding(10)
          .borderRadius(10)
          .margin(5)
          .backgroundColor(Color.White)
        })
      }.rowsGap(12)
      .columnsTemplate('1fr')
      .backgroundImage($r('app.media.bg4'))
      .backgroundImageSize(ImageSize.Cover)
    }
  }
}