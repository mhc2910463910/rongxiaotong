// 轮播图
class DataSource implements IDataSource {
  private list: number[] = []
  private listener: DataChangeListener

  constructor(list: number[]) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): any {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {
  }
}

import {RoundLinkIconsRow} from './RoundLinkIconsRow'

// @Entry
@Component
export struct Tab1{
  // 搜索栏
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()
  // 轮播图
  private swiperController: SwiperController = new SwiperController()
  private data: DataSource = new DataSource([])
  aboutToAppear(): void {
    let list = []
    list.push($r('app.media.banner_01'))
    list.push($r('app.media.banner_02'))
    list.push($r('app.media.banner_03'))
    list.push($r('app.media.banner_04'))
    list.push($r('app.media.banner_05'))
    this.data = new DataSource(list)
  }
  // 商品列表

  build(){
    Column() {
      // 搜索栏
      Search({ value: this.changeValue, placeholder: '搜索', controller: this.controller})
        .searchButton('确定')
        .width('90%')
        .height(40)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .textFont({ size: 14, weight: 400 })
        .onSubmit((value: string) => {
          this.submitValue = value
        })
        .onChange((value: string) => {
          this.changeValue = value
        })
        .margin(10)
    //   轮播图
      Swiper(this.swiperController) {
        LazyForEach(this.data, (item: string) => {
          Image(item).width('90%').height(160).backgroundColor(0xAFEEEE)
        }, item => item)
      }
      .cachedCount(2)
      .index(1)
      .autoPlay(true)
      .interval(4000)
      .indicator(false)
      .loop(true)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .onChange((index: number) => {
        // console.info(index.toString())
      })
    //   选项
      RoundLinkIconsRow()
    //  商品列表

    }.width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

