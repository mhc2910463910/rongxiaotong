/*
个人中心专家信息管理
 */
import router from '@ohos.router'
import { getExpertInfo, updateExpertInfo } from '../../api/ExpertApi'
@Entry
@Component
struct ExpertInfo{
  @State user: any={}
  @State type: string="专家详情"
  @State realName: string=""
  @State phone: string=""
  @State profession: string=""
  @State positionInf: string=""
  @State belong: string=""
  aboutToAppear(){
    getExpertInfo().then((rst)=>{
      this.user=JSON.parse(rst.result.toString())
        .data;
    })
  }
  updateInfo(){
    updateExpertInfo(this.realName,this.phone,this.profession,this.positionInf,this.belong).then((res)=>{
      let resu=JSON.parse(res.result.toString());
      if(resu.code===20000){
        AlertDialog.show({message: "修改成功"})
        router.replaceUrl({
          url: "pages/Index"
        })
      }else{
        AlertDialog.show({
          title: resu.message,
          message: resu.data,
          primaryButton: {
            value: '关闭',
            action: () => {
            }
          }
        })
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
      Flex({direction: FlexDirection.Column}){
        Row(){
          Column(){
            Text("真实姓名:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.realName})
              .onChange((value:string)=>{
                this.realName=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#AFEEEE')
        Row(){
          Column(){
            Text("手机号码:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.phone})
              .onChange((value:string)=>{
                this.phone=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#FFF0F5')
        Row(){
          Column(){
            Text("从事专业:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.profession})
              .onChange((value:string)=>{
                this.profession=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#AFEEEE')
        Row(){
          Column(){
            Text("职位:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.position})
              .onChange((value)=>{
                this.positionInf=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#FFF0F5')
        Row(){
          Column(){
            Text("所属单位:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.belong})
              .onChange((value:string)=>{
                this.belong=value;
              })
          }.width('80%')
        }.height(60).backgroundColor('#AFEEEE')
      }
      Flex({direction: FlexDirection.Row,justifyContent:FlexAlign.Center}){
        Button("修改").type(ButtonType.Normal)
          .width(100)
          .height(40)
          .borderRadius(10)
          .onClick(()=>{
            this.updateInfo()
          })
      }.margin({bottom:20})
    }.height('100%')
  }
}