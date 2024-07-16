/**
 * 我的融资信息管理
 */
import router from '@ohos.router'
import { getUserFinanceApi, deleteUserFinance } from '../../api/finance'
import { BankMap } from '../../models/finance'
import promptAction from '@ohos.promptAction'
// TODO, 数据表不存在
@Entry
@Component
struct FinancingInformationManage {
  @State datalist: Array<any> = []
  private scroller: Scroller = new Scroller()

  aboutToAppear() {
    // DONE,去除这个token赋值
    // globalThis.token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ6aGFuZ3NhbiIsInJvbGUiOlt7ImF1dGhvcml0eSI6InVzZXIifV0sImV4cCI6MTcyMDQyNjI0NywiaWF0IjoxNzIwNDIyNjQ3MzAzLCJ1c2VybmFtZSI6InpoYW5nc2FuIn0.W3o1nX_pDSqedUZBvvPq2Q5AF9o6Tnk8Gsuixcxdgr8fq-WbSaw9Ti0W1aR243bEHKj7JIOMGWn7vz_M7eHG2A'
    getUserFinanceApi().then(res => {
      console.info('个人融资信息获取：', res.result.toString())
      this.datalist = JSON.parse(res.result.toString()).data
    })
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text("融资信息")
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
          .margin({ top: 10 })
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            // const routerList: Array<string> = globalThis.routerList
            // const routerUrl = routerList.pop();
            // globalThis.routerList = routerList;
            // router.replaceUrl({ url: routerUrl })
            router.back()
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })
      .zIndex(3)

      Column() {
        // 主体内容
        Scroll(this.scroller) {
          Flex({direction:FlexDirection.Column}) {
            ForEach(this.datalist, (item, index) => {
              Column() {
                Row() {
                  Text(`融资信息${index + 1}`)
                    .fontWeight(FontWeight.Bold)
                  Blank()
                  Row() {
                    Button({ type: ButtonType.Normal }) {
                      Text('修改').fontColor(Color.White).fontSize(18)
                    }.backgroundColor('#007dff').padding(12).borderRadius(4)
                    .margin({ right: 12 })

                    Button({ type: ButtonType.Normal }) {
                      Text('删除').fontColor(Color.White).fontSize(18)
                    }.backgroundColor('#007dff').padding(12).borderRadius(4)
                    .onClick(() => {
                      deleteUserFinance(String(item.financeId)).then(res => {
                        let data = JSON.parse(String(res.result))
                        console.info('删除融资', String(res.result))
                        promptAction.showToast({
                          // 删除成功
                          message: data.message,
                          duration: 2000,
                        })
                        // 刷新路由
                        router.replaceUrl({
                          url: 'pages/finance/FinancingInformationManagePage'
                        })
                      })
                    })
                  }
                }.height(64).width('100%')
                .padding({ left: 18, right: 18 })
                // { scroller: this.scroller }
                List() {
                  ListItem() {
                    Row() {
                      Text("姓名: ").textAlign(TextAlign.End).width('40%')
                        .margin({ right: 8 })
                      Text(`${item.realName}`)
                    }.height(64)
                    //   .width('100%')
                  }

                  ListItem() {
                    Row() {
                      Text("手机号: ").textAlign(TextAlign.End).width('40%')
                        .margin({ right: 8 })
                      Text(`${item.phone}`)
                    }.height(64)
                    //   .width('100%')
                  }

                  ListItem() {
                    Row() {
                      Text("身份证号: ").textAlign(TextAlign.End).width('40%')
                        .margin({ right: 8 })
                      Text(`${item.idNum}`)
                    }.height(64)
                    //   .width('100%')
                  }

                  ListItem() {
                    Row() {
                      Text("融资金额: ").textAlign(TextAlign.End).width('40%')
                        .margin({ right: 8 })
                      Text(`${item.money}`)
                    }.height(64)
                    //   .width('100%')
                  }

                  ListItem() {
                    Row() {
                      Text("银行: ").textAlign(TextAlign.End).width('40%')
                        .margin({ right: 8 })
                      // DONE，使用映射来显示银行名称
                      Text(`${BankMap[item.bankId]}`)
                    }.height(64)
                    //   .width('100%')
                  }

                  ListItem() {
                    Row() {
                      Text("利率: ").textAlign(TextAlign.End).width('40%')
                        .margin({ right: 8 })
                      Text(`${item.rate}`)
                    }.height(64)
                    //   .width('100%')
                  }

                  ListItem() {
                    Row() {
                      Text("状态: ").textAlign(TextAlign.End).width('40%')
                        .margin({ right: 8 })
                      // FIXME，有可能有个失败的状态，先不管
                      Text(item.status ? '申请成功' : '申请中')
                    }.height(64)
                    //   .width('100%')
                  }

                  if (item.combinationName1) {
                    ListItem() {
                      Row() {
                        Text("联合申请人1姓名: ").textAlign(TextAlign.End).width('40%')
                          .margin({ right: 8 })
                        Text(item.combinationName1)
                      }.height(64)
                      //   .width('100%')
                    }

                    ListItem() {
                      Row() {
                        Text("联合申请人1电话: ").textAlign(TextAlign.End).width('40%')
                          .margin({ right: 8 })
                        Text(item.combinationPhone1)
                      }.height(64)
                      //   .width('100%')
                    }

                    ListItem() {
                      Row() {
                        Text("联合申请人1ID: ").textAlign(TextAlign.End).width('40%')
                          .margin({ right: 8 })
                        Text(item.combinationIdnum1)
                      }.height(64)
                      //   .width('100%')
                    }
                  }
                  if (item.combinationName2) {
                    ListItem() {
                      Row() {
                        Text("联合申请人2姓名: ").textAlign(TextAlign.End).width('40%')
                          .margin({ right: 8 })
                        Text(item.combinationName2)
                      }.height(64)
                      //   .width('100%')
                    }

                    ListItem() {
                      Row() {
                        Text("联合申请人2电话: ").textAlign(TextAlign.End).width('40%')
                          .margin({ right: 8 })
                        Text(item.combinationPhone2)
                      }.height(64)
                      //   .width('100%')
                    }

                    ListItem() {
                      Row() {
                        Text("联合申请人2ID: ").textAlign(TextAlign.End).width('40%')
                          .margin({ right: 8 })
                        Text(item.combinationIdnum2)
                      }.height(64)
                      //   .width('100%')
                    }
                  }
                }.divider({
                  strokeWidth: 2,
                  // startMargin?: Length,
                  // endMargin?: Length
                }).backgroundColor(Color.White).borderRadius(8)
              }.backgroundColor('#f1f1f1')
              .borderRadius(8).margin({top:12})
            })
          }
        }

      }.margin({ top: 70 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
    .height('100%')
  }
}