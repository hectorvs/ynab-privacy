import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Account, Budget, CategoryGroup }  from "./models";
import {Observable} from "rxjs";

@Injectable()
export class YnabService {
    constructor(private http: HttpClient) {}

    listBudgets(): Observable<Budget[]> {
        return this.http.get<Budget[]>('/ynab/budgets');
    }

    listAccounts(budget_id: string): Observable<Account[]> {
        return this.http.get<Account[]>(`/ynab/budgets/${budget_id}/accounts`)
    }

    listCategories(budget_id: string): Observable<CategoryGroup[]> {
        return this.http.get<CategoryGroup[]>(`/ynab/budgets/${budget_id}/categories`)
    }

}
