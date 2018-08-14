import { Component } from '@angular/core';
import {YnabService} from "./ynab.service";
import {Budget} from "./models";
import {Observable} from "rxjs";
import templateString from './welcome.component.html';

@Component({
    template: templateString
})
export class WelcomeComponent {
    constructor(private ynabService: YnabService) { }

    budgets$: Observable<Budget[]>;

    ngOnInit() {
        this.budgets$ = this.ynabService.listBudgets();
    }


}