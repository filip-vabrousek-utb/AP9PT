## IONIC
moje představení 

1) Jméno + Přijímení tiskacím + podpis
2) Na záčátek dám papír 
3) dostat se k seznamu studentů
4) ať vím kdo má chodit
5) Kdo má zkušenosti?
6) Kterou aplikaci byste vylepšili





Otevřít web IONIC
* IONIC 
IONIC = JS framework na tvorbu aplikací spoluprcuje s React a Angular

**Nástroje**
* nativní - UIKit, SwiftUI ObjC, Swift, Java kotlin jednodušší syntaxe ...
* multiplatformní - Flutter aplikace na nativním zařízení je 
* hybridní - webové technologie jako WebView IONIC

Ukázat stránku projektu.  

* Ionic - hybridní
* Capacitor.js - část Ionicu pro přístup k hw jako foťák, 

Angular templ, class, TS vs React JS



**Distribuce**
* App Store
* Google Play
* PWA na plochu
* IDE - andr. st., Xcode


Klasifikace
Mobilní aplikace závěrečného projektu by měla plnit rozsahově následující kritéria:
zdrojové kódy přístupné v nějakém verzovacím systému (GIT)
vlastní ikona aplikace, vlastní splashscreen
více propojených obrazovek, funkční navigační stack (přechody mezi obrazovkami)
ukládání dat do perzistentní paměti zařízení
vstup od uživatele (zadávání dat uživatelem)
komunikace s libovolným REST API
Lze zvolit libovolnou platformu (Android, iOS), programovací jazyk či vývojový framework.

Prezentace projektu proběhne osobně ve zkouškovém období na vypsaných termínech. Není nutné připravovat oficiální prezentaci, jde o předvedení funkčnosti a stručný popis toho, co aplikace řeší a jak. Je třeba mít připraveny zdrojové kódy a být schopen odpovědět na dotazy týkající se implementace aplikace, čímž se jasně prokáže autorství.

**Nutné požadavky na systém pro studenty s vlastním PC/Mac**
Nainstalované NPM, Node.js jako globální knihovny dostupné skrze příkazový řádek / terminal
Instalujte vždy poslední aktuální verze ne vývojové!
Android Studio + Java SDK + Android SDK + vše potřebné pro vývoj Android aplikací (bude nutné později v semestru)
GIT

**Nutné znalosti**
* Základy HTML, CSS, JS / TS
* GIT
* Znát IDE a jeho znalost s příkazy (klávesové zkratky)
* kopírování, duplikování, mazání řádku
* vyhledávání / replace v souboru
* vyhledávání / replace v celém projektu
* vyhledávání složek / souborů dle názvu
* vertikální označování s více řádky
* automatický hotfix / opravy kódu, generace kódu
* automatický refactoring / optimalizace / organizace kódu v souboru (celém projektu)




```html
<ion-header>
  <ion-navbar>
    <ion-title>To do</ion-title>
    <ion-buttons end>

      <button ion-button (click)="openToDoAlert()">
        <ion-icon name="add"></ion-icon>
      </button>
      
    </ion-buttons>
  </ion-navbar>
</ion-header>

<ion-content padding>

  <ion-list [reorder]="reorderIsEnabled" (ionItemReorder)="itemReordered($event)">
    <ion-item-sliding *ngFor="let todo of todos; let todoIndex = index">
      <ion-item>{{todo}}</ion-item>
    </ion-item-sliding>
  </ion-list>

</ion-content>
```



```ts



import { Component } from '@angular/core';
import {
  NavController,
  AlertController,
  reorderArray,
  ToastController,
} from 'ionic-angular';
import { TodoService } from '../../providers/todo';
import { ArchivedTodosPage } from '../archived-todos/archived-todos';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html',
})
export class HomePage {
  public todos = [];
  public reorderIsEnabled = false;
  public archivedTodosPage = ArchivedTodosPage;

  constructor(
    private toastController: ToastController,
    public navCtrl: NavController,
    private alertController: AlertController,
    private todoService: TodoService
  ) {
    this.todos = this.todoService.getTodos();
  }

  openToDoAlert() {
    let addTodoAlert = this.alertController.create({
      title: 'Add A Todo',
      message: 'Enter Your Todo',
      inputs: [
        {
          type: 'text',
          name: 'addTodoInput',
        },
      ],
      buttons: [
        {
          text: 'Cancel',
        },
        {
          text: 'Add todo',
          handler: (inputData) => {
            let todoText = inputData.addTodoInput;
            this.todoService.addTodo(todoText);
          },
        },
      ],
    });

    addTodoAlert.present();
  }
}
```



```ts
import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import 'rxjs/add/operator/map';

@Injectable()
export class TodoService {
  private todos = [];
  private archivedTodos = [];

  constructor(public http: Http) {    
  }

  getTodos() {
    return this.todos;
  }

  addTodo(todo) {
    this.todos.push(todo);
  }

  archiveTodo(todoIndex) {
    let todoToBeArchived = this.todos[todoIndex];
    this.todos.splice(todoIndex, 1);
    this.archivedTodos.push(todoToBeArchived)
  }

  getArchivedTodos() {
    return this.archivedTodos;
  }

  editTodo(todoIndex, todoText) {
    this.todos[todoIndex] = todoText;
  }
}
```



iOS 17 this year







