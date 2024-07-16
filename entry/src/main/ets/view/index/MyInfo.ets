import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import {baseUrl} from '../../api/BaseData'
import {getInfo} from '../../api/LoginApi'
@Component
struct typeItem{
  @State icon: any='';
  @State name: string='';
  build(){
    Column() {
      Image(this.icon)
        .width('35')
      Text(this.name)
        .textAlign(TextAlign.Center)
        .padding(10)
        .fontSize(12)
    }.width('25%')
    .height('100')
    .justifyContent(FlexAlign.Center)
  }
}
@Component
struct funItem{
  private icon: any='';
  private name: string='';
  build(){
    Row() {
      Image(this.icon)
        .width(20)
      Text(this.name)
      Blank()
      Image($r('app.media.jt_2'))
        .width(20)
        .margin({right:20})
    }.width('100%')
    .padding(20)
    .backgroundColor('rgba(250,250,250,0.7)')
  }
}
@Preview
@Component
// @Entry
export struct MyInfo{
  private scroller: Scroller=new Scroller()
  private iconList: Array<any> =[]
  @State info: any=''
  @State role: string='user'
  aboutToAppear(){
    this.iconList.push($r('app.media.3D'))
    this.iconList.push($r('app.media.Clock1'))
    this.iconList.push($r('app.media.car'))
    this.iconList.push($r('app.media.Inbox'))
    if(globalThis.info){
      this.info=globalThis.info;
      this.role=globalThis.info.role;
      this.scroller=this.info.role;
    }else if(globalThis.token){
      getInfo().then((res)=>{
        let resData=JSON.parse(res.result.toString())
        this.info=resData.data;
        this.role=this.info.role;
        globalThis.info=resData.data;
      })
    }
  }
  build(){
    // Text("个人中心")
    Column(){
      Column() {
        Text(this.info)
          .fontColor('#f8fafc')
          .padding({ top: 10, left: 15 })
          .textAlign(TextAlign.Start)
          .width('100%')
          .fontSize(20)
        Row() {
          if(this.info){
            Column(){
              Row({space:5}) {
                Column() {
                  Image(`${baseUrl}/file/${this.info.avatar}`)
                    .width(90)
                    .height(90)
                    .borderRadius(20)
                }
                Column() {
                  Row() {
                    Text(this.info.nickName).fontSize(20).fontColor('#ffffff').fontWeight(700)
                      .padding({ left: 10 })
                  }.padding(10)
                  Row() {
                    Text(this.info.phone).fontSize(15).fontColor('#ffffff').fontWeight(400)
                  }.padding(10)
                }
                Blank()
                Text("修改资料").height(30).fontSize(12).fontColor('#ffffff')
                  .onClick(()=>{
                    router.pushUrl({
                      url: "pages/Info"
                    })
                  })
                Image($r('app.media.jt_2'))
                  .width(20)
                  .margin({ right: 20 })
              }
            }
          }else {
            Image($r('app.media.nologin'))
              .width(90)
            Text("登  录")
              .fontColor(Color.White)
              .padding({ left: 10 })
              .onClick(()=>{
                router.pushUrl({url: `pages/LoginPage`})
              })
            Blank()
            Image($r('app.media.jt_2'))
              .width(20)
              .margin({ right: 20 })
          }
        }.justifyContent(FlexAlign.Start)
        .width('100%')
        .padding({ left: 30, top: 20 })

        Row() {
          if(this.role=='user'){
            typeItem({ icon: this.iconList[0], name: '我的问答' })
              .onClick(()=>{
                if(globalThis.token){
                  router.pushUrl({
                    url: "pages/AllQuestion"
                  })
                }else {
                  promptAction.showToast({
                    message: '您未登录',
                    duration: 2000,
                  });
                }
              })
            typeItem({ icon: this.iconList[1], name: '我的预约' })
              .onClick(()=>{
                if(globalThis.token){
                  router.pushUrl({
                    url: "pages/AllReverse"
                  })
                }else {
                  promptAction.showToast({
                    message: '您未登录',
                    duration: 2000,
                  });
                }
              })
            typeItem({ icon: this.iconList[2], name: '我买的' })
              .onClick(()=>{
                if(globalThis.token){
                  router.pushUrl({
                    url: "pages/MyBuys"
                  })
                }else {
                  promptAction.showToast({
                    message: '您未登录',
                    duration: 2000,
                  });
                }
              })
            typeItem({ icon: this.iconList[3], name: '我卖的' })
              .onClick(()=>{
                if(globalThis.token){
                  router.pushUrl({
                    url: "pages/MySells"
                  })
                }else {
                  promptAction.showToast({
                    message: '您未登录',
                    duration: 2000,
                  });
                }
              })
          }
         if(this.role=="expert"){
           typeItem({ icon: this.iconList[0], name: '我的问答' })
             .onClick(()=>{
               if(globalThis.token) {
                 router.pushUrl({
                   url: "pages/AllQuestion"
                 })
               }else{
                 promptAction.showToast({
                   message: '您未登录',
                   duration: 2000,
                 });
               }
             })
           typeItem({ icon: this.iconList[1], name: '我的预约' })
             .onClick(()=>{
               if(globalThis.token) {
                 router.pushUrl({
                   url: "pages/AllReverse"
                 })
               }else{
                 promptAction.showToast({
                   message: '您未登录',
                   duration: 2000,
                 });
               }
             })
           typeItem({ icon: this.iconList[2], name: '我的知识' })
             .onClick(()=>{
               if(globalThis.token) {
                 router.pushUrl({
                   url: "pages/expert/ExpertKnowledgeList"
                 })
               }else{
                 promptAction.showToast({
                   message: '您未登录',
                   duration: 2000,
                 });
               }
             })
           typeItem({ icon: this.iconList[3], name: '专家信息' })
             .onClick(()=>{
               if(globalThis.token) {
                 router.pushUrl({
                   url: "pages/expert/ExpertInfo"
                 })
               }else{
                 promptAction.showToast({
                   message: '您未登录',
                   duration: 2000,
                 });
               }
             })
         }
          if(this.role=="admin"){
            Row(){
              Text("欢迎管理员登录")
            }.backgroundColor('#FFFFFF')
            .width('100%')
            .borderRadius(10).shadow({radius:4,color:'#EBEBEB',offsetX:0,offsetY:2})
            .justifyContent(FlexAlign.SpaceAround)
          }
        }
        .backgroundColor(Color.White)
        .width('96%')
        .height('100')
        .borderRadius(20)
        .margin({ top: 20 })
      }.width('100%')
      .height('25%')
      .backgroundColor(Color.Green)

        Scroll(this.scroller) {
          Column(){
          // 普通用户
          if(this.role=="user") {
              //   基本信息
              Text("基本信息")
                .width('100%')
                .textAlign(TextAlign.Start)
                .padding(15)
                .backgroundColor('rgba(50,50,50,0.5)')
              funItem({ icon: $r('app.media.user'), name: "我的需求" })
                .onClick(()=>{
                  if(globalThis.token){
                    router.pushUrl({
                      url: "pages/Needs/BaseBuy"
                    })
                  }else{
                    promptAction.showToast({
                      message: '您未登录',
                      duration: 2000,
                    });
                  }
                })
              funItem({ icon: $r('app.media.tabler_credit_card'), name: "我发布的" })
                .onClick(()=>{
                  if(globalThis.token) {
                    router.pushUrl({
                      url: "pages/Goods/GoodsList"
                    })
                  }else{
                    promptAction.showToast({
                      message: '您未登录',
                      duration: 2000,
                    });
                  }
                })
              funItem({ icon: $r('app.media.map_pin'), name: "收货地址" })
                .onClick(()=>{
                  if(globalThis.token) {
                    router.pushUrl({
                      url: 'pages/AddressesManagePage'
                    })
                  }else{
                    promptAction.showToast({
                      message: '您未登录',
                      duration: 2000,
                    });
                  }
                })
              // //   融资信息
              // Text("融资信息")
              //   .width('100%')
              //   .textAlign(TextAlign.Start)
              //   .padding(15)
              //   .backgroundColor('rgba(50,50,50,0.5)')
              // funItem({ icon: $r('app.media.message_dots'), name: "智能匹配" })
              // funItem({ icon: $r('app.media.notes'), name: "融资申请" })
              // funItem({ icon: $r('app.media.star_2x'), name: "我的融资" })
              // //   其它操作
              // Text("其它操作")
              //   .width('100%')
              //   .textAlign(TextAlign.Start)
              //   .padding(15)
              //   .backgroundColor('rgba(50,50,50,0.5)')
              // funItem({ icon: $r('app.media.arrow_narrow_right'), name: "注销" })
          }
          if(this.role=="expert") {
            //   专家用户
              //   基本信息
              Text("基础信息")
                .width('100%')
                .textAlign(TextAlign.Start)
                .padding(15)
                .backgroundColor('rgba(50,50,50,0.5)')
              funItem({ icon: $r('app.media.fabu'), name: "发布知识" })
                .onClick(()=>{
                  router.pushUrl({
                    url: 'pages/expert/AddExpertKnowledge',
                    params:{
                      type: "add"
                    }
                  })
                })
              funItem({ icon: $r('app.media.map_pin'), name: "收货地址" })
                .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/AddressesManagePage'
                    })
                })
              // //   融资信息
              // Text("融资信息")
              //   .width('100%')
              //   .textAlign(TextAlign.Start)
              //   .padding(15)
              //   .backgroundColor('rgba(50,50,50,0.5)')
              // funItem({ icon: $r('app.media.message_dots'), name: "智能匹配" })
              // funItem({ icon: $r('app.media.notes'), name: "融资申请" })
              // funItem({ icon: $r('app.media.star_2x'), name: "我的融资" })
              // //   其它操作
              // Text("其它操作")
              //   .width('100%')
              //   .textAlign(TextAlign.Start)
              //   .padding(15)
              //   .backgroundColor('rgba(50,50,50,0.5)')
              // funItem({ icon: $r('app.media.arrow_narrow_right'), name: "注销" })
          }
          if(this.role=="admin") {
            //   管理员
              //   基本信息
              Text("基础信息")
                .width('100%')
                .textAlign(TextAlign.Start)
                .padding(15)
                .backgroundColor('rgba(50,50,50,0.5)')
              funItem({ icon: $r('app.media.user'), name: "用户管理" })
                .onClick(()=>{
                  router.pushUrl({
                    url: "pages/Admin/UserList"
                  })
                })
              funItem({ icon: $r('app.media.Bag2_3x'), name: "商品货源" })
                .onClick(()=>{
                  router.pushUrl({
                    url: "pages/Goods/GoodsList"
                  })
                })
              funItem({ icon: $r('app.media.Bag2_2x'), name: "求购需求" })
                .onClick(()=>{
                  router.pushUrl({
                    url: "pages/Needs/BaseBuy"
                  })
                })
              // //   融资信息
              // Text("融资信息")
              //   .width('100%')
              //   .textAlign(TextAlign.Start)
              //   .padding(15)
              //   .backgroundColor('rgba(50,50,50,0.5)')
              // funItem({ icon: $r('app.media.message_dots'), name: "智能匹配" })
              // funItem({ icon: $r('app.media.notes'), name: "融资申请" })
              // funItem({ icon: $r('app.media.star_2x'), name: "我的融资" })
              // //   其它操作
              // Text("其它操作")
              //   .width('100%')
              //   .textAlign(TextAlign.Start)
              //   .padding(15)
              //   .backgroundColor('rgba(50,50,50,0.5)')
              // funItem({ icon: $r('app.media.arrow_narrow_right'), name: "注销" })
          }
          //   融资信息
            Text("融资信息")
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding(15)
              .backgroundColor('rgba(50,50,50,0.5)')
            funItem({ icon: $r('app.media.message_dots'), name: "智能匹配" })
              .onClick(()=>{
                if(globalThis.token){
                  router.pushUrl({
                    url: 'pages/finance/RecommendFinanciersPage'
                  })
                }else{
                      promptAction.showToast({
                        message: '您未登录',
                        duration: 2000,
                      });
                }
              })
            funItem({ icon: $r('app.media.notes'), name: "融资申请" })
              .onClick(()=>{
                if(globalThis.token) {
                  router.pushUrl({
                    url: 'pages/finance/BankInformationList'
                  })
                }else{
                  promptAction.showToast({
                    message: '您未登录',
                    duration: 2000,
                  });
                }
              })
            funItem({ icon: $r('app.media.star_2x'), name: "我的融资" })
              .onClick(()=>{
                if(globalThis.token) {
                  router.pushUrl({
                    url: 'pages/finance/FinancingInformationManagePage'
                  })
                }else{
                  promptAction.showToast({
                    message: '您未登录',
                    duration: 2000,
                  });
                }
              })
            //   其它操作
            Text("其它操作")
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding(15)
              .backgroundColor('rgba(50,50,50,0.5)')
            funItem({ icon: $r('app.media.arrow_narrow_right'), name: "注销" })
              .onClick(()=>{
                if(globalThis.token){
                  globalThis.token=""
                  globalThis.info=""
                  router.replaceUrl({url: "pages/Index"})
                }else{
                      promptAction.showToast({
                        message: '您未登录',
                        duration: 2000,
                      });
                }
              })
          }
        }.scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
        .height('64%')
      .margin({top:80})
    }.backgroundImage($r('app.media.bg2'))
    .backgroundImageSize(ImageSize.Cover)
    .height('100%')
  }
}