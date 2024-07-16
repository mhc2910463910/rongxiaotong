import router from '@ohos.router'
import { baseUrl } from '../api/BaseData'
import {getExpertFAQsByPageNum, getQuestionList} from '../api/ExpertFAQApi'
/*
  我的问答模块
 */
@Entry
@Component
struct AllQuestion{
  @State show: boolean=false
  @State type: string="我的问答"
  @State pageNum: number=1
  @State questionList: Array<any> =[]
  @State currentItem: any={}
  async aboutToAppear(){
    this.getQuestions()
  }
  getQuestions(){
    getQuestionList().then((res)=>{
      let DataArray=JSON.parse(res.result.toString())
        .data;
      for(let index=0;index<DataArray.length;index++){
        const element=DataArray[index];
        if(element.questioner===globalThis.info.realName) {
          this.questionList.push(element);
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
        if(this.questionList.length==0){
          GridItem(){
            Text("什么也没有").width('100%')
              .fontColor(Color.Gray)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .margin({top: 50})
          }
        }else {
          ForEach(this.questionList, (item, i) => {
            GridItem() {
              Flex({ direction: FlexDirection.Column }) {
                Text(item.title)

                  .fontSize(18)
                  .fontWeight(600)
                Text(item.question)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .height(50)
                Text(`专家名称: ${item.expertName}`)
                  .padding(5)
                Row() {
                  if (item.answer == null) {
                    Text("未回答")
                      .width(70)
                      .height(30)
                      .backgroundColor('#FFE4E1')
                      .fontColor('#CD5C5C')
                      .textAlign(TextAlign.Center)
                      .borderRadius(10)
                  } else {
                    Text("已回答")
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
                      this.currentItem = item;
                      this.show = !this.show;
                      //AlertDialog.show({message: `${item.question} ${item.answer}`})
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

      //弹出框
      Panel(this.show) { // 展示日程
        Flex({direction: FlexDirection.Column}) {
          Text(`问答标题:${this.currentItem.title}`)
            .fontWeight(600)
            .height(50)
          Divider()
          Text(`问题详情:${this.currentItem.question}`)
            .height(50)
          Divider()
          Text(`专家名称:${this.currentItem.expertName}`)
            .height(50)
          Divider()
          Text(`专家回答:${this.currentItem.answer}`)
            .height(50)
          Divider()
          if (this.currentItem.answer == null) {
            Text("问题状态:未回答")
              .height(30)
              .backgroundColor('#FFE4E1')
              .fontColor('#CD5C5C')
              .textAlign(TextAlign.Center)
              .borderRadius(10)
          } else {
            Text("问题状态:已回答")
              .height(30)
              .backgroundColor('#00CDCD')
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
          }
          Button("取消").type(ButtonType.Capsule)
            .onClick(()=>{
              this.show=!this.show
            })
            .width('100%')
        }.margin(10)

      }
      .type(PanelType.Foldable).mode(PanelMode.Half)
      .dragBar(true) // 默认开启
      .halfHeight(500) // 默认一半
    }
  }
}
