import { NgModule } from '@angular/core';
import { RouterModule } from "@angular/router";
import { ShellComponent } from "./home/shell.component";
import { WelcomeComponent } from "./home/welcome.component";
import { PageNotFoundComponent } from "./home/page-not-found.component";
import {BudgetsComponent} from "./home/budgets.component";

@NgModule({
    imports: [
        RouterModule.forRoot( [
            {
                path: '',
                component: ShellComponent,
                children: [
                    {
                        path: 'welcome', component: WelcomeComponent
                    },
                    {
                        path: 'budgets', component: BudgetsComponent
                    },
                    { path: '', redirectTo: 'welcome', pathMatch: 'full' }
                ]
            },
            {
                path: '**', component: PageNotFoundComponent
            }
            ], {
            useHash: true
            }
        )
    ],
    exports: [RouterModule]
})

export class AppRoutingModule { }

