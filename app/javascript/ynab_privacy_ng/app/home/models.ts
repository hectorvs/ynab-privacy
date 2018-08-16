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