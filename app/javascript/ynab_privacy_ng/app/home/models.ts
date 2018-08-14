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