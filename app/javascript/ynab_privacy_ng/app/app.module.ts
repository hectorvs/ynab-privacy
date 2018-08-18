import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppComponent } from './app.component';
import {AppRoutingModule} from "./app-routing.module";
import {HttpClientModule} from "@angular/common/http";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {AppMaterialModule} from "./app-material.module";
import {FormsModule} from "@angular/forms";
import {ShellComponent} from "./home/shell.component";
import {WelcomeComponent} from "./home/welcome.component";
import {PageNotFoundComponent} from "./home/page-not-found.component";
import {YnabService} from "./home/ynab.service";
import {BudgetsComponent} from "./home/budgets.component";
import {PrivacyService} from "./home/privacy.service";
import {CardLinkService} from "./home/card-link.service";

@NgModule({
    imports: [
        BrowserModule,
        BrowserAnimationsModule,
        AppMaterialModule,
        FormsModule,
        HttpClientModule,
        AppRoutingModule,
    ],
    declarations: [
        AppComponent,
        ShellComponent,
        WelcomeComponent,
        BudgetsComponent,
        PageNotFoundComponent
    ],
    providers: [
        YnabService,
        PrivacyService,
        CardLinkService
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
