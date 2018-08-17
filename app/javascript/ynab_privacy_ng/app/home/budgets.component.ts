import {Component, EventEmitter} from '@angular/core';
import {YnabService} from "./ynab.service";
import {PrivacyService} from "./privacy.service";
import {Budget, Card, Category, CategoryGroup} from "./models";
import {Observable} from "rxjs";
import {filter, map, tap} from "rxjs/operators";
import templateString from './budgets.component.html';
import {MatSelectChange, MatStepper} from "@angular/material";

@Component({
    template: templateString
})
export class BudgetsComponent {
    constructor(private ynabService: YnabService, private privacyService: PrivacyService) { }

    budgets$: Observable<Budget[]>;
    category_groups$: Observable<CategoryGroup[]>;
    cards$: Observable<Card[]>;

    selectedBudget: Budget;
    selectedCategory: Category;
    selectedCards: Card[];

    ngOnInit() {
        this.budgets$ = this.ynabService.listBudgets();
        this.cards$ = this.privacyService.listCards().pipe(
            map(cards => {
                return cards.filter(card => {
                    return card.state == 'OPEN';
                })
            })
        );
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

    cardName(card: Card): string {
        if (card.hostname === '') {
            return card.memo;
        }

        return card.hostname;
    }
}
