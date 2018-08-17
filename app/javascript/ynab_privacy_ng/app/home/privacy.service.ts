import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Card} from "./models";
import {Observable} from "rxjs";

@Injectable()
export class PrivacyService {
    constructor(private http: HttpClient) {}

    listCards(): Observable<Card[]> {
        return this.http.get<Card[]>('/privacy/cards');
    }

}
