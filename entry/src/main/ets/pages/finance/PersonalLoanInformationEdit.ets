/**
 * 个人贷款信息编辑
 */
import request from '@ohos.request';
import router from '@ohos.router';
import picker from '@ohos.file.picker';
import { IBank, IFinance } from '../../models/finance';
import fs from '@ohos.file.fs';
import { baseUrl } from '../../api/BaseData';
import common from '@ohos.app.ability.common';
import { addFinance } from '../../api/finance';
import promptAction from '@ohos.promptAction';

const context = getContext(this) as common.UIAbilityContext;

@Entry
@Component
struct PersonalLoanInformationEdit {
  @State bankDetail: IBank = {};
  @State uri: string = ''
  @State imageList: string[] = [];
  @State resultMsg: string = ''
  @State repayments: string[] = ["6", "12", "24", "36"];
  @State finance: IFinance = {}
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
      url: baseUrl + '/file/uploadInfo/info',
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
            this.resultMsg = fileName
          })
        })
        .catch((error) => {
          console.error('request.uploadFile.error: ', error.message)
        })
    } catch (error) {
      console.error('uploadFile.error: ', error.message);
    }
  }

  async handleAddFinance() {
    try {
      const res = await addFinance(this.finance)
      let data = JSON.parse(res.result.toString());
      if (data.code == 20000) {
        promptAction.showToast({ message: '申请成功!', duration: 2000 })
      } else {
        promptAction.showToast({ message: data.message, duration: 2000 })
      }
    } catch (error) {
      console.error('getUserInfoApi.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.bankDetail = router.getParams()["bankDetail"];
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('个人贷款信息')
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
              // const routerList: Array<string> = globalThis.routerList
              // const routerUrl = routerList.pop();
              // globalThis.routerList = routerList;
              // router.replaceUrl({ url: routerUrl })
              router.back()
            })
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })

        List({ space: 10 }) {
          ListItem() {
            Row() {
              Text('姓名:')
                .width(90)
                .textAlign(TextAlign.End)
                .margin({ right: 10 })
              TextInput()
                .width(250)
                .borderRadius(5)
                .onChange((value: string) => this.finance.realName = value)
            }
          }

          ListItem() {
            Row() {
              Text('融资额度:')
                .width(90)
                .textAlign(TextAlign.End)
                .margin({ right: 10 })
              TextInput()
                .width(250)
                .borderRadius(5)
                .onChange((value: string) => this.finance.money = value)
            }
          }

          ListItem() {
            Row() {
              Text('利息:')
                .width(90)
                .textAlign(TextAlign.End)
                .margin({ right: 10 })
              Text(this.bankDetail.rate + '')
            }
          }

          ListItem() {
            Row() {
              Text('意向借款期:')
                .width(90)
                .textAlign(TextAlign.End)
                .margin({ right: 10 })
              Select([{ value: '六个月' }, { value: '一年' }, { value: '二年' }, { value: '三年' }])
                .value('请选择意向借款期')
                .onSelect((index: number) => this.finance.repayment = this.repayments[index])
                .width(250)
                .borderRadius(5)
            }
          }

          ListItem() {
            Row() {
              Text('联系方式:')
                .width(90)
                .textAlign(TextAlign.End)
                .margin({ right: 10 })
              TextInput()
                .width(250)
                .borderRadius(5)
                .onChange((value: string) => this.finance.phone = value)
            }
          }

          ListItem() {
            Row() {
              Text('身份证号:')
                .width(90)
                .textAlign(TextAlign.End)
                .margin({ right: 10 })
              TextInput()
                .width(250)
                .borderRadius(5)
                .onChange((value: string) => this.finance.idNum = value)
            }
          }

          ListItem() {
            Row() {
              Text('上传材料:')
                .width(90)
                .textAlign(TextAlign.End)
                .margin({ right: 10 })
              Text('+')
                .width(90)
                .height(90)
                .fontSize(30)
                .textAlign(TextAlign.Center)
                .borderWidth(1)
                .borderStyle(BorderStyle.Dashed)
                .borderRadius(10)
                .onClick(() => this.handleLoadImageList())
                .margin({ right: 10 })
              Image(this.imageList[0])
                .width(90)
                .height(90)
            }
          }
        }.layoutWeight(1)

        Row() {
          Button("申请")
            .type(ButtonType.Normal)
            .borderRadius(5)
            .margin({ right: 10 })
            .onClick(() => this.handleAddFinance())
          Button("取消")
            .type(ButtonType.Normal)
            .borderRadius(5)
            .onClick(() => {
              // const routerList: Array<string> = globalThis.routerList
              // const routerUrl = routerList.pop();
              // globalThis.routerList = routerList;
              // router.replaceUrl({ url: routerUrl })
              router.back()
            })
        }
        .height(60)
      }
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}