import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Budget, CategoryGroup }  from "./models";
import {Observable} from "rxjs";

@Injectable()
export class YnabService {
    constructor(private http: HttpClient) {}

    listBudgets(): Observable<Budget[]> {
        return this.http.get<Budget[]>('/ynab/budgets');
    }

    listCategories(budget_id: string): Observable<CategoryGroup[]> {
        return this.http.get<CategoryGroup[]>(`/ynab/budgets/${budget_id}/categories`)
    }

}
