import router from '@ohos.router'
import { baseUrl } from '../api/BaseData'
import {getExpertFAQsByPageNum, getReverseList} from '../api/ExpertFAQApi'
/*
  我的问答模块
 */
@Entry
@Component
struct AllQuestion{
  @State type: string="我的预约"
  @State pageNum: number=1
  @State reverseList: Array<any> =[]
  @State reverse: any={}
  async aboutToAppear(){
    this.getQuestions()
  }
  getQuestions(){
    getReverseList().then((res)=>{
      let DataArray=JSON.parse(res.result.toString())
        .data;
      for(let index=0;index<DataArray.length;index++){
        const element=DataArray[index];
        if(element.questioner===globalThis.info.userName) {
          this.reverseList.push(element);
        }
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
        if(this.reverseList.length==0){
          GridItem(){
            Text("什么也没有").width('100%')
              .fontColor(Color.Gray)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .margin({top: 50})
          }
        }else {
          ForEach(this.reverseList, (item, i) => {
            GridItem() {
              Flex({ direction: FlexDirection.Column }) {
                Text(item.plantName)
                  .fontSize(18)
                  .fontWeight(600)
                Text(`专家名称: ${item.expertName}`)
                Text(`作物条件: ${item.soilCondition}`)
                Text(`土壤条件: ${item.plantCondition}`)
                Text(`面积: ${item.soilCondition}`)
                Row() {
                  if (item.answer == null) {
                    Text("未处理")
                      .width(70)
                      .height(30)
                      .backgroundColor('#FFE4E1')
                      .fontColor('#CD5C5C')
                      .textAlign(TextAlign.Center)
                      .borderRadius(10)
                  } else {
                    Text("已处理")
                      .width(70)
                      .height(30)
                      .backgroundColor('#00CDCD')
                      .fontColor(Color.White)
                      .textAlign(TextAlign.Center)
                      .borderRadius(10)
                  }
                  Blank()
                  Text("详情")
                    .onClick(() => {
                      this.reverse = item;
                      router.pushUrl({
                        url: "pages/ReversePage",
                        params: {
                          reverse: this.reverse
                        }
                      })
                      //AlertDialog.show({message: `${item.plantName} ${item.plantDetail}`})
                    }).padding(10)
                }.width('100%')
              }.width('100%')
            }
            .padding(10)
            .borderStyle(BorderStyle.Solid)
            .borderWidth(1)
            .borderRadius(20)
            .height(150)
            .width('95%')
            .margin({ left: 10, right: 10, top: 2 })
          })
        }
      }.rowsGap(12)
      .columnsTemplate('1fr')
      .backgroundImage($r('app.media.bg4'))
      .backgroundImageSize(ImageSize.Cover)
    }
  }
}
