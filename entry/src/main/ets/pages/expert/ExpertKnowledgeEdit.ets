/**
 * 专家知识编辑
 */
import router from '@ohos.router'
import request from '@ohos.request';
import promptAction from '@ohos.promptAction';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs'
import common from '@ohos.app.ability.common';
import { baseUrl } from '../../api/BaseData';
import http from '@ohos.net.http';
import { IKnowledge } from '../../models/knowledge';
import { releaseKnowledgeApi, updateKnowledgeApi } from '../../api/knowledge';

const context = getContext(this) as common.UIAbilityContext;

@Entry
@Component
struct ExpertKnowledgeEdit {
  @State knowledgeDetail: IKnowledge = {};
  @State headTitle: string = ''
  @State type: string = ''
  @State isShow: boolean = false
  @State resultMsg: string = ''
  @State imageList: Array<string> = [];
  private uploadTask: request.UploadTask;

  handleLoadImageList() {
    try {
      const PhotoSelectOptions = new picker.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 1;
      const photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
        this.imageList = PhotoSelectResult.photoUris;
        this.handleWriteImage()
      }).catch((error) => {
        console.error('photoPicker.select.error: ', error.message)
      });
    } catch (error) {
      console.error('handleLoadImageList.error: ', error.message)
    }
  }

  handleWriteImage() {
    const URI = this.imageList[0]
    const cacheDir = getContext(this).cacheDir
    const srcFile = fs.openSync(URI, fs.OpenMode.READ_ONLY);
    const tarFile = fs.openSync(cacheDir + "/file.png", fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    const bufSize = 4096;
    let readSize = 0;
    const buf = new ArrayBuffer(bufSize);
    let readLen = fs.readSync(srcFile.fd, buf, { offset: readSize });
    while (readLen > 0) {
      readSize += readLen;
      fs.writeSync(tarFile.fd, buf);
      readLen = fs.readSync(srcFile.fd, buf, { offset: readSize });
    }
    fs.closeSync(srcFile);
    fs.closeSync(tarFile);
    this.handleUploadFile();
  }

  handleUploadFile() {
    const uploadConfig = {
      url: baseUrl + '/file/upload/order',
      header: { Authorization: globalThis.token },
      method: 'POST',
      files: [
        { filename: '', name: 'file', uri: "internal://cache/file.png", type: 'image/png' }
      ],
      data: []
    }
    try {
      request.uploadFile(context, uploadConfig)
        .then((data) => {
          this.uploadTask = data
          this.uploadTask.on("headerReceive", (header) => {
            const headerStr = JSON.stringify(header);
            const begin = headerStr.indexOf("filename=") + "filename=".length;
            const end = headerStr.indexOf("\\r\\n", begin)
            const fileName = headerStr.substring(begin, end);
            this.knowledgeDetail.picPath = fileName;
          })
        })
        .catch((error) => {
          console.error('request.uploadFile.error: ', error.message)
        })
    } catch (error) {
      console.error('uploadFile.error: ', error.message);
    }
  }

  async handleSaveKnowledge() {
    try {
      const res = await releaseKnowledgeApi(this.knowledgeDetail)
      const data = JSON.parse(res.result.toString());
      promptAction.showToast({
        message: data.message,
        duration: 1000,
      });
      setTimeout(() => {
        router.back()
      }, 2000)
    } catch (error) {
      console.error('handleSaveKnowledge.error: ', error.message)
    }
  }

  async handleUpdateKnowledge() {
    try {
      const res = await updateKnowledgeApi(this.knowledgeDetail)
      const data = JSON.parse(res.result.toString());
      promptAction.showToast({
        message: data.message,
        duration: 1000,
      });
    } catch (error) {
      console.error('handleUpdateKnowledge.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.type = router.getParams()['type']
    if (this.type == 'edit') {
      this.knowledgeDetail = router.getParams()['knowledgeDetail'];
      this.headTitle = '修改信息'
    } else {
      this.headTitle = '添加知识'
    }
  }

  build() {
    Stack() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text(this.headTitle)
            .width('100%')
            .height(60)
            .fontSize(20)
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontColor(Color.Grey)

          Image($r('app.media.iv_back_selected'))
            .width(40)
            .height(40)
            .margin({ left: 10 })
            .onClick(() => {
              router.back()
            })
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })

        Row() {
          Text("设置照片")
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .height(40)
        .justifyContent(FlexAlign.Start)
        .width('100%')
        .padding({ left: 20, right: 20 })

        Column() {
          List() {
            ListItem() {
              Row() {
                Text('照片:')
                  .width(40)
                Image(`${baseUrl}/file/${this.knowledgeDetail.picPath}`)
                  .width('35%')
                  .height('100%')
                  .objectFit(ImageFit.Cover)
                  .borderRadius(10)
                  .margin({ left: 10 })
                Column() {
                  Image($r('app.media.camera'))
                    .width(40)
                    .height(40)
                  Text('添加照片')
                    .fontSize(16)
                }
                .onClick(() => this.isShow = true)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .width(150)
                .height(150)
                .borderRadius(10)
                .backgroundColor('#F1F3F5')
                .margin({ left: 10 })
              }
            }
            .padding({ left: 20, right: 20 ,top:16,bottom: 16})
            .height(180)
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')

          List() {
            ListItem() {
              Row() {
                Text('标题:')
                  .width(40)
                TextInput({ placeholder: '添加商品标题', text: this.knowledgeDetail.title })
                  .onChange((value: string) => this.knowledgeDetail.title = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Text('内容:')
                  .width(40)
                TextArea({ placeholder: '添加商品内容', text: this.knowledgeDetail.content })
                  .onChange((value: string) => this.knowledgeDetail.content = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
                  .height(200)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(200)
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')
        }
        .layoutWeight(1)

        if (!this.isShow) {
          Row() {
            Button("保存")
              .fontColor(Color.White)
              .backgroundColor(Color.Red)
              .type(ButtonType.Normal)
              .width('100%')
              .borderRadius(20)
              .onClick(() => {
                if (this.type == 'edit') {
                  this.handleUpdateKnowledge()
                } else {
                  this.handleSaveKnowledge()
                }

              })
          }
          .alignItems(VerticalAlign.Bottom)
          .padding(10)
          .backgroundColor('#ffffff')
          .width('100%')
        }
      }
      .width('100%')

      Panel(this.isShow) {
        Column() {
          List() {
            ListItem() {
              Row() {
                Text("从手机相册选择")
              }
              .height(60)
              .width('100%')
              .justifyContent(FlexAlign.Center)
              .onClick(() => {
                this.handleLoadImageList()
                this.isShow = false
              })
            }

            ListItem() {
              Row() {
                Text("取消")
              }
              .height(60).width('100%')
              .justifyContent(FlexAlign.Center)
              .onClick(() => this.isShow = false)
            }
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#ffffff')
          .divider({ strokeWidth: 1, color: "#f1f1f1" })
          .borderRadius(20)
        }
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .fullHeight(120)
      .dragBar(false)
      .halfHeight(120)
    }
    .height('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}