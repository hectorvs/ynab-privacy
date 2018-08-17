import {Component, EventEmitter} from '@angular/core';
import {YnabService} from "./ynab.service";
import {Budget, Category, CategoryGroup} from "./models";
import {Observable} from "rxjs";
import {filter, map, tap} from "rxjs/operators";
import templateString from './budgets.component.html';
import {MatSelectChange, MatStepper} from "@angular/material";

@Component({
    template: templateString
})
export class BudgetsComponent {
    constructor(private ynabService: YnabService) { }

    budgets$: Observable<Budget[]>;
    category_groups$: Observable<CategoryGroup[]>;

    selectedBudget: Budget;
    selectedCategory: Category;

    ngOnInit() {
        this.budgets$ = this.ynabService.listBudgets();
    }

    budgetDropdownSelect(stepper: MatStepper, budget: Budget) {
        this.selectedBudget = budget;

        this.category_groups$ = this.ynabService.listCategories(budget.id).pipe(
            map(category_groups => {
                return category_groups.filter(category_group => {
                        return (category_group.name !== "Internal Master Category") &&
                            (category_group.name !== "Hidden Categories");
                    }
                )
            }),
            tap(_ => stepper.next())
        );
    }

    categoryDropdownSelect(stepper: MatStepper, category: Category) {
        this.selectedCategory = category;
        stepper.next();

        console.log(category.id);
        console.log("$" + category.balance / 1000)
    }

    selectedBudgetMessage(): string {
        let message = "Select a Budget";

        if (this.selectedBudget !== undefined) {
            message = this.selectedBudget.name;
        }

        return message;
    }

    selectedCategoryMessage(): string {
        let message = "Select a Category";

        if (this.selectedCategory !== undefined) {
            message = this.selectedCategory.name;
        }

        return message;
    }
}
