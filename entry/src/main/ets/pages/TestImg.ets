// PhotoPixelmapTransfer.ets
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';
import image from '@ohos.multimedia.image';

@Entry
@Component
export struct MinePage{
  @State profileSrc:Resource = $r('app.media.welcome')
  @State profileImage:PixelMap = null
  private uri:string = ''
  @State flag:number = 0

  // 选择头像图片
  // 定义一个函数用于点击头像时拉起用户图库
  pickProfile(): void{
    const photoSelectOptions = new picker.PhotoSelectOptions();
    // 设置选择的文件类型为图片类型
    photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
    // 一次只能选择一张图片
    photoSelectOptions.maxSelectNumber = 1;
    let uri = null;
    const photoViewPicker = new picker.PhotoViewPicker();
    // 拉起图库，获取选中图片的uri
    photoViewPicker.select(photoSelectOptions).then((photoSelectResult) => {
      // 获取选中图片的uri
      uri = photoSelectResult.photoUris[0];
      this.uri = uri
      this.flag = 1
      console.info('photoViewPicker.select to file succeed and uris are:' + uri)
    }).catch((err) => {
      console.error(`Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
    })
  }
  // 获取图片的pixelmap
  getPixelMap(){
    // 通过uri打开图片文件，获取文件fd
    let file = fs.openSync(this.uri, fs.OpenMode.READ_ONLY);
    const imageSourceApi = image.createImageSource(file.fd);
    // 将图片解码为pixelmap
    imageSourceApi.createPixelMap().then(pixelmap => {
      this.profileImage = pixelmap
      console.log('Succeeded in creating pixelmap object through image decoding parameters.');
    }).catch((err) => {
      console.log('Failed to create pixelmap object through image decoding parameters.');
    })
  }

  build(){
    Stack(){
      Image(this.profileImage===null?this.profileSrc:this.profileImage)
        .width(108)
        .height(108)
        .objectFit(ImageFit.Cover)
        .markAnchor({ x: 54, y: 54 })
        .position({ x: '50%', y: '45%' })
        .borderRadius(54)

      Image($r('app.media.video'))
        .markAnchor({ x:35, y:35 })
        .position({ x: '50%', y: '45%'  })
        .width(68)
        .height(68)
        .opacity(0.1)
        .onClick(()=>{
          this.pickProfile()
        })

      if(this.flag === 1){
        Text('上传')
          .fontSize(10)
          .fontColor('#FFFFFF')
          .height(35)
          .width(35)
          .position({x:200,y:280})
          .borderRadius(17.5)
          .backgroundColor('#F07B7B')
          .textAlign(TextAlign.Center)
          .onClick(()=>{
            this.getPixelMap()
            this.flag = 0
          })
      }
    }
    .width('100%')
    .height('100%')
  }
}
