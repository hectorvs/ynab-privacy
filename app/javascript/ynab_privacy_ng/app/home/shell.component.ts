import { Component, OnInit } from '@angular/core';

@Component({
    selector: 'al-ps-ui-shell',
    template: `
    <div class='row'>
        <div class="col-md-12">
            <router-outlet></router-outlet>
        </div>
    </div>
    `
})
export class ShellComponent implements OnInit {

    constructor() { }

    ngOnInit() { }
}
