import { Component } from '@angular/core';
import {YnabService} from "./ynab.service";
import {Budget, CategoryGroup} from "./models";
import {Observable} from "rxjs";
import {filter, map, tap} from "rxjs/operators";
import templateString from './budgets.component.html';

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

    dropdownSelect(budget_id: string) {
        // this.ynabService.listCategories(budget_id)
        //     .subscribe(category_groups => {
        //         this.category_groups = category_groups
        //             .filter(category_group => {
        //                  return (category_group.name !== "Internal Master Category") && (category_group.name !== "Hidden Categories");
        //         });
        //     });
        this.category_groups$ = this.ynabService.listCategories(budget_id).pipe(
            map(category_groups => {
                return category_groups.filter(category_group => {
                        return (category_group.name !== "Internal Master Category") &&
                            (category_group.name !== "Hidden Categories");
                    }
                )
            })
        );
    }
}
