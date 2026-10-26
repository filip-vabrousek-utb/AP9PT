## Commands

```sh
ionic start first blank --type=angular
```



select ngModules
free Acount: No

```sh
cd ./second
ionic serve
```

select ngModules
free Acount: N

show options
```sh

ionic start --list
```

## counter

home.page-html

```html
<ion-content [fullscreen]="true">
  <div id="container">
    <h1>Count: {{counter}}</h1>
    <ion-button shape="round" (click)="increase()">Increase</ion-button>
  </div>
</ion-content>
```


home.page.ts
```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})


export class HomePage {
  counter = 0;

  increase(){
    this.counter++;
  }

  constructor() {}

}
```





## ToDo list


```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})

export class HomePage {
  tasks: string[] = [];
  newTask: string = '';

  addTask(){
    if (this.newTask.trim() != '') {
      this.tasks.push(this.newTask);
      this.newTask = '';
    }
  }

  constructor() {}
}
```



```html
<ion-content [fullscreen]="true">
  <div id="container">
   <ion-item>
    <ion-input [(ngModel)] = "newTask" placeholder = "Enter a task"></ion-input>
    <ion-button (click)="addTask()">Add</ion-button>
  </ion-item>

  <ion-list>
    <ion-item *ngFor="let task of tasks; let i = index">
      {{ task }}
    </ion-item>
  </ion-list>

  </div>
</ion-content>
```


## Tabs
* tabs.page.html
* tab1.page.html
* tab1.page.ts


## List
* project uses services

```sh
ionic start listTest list --type=angular
```





## Alert


```html
  <ion-button (click)="showAlert()">Basic Alert</ion-button>  
```

```ts
import { Component } from '@angular/core';
import { AlertController } from '@ionic/angular';  

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor(public alertCtrl: AlertController) {}

  async showAlert() {  
    const alert = await this.alertCtrl.create({  
      header: 'Alert',  
      subHeader: 'SubTitle',  
      message: 'This is an alert message',  
      buttons: ['OK']  
    });  
    await alert.present();  
    const result = await alert.onDidDismiss();  
    console.log(result);  
  }  
}
```

