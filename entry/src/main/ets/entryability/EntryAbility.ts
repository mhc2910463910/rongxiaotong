import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    let atManager=abilityAccessCtrl.createAtManager();
    try{
      //申请权限
      atManager.requestPermissionsFromUser(this.context,["ohos.permission.APPROXIMATELY_LOCATION","ohos.permission.APPROXIMATELY_LOCATION",'ohos.permission.READ_MEDIA','ohos.permission.WRITE_MEDIA','ohos.permission.MEDIA_LOCATION']).then((data)=>{
        console.info("==========1=data:",JSON.stringify(data));
        //加载ets文件
        windowStage.loadContent('pages/Index',(err,data)=>{
          if(err.code){
            return;
          }
        });
      }).catch((err)=>{console.info("=========2=data:",JSON.stringify(err));
      })
    }catch(err){console.info("=========3=data:",'catch err->${JSON.stringify(err)}');
}   // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
