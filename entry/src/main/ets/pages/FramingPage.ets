import router from '@ohos.router'
import {baseUrl} from '../api/BaseData'
import {getFrams} from '../api/FramsApi'
@Entry
@Component
struct FramingPage{

  @State type:string = '农业知识'
  @State frams: Array<any> = []
  private  scroller: Scroller = new Scroller()
  @State pageNum: number = 1
  aboutToAppear(){
    // 获取路由的参数
    //this.type = router.getParams()['type']
    // console.info(this.type)
    this.getFramsPage()
  }
  getFramsPage(){
    getFrams(this.pageNum).then(res=>{
      let imageDataArray = JSON.parse(res.result.toString()).data.list;
      for(let index=0;index<imageDataArray.length; index++){
        const element = imageDataArray[index]
        this.frams.push(element)
      }
    })
  }
  build(){
    Flex({direction: FlexDirection.Column}){
      Stack({alignContent: Alignment.Start}){
        Text(this.type)
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(()=>{
            router.back()
          }).margin({left:10})
      }.height(60).width('100%').margin({top:10})
      Stack({alignContent: Alignment.TopStart}) {
        Scroll(this.scroller){
          Flex({wrap:FlexWrap.Wrap,justifyContent:FlexAlign.SpaceBetween}){
            List({space:20, initialIndex:0}) {
              ForEach(this.frams, (item, i) => {
                ListItem(){
                  Flex({direction: FlexDirection.Row, alignItems: ItemAlign.Center}) {
                    // Text(`${item.knowledgeId}`)
                    Image(`${baseUrl}/file/${item.picPath}`)
                      .width(100)
                      .height(100)
                      .borderRadius(10)
                    Column() {
                      Text(`${item.title}`).fontWeight(800)
                        .width(220)
                        .textOverflow({ overflow: TextOverflow.None })
                        .maxLines(2)
                      Text(`${item.content}`).lineHeight(20)
                        .width(220)
                        .textOverflow({ overflow: TextOverflow.None })
                        .maxLines(3)
                        .fontSize(12)
                      Text(`[作者:${item.ownName}]`).fontColor(Color.Black)
                          .height(60).lineHeight(15).fontSize(15)
                        .width(220)
                        .textAlign(TextAlign.End)
                        .padding(10)
                    }.alignItems(HorizontalAlign.Start)
                    .padding({left:10})
                  }
                }.width('100%')
                .backgroundColor(Color.White)
                .padding(20)
                .height(150)
                .onClick(()=>{
                  router.pushUrl({
                    url: "pages/FramInfo",
                    params:{
                      knowledgeId: `${item.knowledgeId}`
                    }
                  })
                })
              }, item => item)
            }
          }.width('100%')
        }.scrollable(ScrollDirection.Vertical)
        .scrollBarWidth(0)
        .onScrollEdge(()=>{
          if(this.pageNum< globalThis.navigateLastPage){
            this.pageNum += 1;
            this.getFramsPage()
          }
        })
      }.width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({left:10,right:10})
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
    }
}