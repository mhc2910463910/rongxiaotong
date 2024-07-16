import router from '@ohos.router'
import { baseUrl } from '../api/BaseData'
import { getInfo } from '../api/LoginApi'
import picker from '@ohos.file.picker';
import url from '@ohos.url';
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';
import request from '@ohos.request';
import {updateAvatar} from '../api/InfoApi'
@Entry
@Component
struct Info {
  @State type: string = "个人信息"
  @State info: any = ''
  @State role: string = 'user'
  photoSelectOptions = new picker.PhotoSelectOptions();
  @State imgUrl: string=""
  @State imgName: string=""
  @State isRefreshing: boolean = false
  // 上传图片
  uploadAvatar(){
    let context = getContext(this) as common.UIAbilityContext;
    let cacheDir = context.cacheDir;
    let file = fs.openSync(this.imgUrl, fs.OpenMode.READ_ONLY) // 打开文件为只读模式
    let fileFD = file.fd
    let destPath = cacheDir // 获取缓存目录路径
    let fileName = Date.now().toString() + '.jpg' // 生成新的文件名
    let fullPath = destPath + '/' + fileName
    // AlertDialog.show({ message: '完整路径' + fullPath })
    fs.copyFileSync(fileFD, fullPath) // 拷贝文件
    // 上传任务配置项
    let uploadConfig ={
      url: `${baseUrl}/file/upload/avatar`,
      header: {
        'Content-Type': 'multipart/form-data',
      },
      method: 'POST',
      files: [
        { filename: fileName, name: 'file', uri: `internal://cache/${fileName}`, type: 'jpg' }
      ],
      data: []
    }
    // 将本地应用文件上传至网络服务器
    try {
       request.uploadFile(context, uploadConfig)
         .then((uploadTask) => {
          //  订阅上传任务进度监听，同步方法，使用callback形式返回结果。
          uploadTask.on('progress', (uploadedSize, totalSize) => {
            console.info('上传大小' + uploadedSize, '总大小：' + totalSize)
            if (uploadedSize === totalSize) {
              // AlertDialog.show({ message: '上传已完成' })
              console.info("上传成功")
            }
          })
        //  订阅上传任务HTTP标头监听，同步方法，使用callback形式返回结果。
           uploadTask.on("headerReceive",(headerCallback)=>{
             console.info("返回响应: "+JSON.stringify(headerCallback))
             // 正则表达式匹配Content-Disposition中的filename值
             const regex = /Content-Disposition:.*filename=(\S+).jpg/;
             const match = JSON.stringify(headerCallback).match(regex);
             if (match && match[1]) {
               console.info("正则匹配: ")
               console.log(match[1]); // 输出: f427119a8226495d9de33e4dae19aa33.jpg
               this.imgName=match[1]+".jpg"
               this.updateImage()
             }
             // let regex = /filename=(?<filename>.*)/
             // let listMatch = JSON.stringify(headerCallback).match(regex)
             // console.info(listMatch.groups.filename)
             // if (listMatch && listMatch.groups) {
             //   console.info("正则匹配: "+listMatch.groups['filename'])
             //   this.fileName=listMatch.groups['filename']
             // }
           })
        })

    }catch(err){
      console.error(`Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`)
    }
  }
  async pickerAvatar(){
    console.info("打开相册")
    this.photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
    this.photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
    let URI = null;
    const photoViewPicker = new picker.PhotoViewPicker();
    photoViewPicker.select(this.photoSelectOptions).then((photoSelectResult) => {
      if(photoSelectResult.photoUris.length<=0){
        console.info("打开相册失败")
        return
      }
      URI = photoSelectResult.photoUris[0];
      this.imgUrl=URI
      console.info('上传图片 photoViewPicker.select to file succeed and URI is:' + URI);
      this.uploadAvatar()
      // return this.imgUrl
    }).catch((err) => {
      console.error(`上传失败 Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
    })
  }
  // 修改图片
  updateImage(){
    // console.info("图片url")
    // console.info(this.imgName)
    updateAvatar(this.imgName).then((res)=>{
      console.info(res.result.toString())
      let rst = JSON.parse(res.result.toString());
      if(rst.code===20000){
        AlertDialog.show({ message: '头像已更改' })
      }
    })
  }
  // 刷新
  aboutToAppear() {
    if (globalThis.info) {
      this.info = globalThis.info;
    } else if (globalThis.token) {
      getInfo().then((res) => {
        let resData = JSON.parse(res.result.toString())
        this.info = resData.data;
        this.role = this.info.role;
        globalThis.info = resData.data;
      })
    }
  }
  build() {
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
            Image($r('app.media.chevron_right'))
              .height(50)
              .width(50)
              .padding(10)
          }
          .width('100%')
          .height(80)
          .backgroundColor("#FDF5E6")
          .borderRadius(20)
          .onClick(() => {
            this.pickerAvatar()
          })

          Divider()
          Row() {
            Text("基本信息")
              .padding(15)
            Blank()
            Image($r('app.media.chevron_right'))
              .height(50)
              .width(50)
              .padding(10)
          }.width('100%')
          .height(80)
          .backgroundColor("#FDF5E6")
          .borderRadius(20)
          .onClick(()=>{
            router.pushUrl({
              url: "pages/BaseInfo"
            })
          })

          Divider()
          Row() {
            Text("修改密码")
              .padding(15)
            Blank()
            Image($r('app.media.chevron_right'))
              .height(50)
              .width(50)
              .padding(10)
          }.width('100%')
          .height(80)
          .backgroundColor("#FDF5E6")
          .borderRadius(20)
          .onClick(()=>{
            router.pushUrl({
              url: "pages/UpdatePassword"
            })
          })

        }
        .width('100%')
        .height('100%')
        .padding({ left: 10, right: 10 })
        .backgroundImage($r('app.media.bg'))
        .backgroundImageSize(ImageSize.Cover)
      }

  }
}