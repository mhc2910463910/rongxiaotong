/*
  管理员获取用户列表
 */
import router from '@ohos.router'
import { getUserList } from '../../api/UserApi'
@Entry
@Component
struct UserList{
  @State type: string="用户信息"
  @State userList: Array<any> = []
  aboutToAppear(){
    getUserList().then((res)=>{
      let DataArray=JSON.parse(res.result.toString())
        .data;
      for(let index=0;index<DataArray.length;index++){
        const element=DataArray[index];
        this.userList.push(element);
      }
    })
  }
  build(){
    Flex({direction: FlexDirection.Column}) {
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
      Flex({direction: FlexDirection.Row,alignItems:ItemAlign.Center}){
        Text("姓名")
          .width('18%')
          .textAlign(TextAlign.Center)
        Text("昵称")
          .width('18%')
          .textAlign(TextAlign.Center)
        Text("角色")
          .width('18%')
          .textAlign(TextAlign.Center)
        Text("电话")
          .width('30%')
          .textAlign(TextAlign.Center)
        Text("操作")
          .width('16%')
          .textAlign(TextAlign.Center)
      }.height(70)
      .backgroundColor('#cfcfcf')
      Grid() {
        if(this.userList.length==0){
          GridItem(){
            Text("什么也没有").width('100%')
              .fontColor(Color.Gray)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .margin({top: 50})
          }
        }else {
          ForEach(this.userList, (item, i) => {
            GridItem() {
              Flex({ direction: FlexDirection.Row,alignItems:ItemAlign.Center }) {
                Text(item.userName)
                  .width('18%')
                  .textAlign(TextAlign.Center)
                Text(item.nickName)
                  .width('18%')
                  .textAlign(TextAlign.Center)
                Text(item.role)
                  .width('18%')
                  .textAlign(TextAlign.Center)
                Text(item.phone)
                  .width('30%')
                  .textAlign(TextAlign.Center)
                Text("明细")
                  .width('16%')
                  .textAlign(TextAlign.Center)
                  .onClick(()=>{
                    router.pushUrl({
                      url: "pages/Admin/updateUser",
                      params: {
                        "user": item
                      }
                    })
                  })
              }.width('100%')
            }.height(70)
            .backgroundColor(i%2==0?"#BBFFFF":"#FFFAF0")
          })
        }
      }.columnsTemplate('1fr')
      .backgroundColor('#F0FFF0')
    }
  }
}