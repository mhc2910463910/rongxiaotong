import router from '@ohos.router'
import http from '@ohos.net.http';
import fs from '@ohos.file.fs';
import { baseUrl } from '../api/BaseData';
import { HttpManager } from '../util/HttpManager';
import { RequestMethod } from '../util/RequestOption';
import { login } from '../api/LoginApi';
import {getInfo} from '../api/LoginApi'
// @Preview
@Entry
@Component
export struct LoginPage {
  @State username: string = '';
  @State password: string = ''
  // qst123456
  //登录操作
  doLogin(){
    login(this.username,this.password).then((res) => {
      console.info(res.result.toString());
      let rst = JSON.parse(res.result.toString());
      // 请求是否成功
      if (rst.code == 20000) {
        // console.info("请求成功")
        globalThis.token = rst.data
        router.replaceUrl({ url: "pages/Index" })
      } else {
        AlertDialog.show({
          title: '提示',
          message: "账号或密码有误",
          primaryButton: {
            value: '确定',
            action: () => {

            }
          }
        })
      }
    })
  }
  build() {
    Stack() {
      Row() {
      }
      .width('100%')
      .height('100%')
      .backgroundImage($r('app.media.bj'))
      .opacity(0.35)
      .backgroundImageSize(ImageSize.Contain)

      Row() {
        Column() {
          Stack({ alignContent: Alignment.Start }) {
            Text('用户登录')
              .width('100%')
              .height(60)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .fontColor(Color.Grey)
            Image($r('app.media.iv_back_selected')).width(40).height(40)
              .onClick(() => {
                router.back();
              }).margin({ left: 10 })
          }.height(60).width('100%').margin({ top: 10 })

          Image($r('app.media.log')).width(140).height(140).margin({ top: 40 })
          Text('融销通').fontColor('#a4cd3d').fontSize(24).margin(15)
          Row() {
            Text('账 号:').fontSize(14).margin({ left: 15 }).fontColor(Color.Grey)
            TextInput({ placeholder: '请输入账号',text:'' })
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Grey)
              .fontSize(12)
              .onChange((val) => {
                this.username = val;
              })
          }
          .width('90%')
          .height(50)
          .margin({ top: 40 })
          .backgroundColor('#ffffff')
          .borderRadius(10)

          Row() {
            Text('密 码:').fontSize(14).margin({ left: 15 }).fontColor(Color.Grey)
            TextInput({ placeholder: '请输入密码',text:''})
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Grey)
              .fontSize(12)
              .type(InputType.Password)
              .onChange((val) => {
                this.password = val;
              })
          }
          .width('90%')
          .height(50)
          .margin({ top: 30 })
          .backgroundColor('#ffffff')
          .borderRadius(10)

          Row() {
            Button("登  录", { type: ButtonType.Normal })
              .width('100%')
              .height(50)
              .borderRadius(8)
              .backgroundColor('#ffffff')
              .fontColor(Color.Grey)
              .fontSize(16)
              .onClick(() => {
                this.doLogin();
              })
          }.width('90%').height(50).margin({ top: 40 })

          Row() {
            Row() {
              //Text("忘记密码").fontSize(14).margin({ right: 10 })
              Text("").fontSize(14).margin({ right: 10 })
            }
            Text("快速注册").fontSize(14).margin({ right: 10 })
              .onClick(() => {
                router.pushUrl({ url: "pages/RegPage" })
              })
          }.width('90%').height(30).margin({ top: 30 }).justifyContent(FlexAlign.SpaceBetween)
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