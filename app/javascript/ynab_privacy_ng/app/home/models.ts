export interface Budget {
    id: string;
    name: string;
    last_modified_on: string;
    date_format: DateFormat;
    currency_format: CurrencyFormat;
}

export interface DateFormat {
    format: string;
}

export interface CurrencyFormat {
    iso_code: string;
    example_format: string;
    decimal_digits: number;
    decimal_separator: string;
    symbol_first: boolean;
    group_separator: string;
    currency_symbol: string;
    display_symbol:boolean;
}

export interface CategoryGroup {
    id: string;
    name: string;
    hidden: boolean;
    deleted: boolean;
    categories: Category[]
}

export interface Category {
    id: string;
    category_group_id: string;
    name: string;
    hidden: boolean;
    budgeted: number;
    activity: number;
    balance: number;
    goal_target: number;
    goal_percentage_complete: number;
    deleted: boolean;
}

export interface Account {
    id: string;
    name: string;
    type: string;
    on_budget: boolean;
    closed: boolean;
    balance: number;
    cleared_balance: number;
    uncleared_balance: number;
    deleted: boolean;
}

export class Card {
    funding: CardFunding;
    hostname: string;
    last_four: string;
    memo: string;
    spend_limit: number;
    spend_limit_duration: string;
    state: string;
    token: string;
    type: string;
}

export interface CardFunding {
    account_name: string;
    token: string;
    type: string;
}

export class CategoryCardLink {
    id: string;
    privacy_card_id: string;
    account_id: string;
    category_id: string;
    category_name: string;
    privacy_card_name: string;
    constructor(privacy_card_id: string,
                account_id: string,
                category_id: string,
                category_name: string,
                privacy_card_name: string )  {
        this.privacy_card_id = privacy_card_id;
        this.account_id = account_id;
        this.category_id =  category_id;
        this.category_name = category_name;
        this.privacy_card_name =  privacy_card_name;
    }
}
