import {Component, EventEmitter} from '@angular/core';
import {YnabService} from "./ynab.service";
import {Budget, Category, CategoryGroup} from "./models";
import {Observable} from "rxjs";
import {filter, map, tap} from "rxjs/operators";
import templateString from './budgets.component.html';
import {MatSelectChange} from "@angular/material";

@Component({
    template: templateString
})
export class BudgetsComponent {
    constructor(private ynabService: YnabService) { }

    budgets$: Observable<Budget[]>;
    // category_groups: CategoryGroup[];
    category_groups$: Observable<CategoryGroup[]>;

    ngOnInit() {
        this.budgets$ = this.ynabService.listBudgets();
    }

    dropdownSelect(budget: Budget) {
        this.category_groups$ = this.ynabService.listCategories(budget.id).pipe(
            map(category_groups => {
                return category_groups.filter(category_group => {
                        return (category_group.name !== "Internal Master Category") &&
                            (category_group.name !== "Hidden Categories");
                    }
                )
            })
        );
    }

    categoryDropdownSelect(category: Category) {
        console.log(category.id);
        console.log(category.balance)
    }
}
