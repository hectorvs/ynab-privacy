import {Component, Inject} from '@angular/core';
import {MatStepper} from "@angular/material";
import {Observable} from "rxjs";

import {YnabService} from "./ynab.service";
import {PrivacyService} from "./privacy.service";
import {Account, Budget, Card, Category, CategoryCardLink, CategoryGroup} from "./models";

import templateString from './budgets.component.html';
import {CardLinkService} from "./card-link.service";
import {DOCUMENT} from "@angular/common";

@Component({
    template: templateString
})
export class BudgetsComponent {
    constructor(private ynabService: YnabService,
                private privacyService: PrivacyService,
                private cardLinkService: CardLinkService,
                @Inject(DOCUMENT) private document: any) { }


    category_groups$: Observable<CategoryGroup[]>;
    cards$: Observable<Card[]>;
    accounts$: Observable<Account[]>;
    budgets: Budget[] = [];

    selectedBudget: Budget;
    selectedCategory: Category;
    selectedAccount: Account;
    selectedCards: Card[] = [];
    categoryCardLinks: CategoryCardLink[] = [];

    creating = false;

    ngOnInit() {
        this.ynabService.listBudgets().subscribe(
            budgets => {
                this.budgets = budgets
            },
            error => {
                console.log(error);
                this.document.location.href = window.location.origin;
            }
        );

        this.cards$ = this.privacyService.listCards();

        this.cardLinkService.listCardLinks().subscribe(cardLinks =>{
                this.categoryCardLinks = cardLinks
            }
        )
    }

    budgetDropdownSelect(budget: Budget) {
        this.accounts$ = this.ynabService.listAccounts(budget.id);
        this.category_groups$ = this.ynabService.listCategories(budget.id);
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

    selectedAccountMessage(): string {
        let message = "Privacy.com Card Funding";

        if (this.selectedAccount !== undefined) {
            message = this.selectedAccount.name;
        }

        return message;
    }

    cardName(card: Card): string {
        if (card.hostname === '') {
            return card.memo;
        }

        return card.hostname;
    }

    createLinks(stepper: MatStepper) {
        this.creating = true;
        for(const card of this.selectedCards) {

            this.cardLinkService.postCardLink(
                new CategoryCardLink(
                    card.token,
                    this.cardName(card),
                    this.selectedAccount.id,
                    this.selectedAccount.name,
                    this.selectedBudget.id,
                    this.selectedBudget.name,
                    this.selectedCategory.id,
                    this.selectedCategory.name)
            ).subscribe(
                cardLink => this.categoryCardLinks.push(cardLink),
                error => { console.log(error) },
                () => {
                    this.selectedCategory = undefined;
                    this.selectedAccount = undefined;
                    this.selectedCards = [];
                    this.creating = false;
                    stepper.reset();
                }
            )

        }
    }

    deleteLink(cardLinkId: string) {
        this.cardLinkService.deleteCardLink(cardLinkId).subscribe( _ => {
            this.categoryCardLinks = this.categoryCardLinks.filter( cardLink => {
                return cardLink.id !== cardLinkId;
            })
        });
    }

    disableOption(card: Card): boolean {
        let link: CategoryCardLink = this.categoryCardLinks.find(cardLink =>
            cardLink.privacy_card_id === card.token
        );

        return link !== undefined;
    }
}
