@Entry
@Component
struct CommodityCardList {
  build() {
    Grid() {
      GridItem() {
        CommodityCard({
          src: $r('app.media.icon'),
          status: '供',
          title: '小麦',
          description: '出售小麦，质量好，价格优。',
          price: 2.00
        })
      }

      GridItem() {
        CommodityCard({
          src: $r('app.media.icon2'),
          status: '供',
          title: '小麦',
          description: '出售小麦',
          price: 2.00
        })
      }

      GridItem() {
        CommodityCard({
          src: $r('app.media.icon2'),
          status: '供',
          title: '小麦',
          description: '出售小麦',
          price: 2.00
        })
      }

      GridItem() {
        CommodityCard({
          src: $r('app.media.icon2'),
          status: '需',
          title: '小麦',
          description: '出售小麦',
          price: 2.00
        })
      }

    }.columnsTemplate('1fr 1fr').padding(10)
    .columnsGap(10)
    .rowsGap(10)
  }
}

interface IStatusMap {
  [key: string]: ResourceColor;
}

let statusMap: IStatusMap = {
  '供': Color.Green,
  '需': Color.Yellow,
}

@Component
struct CommodityCard {
  private src: Resource;
  private status: string
  private title: string
  private description: string
  private price: number

  build() {
    Column() {
      Image(this.src).width('100%').objectFit(ImageFit.Contain)
      Row() {
        Text(this.status).backgroundColor(statusMap[this.status])
          .textAlign(TextAlign.Center)
          .padding(5)
          .borderRadius(5)
          .fontColor(Color.White)
          .margin({right: 15})
        Text(this.title).fontWeight(FontWeight.Bolder)
      }

      Text(this.description)
        .textOverflow({overflow: TextOverflow.Clip}).maxLines(1)
      Text(`¥${this.price.toFixed(2)}`)
        .fontColor(Color.Red).fontSize(20)
        .margin({left:8})
    }
    .alignItems(HorizontalAlign.Start)
    .padding(10)
    .border({
      width: 2,
      color: Color.Red
    })
    .borderRadius(10)
  }
}