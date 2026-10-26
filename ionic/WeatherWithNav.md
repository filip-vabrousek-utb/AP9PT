## WeatherWithNav
src>app>home>home.page.ts

```ts

import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { PlacesService } from '../services/places/places.service';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  jsonData: any
  backup: any
  filterYear: any

  constructor(public httpClient: HttpClient,
    private placesService: PlacesService
    ) { // quick fix imports this
    this.loadData();
  }

  loadData(){
    this.httpClient.get("https://datausa.io/api/data?drilldowns=Nation&measures=Population")
    .subscribe(data => { // lze nahradit async
      console.log(data);
      this.backup = data;
      this.jsonData = data;
    });

  }


  sendData(arg: any){
    this.placesService.data = arg;
  }

  applyFilter(){
    this.jsonData = this.backup;
    console.log(this.jsonData.data);

    if (this.filterYear != null || this.filterYear === ""){
      this.jsonData.data = this.jsonData.data.filter((item: any) => item['Year'] === this.filterYear.toString());
    } else {
      this.jsonData.data = this.backup.data;
    }
   
  }
/*
Capacitor for saving data local storage
PWA => firebase hosting


1) Add nav to weather with detail
2) Modal windows + design of elements
3) Finalise apps => refactor
4) Capacitor


8 cvičení ionic
3/8 done

i cvičení na dotazy poslední cviko




Capacitor ke konci




*/
}

```

home.page.html
```html
<ion-header [translucent]="true">
  <ion-toolbar>
    <ion-title>
      Blank
    </ion-title>
  </ion-toolbar>
</ion-header>

<ion-content [fullscreen]="true">
  <ion-header collapse="condense">
    <ion-toolbar>
      <ion-title size="large">Blank</ion-title>
    </ion-toolbar>
  </ion-header>

  <div id="container">
   <h1>USA Data</h1>


  <div *ngIf="jsonData">

    <ion-item>
      <ion-label>Filter by Year:</ion-label>
      <ion-input type="number" [(ngModel)]="filterYear" (ionChange)="applyFilter()"></ion-input>
    </ion-item>




    <!----
    <ion-item 
    [routerLink]="['/detail', '1']"
    (click)="sendData(item)">
    {{ item['ID Year'] }}
    </ion-item>
--->

<ion-item 
*ngFor="let item of jsonData.data"
    [routerLink]="['/detail', item['ID Year']]"
    (click)="sendData(item)">
    {{ item['ID Year'] }}
    </ion-item>

    <!----
    <strong>ID Year:</strong> {{ item['ID Year'] }}<br>
    <strong>Year:</strong> {{ item.Year }}<br>
    <strong>Population:</strong> {{ item.Population }}<br>
  --->

  <!---app folder ionic g service services/places/places-->
</div>
  </div>

  <!---https://datausa.io/api/data?drilldowns=Nation&measures=Population-->
</ion-content>

```

## App routing module ts
```ts
import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'home',
    loadChildren: () => import('./home/home.module').then( m => m.HomePageModule)
  },
  {
    path: '',
    redirectTo: 'home',
    pathMatch: 'full'
  },
  { // auto
    path: 'detail/:id',
    loadChildren: () => import('./pages/detail/detail.module').then( m => m.DetailPageModule)
  },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }

```



### Places service

```ts
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class PlacesService {
   data: any;
  constructor() { }
}

// ionic g page pages/detail
// add the detail
// lazy loading

// ionic g service services/places/places
// make service
```
