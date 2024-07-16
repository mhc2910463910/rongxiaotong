/*
修改用户信息
 */
import router from '@ohos.router'
import { deleteUser, updateUserInfo } from '../../api/UserApi';
@Entry
@Component
struct updateUser{
  @State type: string="用户信息"
  @State user: any={}
  @State identity: string=""
  @State nickName: string=""
  @State phone: string=""
  @State role: string=""
  @State address: string=""
  aboutToAppear(){
    const params = router.getParams(); // 获取传递过来的参数对象
    this.user = params['user']; // 获取属性的值
  }
  submitInfo(){
    updateUserInfo(this.user.userName,this.identity,this.nickName,this.phone,this.role,this.address).then((res)=>{
      let resu=JSON.parse(res.result.toString());
      if(resu.code===20000){
        AlertDialog.show({message: "修改成功"})
        router.replaceUrl({
          url: "pages/Admin/UserList"
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
  deleteUser(){
    deleteUser(this.user.userName).then((res)=>{
      let resu=JSON.parse(res.result.toString());
      if(resu.code===20000){
        AlertDialog.show({message: "删除成功"})
        router.replaceUrl({
          url: "pages/Admin/UserList"
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
            Text("用户名:")
          }.width('20%')
          Column(){
            Text(this.user.userName)
          }.width('80%')
        }.height(60).backgroundColor('#AFEEEE')
        Row(){
          Column(){
            Text("昵称:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.nickName})
              .onChange((value:string)=>{
                this.nickName=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#FFF0F5')
        Row(){
          Column(){
            Text("身份证:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.identityNum})
              .onChange((value:string)=>{
                this.identity=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#AFEEEE')
        Row(){
          Column(){
            Text("角色:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.role})
              .onChange((value)=>{
                this.role=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#FFF0F5')
        Row(){
          Column(){
            Text("电话:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.phone})
              .onChange((value:string)=>{
                this.phone=value;
              })
          }.width('80%')
        }.height(60).backgroundColor('#AFEEEE')
        Row(){
          Column(){
            Text("地址:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.address})
              .onChange((value)=>{
                this.address=value
              })
          }.width('80%')
        }.height(60).backgroundColor('#FFF0F5')
        Row(){
          Column(){
            Text("创建日期:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.createTime})
          }.width('80%')
        }.height(60).backgroundColor('#AFEEEE')
        Row(){
          Column(){
            Text("修改日期:")
          }.width('20%')
          Column(){
            TextInput({text:this.user.updateTime})
          }.width('80%')
        }.height(60).backgroundColor('#FFF0F5')
      }
      Flex({direction: FlexDirection.Row,justifyContent:FlexAlign.SpaceBetween}){
        Button("修改").type(ButtonType.Normal)
          .width(100)
          .height(40)
          .borderRadius(10)
          .onClick(()=>{
            this.submitInfo()
          })
        Button("删除").type(ButtonType.Normal)
          .backgroundColor(Color.Red)
          .width(100)
          .height(40)
          .borderRadius(10)
          .onClick(()=>{
            this.deleteUser()
          })
      }.margin(40)
    }.height('100%')
    }
}