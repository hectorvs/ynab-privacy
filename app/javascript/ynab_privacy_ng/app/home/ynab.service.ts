import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Budget} from "./models";
import {Observable} from "rxjs";

@Injectable()
export class YnabService {
    constructor(private http: HttpClient) {}

    listBudgets(): Observable<Budget[]> {
        return this.http.get<Budget[]>('/ynab/budgets');
    }
}
