import router from '@ohos.router';
import http from '@ohos.net.http';
import {baseUrl} from '../api/BaseData'
import {register} from '../api/LoginApi';
// import { Component } from '@ohos.UiTest';
@Entry
@Component
export struct RegPage{
  @State username:string ='';
  @State password:string ='';
  @State nickName:string ='';
  doReg(){
    register(this.nickName,this.password,this.username).then((res)=>{
      let rst=JSON.parse(res.result.toString())
      if(rst.code=20000){
        AlertDialog.show({
          title:'提示',
          message:rst.message,
          primaryButton:{
            value:'确定',
            action:()=>{
              router.back();
            }
          }
        })
      }else{
        AlertDialog.show({
          title:'提示',
          message:rst.data,
          primaryButton:{
            value:'确定',
            action:()=>{

            }
          }
        });
      }
    })
  }
  build(){
    Stack(){
      Row(){

      }.width('100%')
      .height('100%')
      .opacity(0.35)
      .backgroundImageSize(ImageSize.Contain)
      Row(){
        Column(){
          Stack({
            alignContent:Alignment.Start
          }){
            Text('用户注册').width('100%').height(60).fontSize(20).width('100%')
              .textAlign(TextAlign.Center).fontColor(Color.Grey)
            Image($r('app.media.iv_back_selected')).width(40).height(40)
              .onClick(()=>{
                router.back();
              }).margin({left:10})
          }.height(60).width('100%').margin({top:10})
          Row(){
            Text('账 户:').fontSize(14).margin({left:15}).fontColor(Color.Grey)
            TextInput({placeholder:'请输入账号'}).borderWidth(0).backgroundColor(Color.Transparent).flexGrow(1)
              .placeholderColor(Color.Grey).fontSize(12)
              .onChange((val)=>{
                this.username=val
              })
          }.width('90%').height(50).margin({top:40}).backgroundColor('#ffffff')
          .borderRadius(10)
          Row(){
            Text('用户名:').fontSize(14).margin({left:15}).fontColor(Color.Grey)
            TextInput({placeholder:'请输入用户名称'}).borderWidth(0).backgroundColor(Color.Transparent).flexGrow(1)
              .placeholderColor(Color.Grey).fontSize(12)
              .onChange((val)=>{
                this.nickName=val;
              })
          }.width('90%').height(50).margin({top:40}).backgroundColor('#ffffff')
          .borderRadius(10)
          Row(){
            Text('密码:').fontSize(14).margin({left:15}).fontColor(Color.Grey)
            TextInput({placeholder:'请输入密码'}).borderWidth(0).backgroundColor(Color.Transparent).flexGrow(1)
              .placeholderColor(Color.Grey).fontSize(12)
              .type(InputType.Password)
              .onChange((val)=>{
                this.password=val
              })
          }.width('90%').height(50).margin({top:30}).backgroundColor('#ffffff')
          .borderRadius(10)
          Row(){
            Text('确认密码:').fontSize(14).margin({left:15}).fontColor(Color.Grey)
            TextInput({placeholder:'请再次输入密码'}).borderWidth(0).backgroundColor(Color.Transparent).flexGrow(1)
              .placeholderColor(Color.Grey).fontSize(12)
              .type(InputType.Password)
              .onChange((val)=>{
                this.password=val
              })
          }.width('90%').height(50).margin({top:30}).backgroundColor('#ffffff')
          .borderRadius(10)
          Row(){
            Button("注  册",{type:ButtonType.Normal}).width('100%').height(50)
              .borderRadius(8).backgroundColor('#ffffff')
              .fontColor(Color.Grey)
              .fontColor(16)
              .onClick(()=>{
                this.doReg();
              })
          }.width('90%').height(50).margin({top:30})
          Row(){
            Text("已有账号").fontSize(14).margin({right:10})
            Text("登录").fontSize(14).margin({right:10})
              .onClick(()=>{
                router.back();
              })
          }.width('90%').height(30).margin({top:30}).justifyContent(FlexAlign.End)
        }
        .width('100%')
        .height('100%')
      }
      .height('100%')
      .backgroundColor('#e0ebf4')
      .opacity(0.9)
    }
  }
}


