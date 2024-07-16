/**
 * 推荐融资人
 */
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import {
  addIntentionApi,
  deleteIntentionApi,
  getIntentionApi,
  getRecommendUserListApi,
  updateIntentionApi
} from '../../api/finance';
import { baseUrl } from '../../api/BaseData';
import { IResponse } from '../../models/common';
import { IIntention } from '../../models/finance';

@Entry
@Component
struct RecommendFinanciers {
  @State recommendList: Array<IIntention> = []
  @State hasIntention: boolean = false;
  @State token: string = '';
  @State intention: IIntention = {}
  @State isShow: boolean = false
  @State timeLimit: Array<string> = ['6', '12', '24', '36']
  @State years: Array<string> = ['六个月', '一年', '二年', '三年']

  async handleLoadIntention() {
    try {
      this.intention = {}
      const res = await getIntentionApi()
      const data: IResponse<Array<IIntention>> = <IResponse<Array<IIntention>>> JSON.parse(res.result.toString())
      if (data?.data.length > 0) {
        this.intention = data?.data[0] || {} as IIntention
        this.hasIntention = true
      } else {
        this.intention = {} as IIntention
        this.hasIntention = false
      }
    } catch (error) {
      console.error('handleGetIntention.error: ', error.message)
    }
  }

  async handleLoadRecommendUser() {
    try {
      this.recommendList = []
      const res = await getRecommendUserListApi()
      const data: IResponse<Array<IIntention>> = <IResponse<Array<IIntention>>> JSON.parse(res.result.toString())
      data.data.forEach((item: IIntention) => this.recommendList.push(item))
    } catch (error) {
      console.error('handleLoadRecommendUser.error: ', error.message)
    }
  }

  async handleUpdateIntention() {
    try {
      const res = await updateIntentionApi(this.intention)
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '更新成功!',
          duration: 1000,
        });
        setTimeout(() => {
          this.handleLoadIntention()
          this.isShow = false
        }, 1000)
      } else {
        promptAction.showToast({
          message: '更新失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleUpdateIntention.error: ', error.message)
    }
  }

  async handleAddIntention() {
    try {
      const res = await addIntentionApi(this.intention)
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '添加成功!',
          duration: 1000,
        });
        setTimeout(() => {
          this.handleLoadIntention()
          this.isShow = false
        }, 1000)
      } else {
        promptAction.showToast({
          message: '添加失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleAddIntention.error: ', error.message)
    }
  }

  async handleDeleteIntention() {
    try {
      const res = await deleteIntentionApi()
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '删除成功!',
          duration: 1000,
        });
        this.intention = {} as IIntention
        this.handleLoadRecommendUser()
        this.handleLoadIntention()
        this.isShow = false
        console.info('this.intention: ', JSON.stringify(this.intention))
      } else {
        promptAction.showToast({
          message: '删除失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleDeleteIntention.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.token = globalThis.token;
    this.handleLoadRecommendUser();
    this.handleLoadIntention();
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('推荐融资人')
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

      List() {
        ForEach(this.recommendList, (item: IIntention) => {
          ListItem() {
            Row() {
              Image(baseUrl + "/file/" + item?.avatar)
                .width(120)
                .height(120)
                .borderRadius(10)
                .margin(10)
              Column() {
                Text("姓名:" + item.realName)
                  .margin(3)
                Text("联系方式:" + item.phone)
                  .margin(3)
                Text("地址:" + item.address)
                  .margin(3)
                Text("农作物:" + item.item)
                  .margin(3)
                Row() {
                  Text("金额:" + (item.amount == '-1' ? '-' : item.amount) + "元")
                    .margin({ right: 20 })
                  Text("种植面积:" + (item.area == '-1' ? '-' : item.area) + "亩")
                }
                .margin(3)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .borderWidth(1)
            .borderRadius(10)
            .borderColor(Color.Grey)
            .margin(10)
            .width('95%')
          }
        })
      }
      .margin({ top: 60, bottom: 60 })

      Stack({ alignContent: Alignment.Bottom }) {
        Button(!this.hasIntention ? '添加融资意向' : '我的融资意向')
          .fontColor(Color.White)
          .backgroundColor(Color.Red)
          .type(ButtonType.Normal)
          .width('95%')
          .borderRadius(10)
          .margin({ bottom: 10 })
          .onClick(() => this.isShow = true)
      }
      .width('100%')
      .height('100%')
      .zIndex(-1)

      Panel(this.isShow) {
        Column() {
          Text('我的融资意向')
            .margin({ top: 10, bottom: 20 })

          Row() {
            Text('姓名:')
              .width(90)
              .textAlign(TextAlign.End)
            TextInput({ text: this.intention?.realName || '' })
              .onChange((value: string) => this.intention.realName = value)
              .width(280)
              .margin({ left: 10 })
              .borderRadius(5)
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            Text('联系方式:')
              .width(90)
              .textAlign(TextAlign.End)
            TextInput({ text: this.intention?.phone || '' })
              .onChange((value: string) => this.intention.phone = value)
              .width(280)
              .margin({ left: 10 })
              .borderRadius(5)
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            Text('金额:')
              .width(90)
              .textAlign(TextAlign.End)
            TextInput({ text: this.intention?.amount || '' })
              .onChange((value: string) => this.intention.amount = value)
              .width(200)
              .margin({ left: 10 })
              .borderRadius(5)
            Text("单位：元")
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            Text('用途:')
              .width(90)
              .textAlign(TextAlign.End)
            TextInput({ text: this.intention?.application || '' })
              .onChange((value: string) => this.intention.application = value)
              .width(280)
              .margin({ left: 10 })
              .borderRadius(5)
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            Text('农作物名称:')
              .width(90)
              .textAlign(TextAlign.End)
            TextInput({ text: this.intention?.item || '' })
              .onChange((value: string) => this.intention.item = value)
              .width(280)
              .margin({ left: 10 })
              .borderRadius(5)
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            Text('种植面积:')
              .width(90)
              .textAlign(TextAlign.End)
            TextInput({ text: this.intention?.area || '' })
              .onChange((value: string) => this.intention.area = value)
              .width(200)
              .margin({ left: 10 })
              .borderRadius(5)
            Text("单位：亩")
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            Text('意向借款期:')
              .width(90)
              .textAlign(TextAlign.End)
            Select([{ value: '六个月' }, { value: '一年' }, { value: '二年' }, { value: '三年' }])
              .value(!this.intention?.repaymentPeriod ? '请选择意向借款期' : this.years[parseInt(<number> <unknown> this.intention.repaymentPeriod / 12 + '')])
              .onSelect((index: number) => this.intention.repaymentPeriod = this.timeLimit[index])
              .width(200)
              .margin({ left: 10 })
              .borderRadius(5)
            Text('单位：月')
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            Text('地址:')
              .width(90)
              .textAlign(TextAlign.End)
            TextInput({ text: this.intention?.address || '' })
              .onChange((value: string) => this.intention.address = value)
              .width(280)
              .margin({ left: 10 })
              .borderRadius(5)
          }
          .margin({ bottom: 20 })
          .width('100%')


          Row() {
            if (!this.hasIntention) {
              Button('确定')
                .type(ButtonType.Normal)
                .borderRadius(5)
                .margin({ right: 20 })
                .onClick(() => this.handleAddIntention())
            } else {
              Button('编辑')
                .type(ButtonType.Normal)
                .borderRadius(5)
                .margin({ right: 20 })
                .onClick(() => this.handleUpdateIntention())
              Button('删除')
                .type(ButtonType.Normal)
                .backgroundColor(Color.Red)
                .borderRadius(5)
                .margin({ right: 20 })
                .onClick(() => this.handleDeleteIntention())
            }
            Button('取消')
              .type(ButtonType.Normal)
              .backgroundColor(Color.Grey)
              .onClick(() => this.isShow = false)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }

      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .dragBar(true)
      .halfHeight(580)
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}