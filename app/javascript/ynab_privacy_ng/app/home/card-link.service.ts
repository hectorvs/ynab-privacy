import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Category, CategoryCardLink} from "./models";
import {concat, Observable} from "rxjs";

@Injectable()
export class CardLinkService {
    constructor(private http: HttpClient) {}

    listCardLinks(): Observable<CategoryCardLink[]> {
        return this.http.get<CategoryCardLink[]>('/links');
    }

    postCardLink(cardLink: CategoryCardLink): Observable<CategoryCardLink> {
        return this.http.post<CategoryCardLink>('/links', { 'category_card_link': cardLink } );
    }

    deleteCardLink(cardLinkId: string) {
        return this.http.delete(`/links/${cardLinkId}`);
    }
}
