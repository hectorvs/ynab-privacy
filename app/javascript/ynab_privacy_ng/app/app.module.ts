import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import {AppMaterialModule} from "./app-material.module";
import {AppRoutingModule} from "./app-routing.module";
import {HttpClientModule} from "@angular/common/http";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {FormsModule} from "@angular/forms";
import {ShellComponent} from "./home/shell.component";
import {WelcomeComponent} from "./home/welcome.component";
import {PageNotFoundComponent} from "./home/page-not-found.component";
import {YnabService} from "./home/ynab.service";

@NgModule({
    imports: [
        BrowserModule,
        FormsModule,
        BrowserAnimationsModule,
        AppMaterialModule,
        HttpClientModule,
        AppRoutingModule,
    ],
    declarations: [
        AppComponent,
        ShellComponent,
        WelcomeComponent,
        PageNotFoundComponent
    ],
    providers: [YnabService],
    bootstrap: [AppComponent]
})
export class AppModule { }
