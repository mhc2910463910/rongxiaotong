/*
  修改密码页面
 */
import router from '@ohos.router';
import { HttpManager } from '../util/HttpManager';
import {updatePassword} from '../api/LoginApi'
@Entry
@Component
struct UpdatePassword{
  @State password: string = ''
  @State new_password1: string = ''
  @State new_password2: string = ''
  controller: TextInputController = new TextInputController()
  @State type: string="修改密码"
  @State info: any=""
  updateNewPassword(){
    // AlertDialog.show({message: "password"+this.password})
    // AlertDialog.show({message: "password1"+this.new_password1})
    // AlertDialog.show({message: "password2"+this.new_password2})
    if(this.new_password1!=this.new_password2){
      AlertDialog.show({message: "新密码不一致,请重新输入"})
      return
    }else{
      updatePassword(this.new_password1,this.password).then((res)=>{
        console.info(res.result.toString());
        let rst = JSON.parse(res.result.toString());
        if (rst.code == 20000) {
          AlertDialog.show({message : "密码修改成功"})
          router.replaceUrl({ url: "pages/Index" })
        } else {
          AlertDialog.show({
            title: rst.message,
            message: rst.data,
            primaryButton: {
              value: '关闭',
              action: () => {

              }
            }
          })
        }
      })
    }
  }
  aboutToAppear(){
    this.info=globalThis.info;
  }
  build(){
    Flex({ direction: FlexDirection.Column }) {
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
        Row() {
          // 密码输入框
          TextInput({ text:this.password,placeholder: '原密码',controller:this.controller })
            .height(50)
            .margin(10)
            .type(InputType.Password)
            .maxLength(12)
            .showPasswordIcon(true)
            .onChange((value:string)=>{
              this.password=value;
            })
        }
        .width('100%')
        .height(80)
        .backgroundColor("#FDF5E6")
        .borderRadius(10)
        .margin({top:10})
        Row() {
          // 密码输入框
          TextInput({text:this.new_password1, placeholder: '新密码',controller: this.controller })
            .height(50)
            .margin(10)
            .type(InputType.Password)
            .maxLength(12)
            .showPasswordIcon(true)
            .onChange((value:string)=>{
              this.new_password1=value;
            })
        }
        .width('100%')
        .height(80)
        .backgroundColor("#FDF5E6")
        .borderRadius(10)
        .margin({top:10})
        Row() {
          // 密码输入框
          TextInput({text:this.new_password2, placeholder: '再次输入新密码',controller:this.controller })
            .height(50)
            .margin(10)
            .type(InputType.Password)
            .maxLength(12)
            .showPasswordIcon(true)
            .onChange((value:string)=>{
              this.new_password2=value;
            })
        }
        .width('100%')
        .height(80)
        .backgroundColor("#FDF5E6")
        .borderRadius(10)
        .margin({top:10})
      }
      .width('100%')
      .height('100%')
      .padding({ left: 10, right: 10 })
      .backgroundImage($r('app.media.bg'))
      .backgroundImageSize(ImageSize.Cover)

      Row() {
        Blank()
        Button("确认修改")
          .onClick(()=>{
            this.updateNewPassword();
          })
      }
      .width('100%')
      .height(80)
      .backgroundColor("#FDF5E6")
      .borderRadius(20)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
    }
}