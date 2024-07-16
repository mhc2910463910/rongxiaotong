/*
  基本信息页面
 */
import router from '@ohos.router'
import { baseUrl } from '../api/BaseData'
import {getInfo} from '../api/LoginApi'
import {updateNickname, updatePhone} from '../api/InfoApi'
@CustomDialog
struct CustomDialogExam{
  @Link title: string;
  @Link textValue: string;
  @Link inputValue: string;
  controller: CustomDialogController
  cancel: ()=>void
  confirm: ()=>void
  build() {
    Column() {
      Text(this.title).fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '', text: this.textValue }).height(60).width('90%')
        .onChange((value: string) => {
          this.textValue = value
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确认')
          .onClick(() => {
            this.inputValue = this.textValue
            if(this.title==="修改昵称") {
              updateNickname(this.inputValue, globalThis.info.userName).then((res) => {
                let rst = JSON.parse(res.result.toString());
                if (rst.code == 20000) {
                  AlertDialog.show({message: `修改成功`})
                } else {
                  AlertDialog.show({
                    title: "提示",
                    message: rst.data,
                    primaryButton: {
                      value: '关闭',
                      action: () => {
                      }
                    }
                  })
                }
              })
            }else if(this.title==="修改电话"){
              updatePhone(this.inputValue,globalThis.info.userName).then((res)=>{
                let rst = JSON.parse(res.result.toString());
                if (rst.code == 20000) {
                  AlertDialog.show({message: `修改成功`})
                } else {
                  AlertDialog.show({
                    title: "提示",
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
            this.textValue=""
            this.inputValue=""
            this.controller.close()
            this.confirm()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}
@Component
struct InfoItem{
  @State text: string=""
  @State value: string=""
  build(){
    Row() {
      Text(this.text)
        .padding(15)
        .fontWeight(700)
      Blank()
      Text(this.value)
        .padding(15)
    }.width('100%')
    .height(80)
    .backgroundColor("#FDF5E6")
    .borderRadius(20)
  }
}
@Entry
@Component
/*
  用户基本信息页面
 */
struct BaseInfo{
  @State title: string=""
  @State info: any = ''
  @State type: string="基本信息"
  @State textValue: string = ''
  @State inputValue: string = ''
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExam({
      title: $title,
      cancel: this.onCancel,
      confirm: this.onAccept,
      textValue: $textValue,
      inputValue: $inputValue
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Default,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })
  aboutToAppear(){
    // getInfo().then((res)=>{
    //   let rst=JSON.parse(res.result.toString()).data
    //   this.info = rst.data;
    //   console.info(this.info)
    // })
    this.info=globalThis.info
  }
  aboutToDisappear(){
    delete this.dialogController,
            this.dialogController=undefined
  }
  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
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
          Text("头像")
            .padding(15)
          Blank()
          Image(`${baseUrl}/file/${this.info.avatar}`)
            .width(50)
            .height(50)
            .borderRadius(50)
        }
        .width('100%')
        .height(80)
        .backgroundColor("#FDF5E6")
        .borderRadius(20)
        Divider()
        InfoItem({text: "昵称",value: `${this.info.nickName}`})
          .onClick(()=>{
            this.title="修改昵称"
            if(this.dialogController!=undefined){
              this.dialogController.open()
            }
          })
        Divider()
        InfoItem({text: "用户名",value: `${this.info.userName}`})
          .onClick(()=>{
            AlertDialog.show({message: "用户名不支持修改"})
          })
        Divider()
        InfoItem({text: "电话",value: `${this.info.phone}`})
          .onClick(()=>{
            this.title="修改电话"
            if(this.dialogController!=undefined){
              this.dialogController.open()
            }
          })
        Divider()
        InfoItem({text: "位置",value: `${this.info.address}`})
      }
      .width('100%')
      .height('100%')
      .padding({ left: 10, right: 10 })
      .backgroundImage($r('app.media.bg'))
      .backgroundImageSize(ImageSize.Cover)
    }

  }
}