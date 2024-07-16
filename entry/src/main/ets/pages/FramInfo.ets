import router from '@ohos.router';
import { baseUrl } from '../api/BaseData';
import {getInfo} from '../api/FramsApi'
@Entry
@Component
struct FramInfo{
  params: any=""

  @State type: string="详细信息"
  @State infos: Array<any> = []
  @State data: any="";
  @State knowledgeId: number=0;
  @State title: string="";
  @State content: string="";
  @State img: string="";
  @State ownName: string="";
  @State createTime: string="";
  @State updateTime: string="";
  aboutToAppear(){
    this.params = router.getParams(); // 获取传递过来的参数对象
    this.knowledgeId = this.params['knowledgeId']; // 获取id属性的值
    this.getFramInfo()

  }
  getFramInfo(){
    getInfo(this.knowledgeId).then((res)=>{
      // console.info(res.result.toString())
      this.data=JSON.parse(res.result.toString()).data;
      // for(let index=0;index<this.data.length; index++){
      //   const element = this.date[index]
      //   this.infos.push(element)
      // }
      this.knowledgeId=this.data.knowledgeId;
      this.title=this.data.title;
      this.content=this.data.content;
      this.img=this.data.picPath;
      this.ownName=this.data.ownName;
      this.createTime=this.data.createTime.toString().split('T')[0];
      this.updateTime=this.data.updateTime;
      console.log(this.data.knowledgeId);
      console.log(this.data.title);
      console.log(this.data.content);
      console.log(this.data.picPath);
      console.log(this.data.ownName);
      console.log(this.data.createTime);
      console.log(this.data.updateTime);
    })
  }
  build(){
    Column() {
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

      Column() {
        Text(this.title)
        .width('100%')
        .height(50)
        .padding(10)
        .textAlign(TextAlign.Center)
        Row(){
          Text(`作者:${this.ownName}`)
          Text(`日期:${this.createTime}`)
        }.justifyContent(FlexAlign.End)
        .padding(10)
        .width('100%')
        Image(`${baseUrl}/file/${this.img}`)
        // Image("http://localhost:9090/file/7765f8705bc54a2086bc295f3bd7217c.jpg")
          .width('100%')
          .height(200)
          .padding(10)
        Column() {
          Text(`${this.content}`)
            .lineHeight(30)
            .textOverflow({ overflow: TextOverflow.Ellipsis  })
            .maxLines(10)
            // .height('45%')
        }.height('45%')
        .padding(10)
        Button("追加评论")
      }
    }
  }
}