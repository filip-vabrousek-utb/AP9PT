

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
