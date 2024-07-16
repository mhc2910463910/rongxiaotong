import {TabList} from '../component/index/TabList'
import {CarInfo} from '../view/index/CarInfoView'
import {MyInfo} from '../view/index/MyInfo'
import {SearchView} from '../view/index/SerarchView'
import {Home} from '../view/index/HomeView'

@Entry
@Component
struct Index {
  // 导航栏
  private tabsController : TabsController = new TabsController()
  @State currentIndex:number = 0;
  // aboutToAppear(){
  //   // DONE，去除这个初始Tab下标变化
  //   this.currentIndex = 2
  // }
  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    } .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(this.currentIndex);
    })
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#C1FFC1')
    .padding(5)
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      // HOME
      TabContent() {
        // 首页
        if (this.currentIndex == 0) {
          Home()
        }
      }.tabBar(this.TabBuilder('首页', 0, $r('app.media.home3'), $r('app.media.home1')))

      TabContent() {
        // 探索
        if (this.currentIndex == 1) {
          SearchView()
        }
      }.tabBar(this.TabBuilder('探索', 1, $r('app.media.Search_3'), $r('app.media.Search_1')))

      TabContent(){
        // 购物车
        if (this.currentIndex == 2) {
          CarInfo()
        }
      }.tabBar(this.TabBuilder('购物车',2,$r('app.media.Bag'),$r('app.media.Bag2')))

      TabContent(){
        // 我的
        if(this.currentIndex == 3) {
          MyInfo()
        }
      }
      .tabBar(this.TabBuilder('我的',3,$r('app.media.user_3'),$r('app.media.user_1')))
    }.onChange((index) => {
      this.currentIndex = index
    })
    .height('100%')
    .width('100%')
  }
}