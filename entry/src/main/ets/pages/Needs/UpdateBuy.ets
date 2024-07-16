/*
编辑我的需求
 */
/*
发布求购需求
 */
import router from '@ohos.router'
import picker from '@ohos.file.picker';
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';
import { baseUrl } from '../../api/BaseData';
import request from '@ohos.request';
import image from '@ohos.multimedia.image';
import {updateNeeds} from '../../api/NeedsApi'
@Entry
@Component
struct UpdateBuy{
  @State type: string="编辑商品信息"
  photoSelectOptions = new picker.PhotoSelectOptions();
  @State imgUrl: string=""
  @State imgName: string=""
  @State profileSrc:Resource = $r('app.media.welcome')
  @State profileImage:PixelMap = null
  @State orderId: string=''
  @State title: string=''
  @State content: string=''
  @State price: string=''
  aboutToAppear() {
    const params = router.getParams(); // 获取传递过来的参数对象
    this.imgName = params['img']; // 获取属性的值
    this.title = params['title']; // 获取属性的值
    this.content = params['content']; // 获取属性的值
    this.price = params['price']; // 获取属性的值
    this.orderId = params['orderId']; // 获取属性的值
    this.photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
    this.photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
  }
  // 上传图片
  async uploadAvatar(){
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
      url: `${baseUrl}/file/uploadInfo/order`,
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
      await request.uploadFile(context, uploadConfig)
        .then((uploadTask) => {
          //  订阅上传任务进度监听，同步方法，使用callback形式返回结果。
          uploadTask.on('progress', (uploadedSize, totalSize) => {
            console.info('上传大小' + uploadedSize, '总大小：' + totalSize)
            if (uploadedSize === totalSize) {
              AlertDialog.show({ message: '图片上传已完成' })
              // console.info("上传成功")
            }
          })
          //  订阅上传任务HTTP标头监听，同步方法，使用callback形式返回结果。
          uploadTask.on("headerReceive",(headerCallback)=>{
            console.info("返回响应: "+JSON.stringify(headerCallback))
            // 正则表达式匹配Content-Disposition中的filename值
            const regex = /Content-Disposition:.*filename=(\S+).jpg/;
            const match = JSON.stringify(headerCallback).match(regex);
            if (match && match[1]) {
              // console.info("正则匹配: ")
              // console.log(match[1]); // 输出: f427119a8226495d9de33e4dae19aa33.jpg
              this.imgName=match[1]+".jpg"

              updateNeeds(this.orderId,this.title,this.content,this.price,this.imgName).then((res)=>{
                let rst = JSON.parse(res.result.toString());
                if (rst.code == 20000) {
                  AlertDialog.show({message : "修改成功"})
                  router.replaceUrl({url: "pages/Needs/BaseBuy"})
                } else {
                  AlertDialog.show({
                    title: "提示",
                    message: rst.message,
                    primaryButton: {
                      value: '关闭',
                      action: () => {
                      }
                    }
                  })
                }
              })

            }
          })
        })

    }catch(err){
      console.error(`Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`)
    }
  }
  async pickerAvatar(){
    let URI = null;
    const photoViewPicker = new picker.PhotoViewPicker();
    photoViewPicker.select(this.photoSelectOptions).then((photoSelectResult) => {
      if(photoSelectResult.photoUris.length<=0){
        return
      }
      URI = photoSelectResult.photoUris[0];
      this.imgUrl=URI
      console.info('photoViewPicker.select to file succeed and URI is:' + URI);
      this.getPixelMap()
      //this.uploadAvatar()
      //return this.imgUrl
    }).catch((err) => {
      console.error(`Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
    })
  }
  // 获取图片的pixelmap
  getPixelMap(){
    // 通过uri打开图片文件，获取文件fd
    let file = fs.openSync(this.imgUrl, fs.OpenMode.READ_ONLY);
    const imageSourceApi = image.createImageSource(file.fd);
    // 将图片解码为pixelmap
    imageSourceApi.createPixelMap().then(pixelmap => {
      this.profileImage = pixelmap
      console.log('Succeeded in creating pixelmap object through image decoding parameters.');
    }).catch((err) => {
      console.log('Failed to create pixelmap object through image decoding parameters.');
    })
  }
  //修改需求
  async UpdateBuy(){
    if(this.profileImage==null){
      console.info("图片未修改")
      updateNeeds(this.orderId,this.title,this.content,this.price,this.imgName).then((res)=>{
          let rst = JSON.parse(res.result.toString());
          if (rst.code == 20000) {
            AlertDialog.show({message : "修改成功"})
          } else {
            AlertDialog.show({
              title: "提示",
              message: rst.message,
              primaryButton: {
                value: '关闭',
                action: () => {
                }
              }
            })
          }
        })
    }else{
      await this.uploadAvatar()
    }
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
        Row() {
          Text("取消")
            .fontSize(18)
            .onClick(()=>{
              router.back()
            })
        }.width('100%').justifyContent(FlexAlign.End)
        .padding({right:20})
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(()=>{
            router.back()
          }).margin({left:10})
      }.height(60).width('100%').margin({top:10})
      Text("修改商品照片")
        .lineHeight(20)
        .padding(20)
        .fontColor(Color.Gray)
      Row(){
        Column() {
          Text("照片")
            .padding(20)
        }
        Column() {
          Image(`${baseUrl}/file/${this.imgName}`)
            .width(100)
            .height(100)
            .backgroundColor(Color.Gray)
        }
        Column(){
          if(this.profileImage===null) {
            Image($r('app.media.camera'))
              .width(50)
              .height(50)
              .onClick(() => {
                this.pickerAvatar()
              })
            Text("修改照片")
          }else{
            Image(this.profileImage)
              .width('100%')
          }
        }.width(100)
        .height(100)
        .backgroundColor("#D3D3D3")
        .justifyContent(FlexAlign.Center)
        .borderRadius(20)
      }.backgroundColor(Color.White)
      .padding(10)
      .width('100%')
      Text("添加商品基本信息")
        .lineHeight(20)
        .padding(20)
        .fontColor(Color.Gray)
      Column(){
        Row() {
          Text("标题: ").padding(5)
          TextInput({text:this.title})
            .width('85%')
            .onChange((value: string)=>{
              this.title=value;
            })
        }.height(90)
        Row() {
          Text("内容: ").padding(5)
          TextArea({text:this.content })
            .height(120)
            .width('85%')
            .onChange((value: string)=>{
              this.content=value;
            })
        }.height(120)

        Row() {
          Text("定价: ").padding(5)
          TextInput({ text: this.price })
            .width('85%')
            .onChange((value:string)=>{
              this.price=value
            })
        }.height(90)
      }.width('100%')
      .backgroundColor(Color.White)
      .margin(10)
      .borderRadius(10)
      Column(){
        Row(){
          Button("保存修改")
            .width('100%')
            .onClick(()=>{
              this.UpdateBuy()
            })
            .backgroundColor(Color.Red)
        }.width('100%')
        .height(50)
        .padding(10)
        .backgroundColor(Color.White)
      }.justifyContent(FlexAlign.End).flexGrow(1)

    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}