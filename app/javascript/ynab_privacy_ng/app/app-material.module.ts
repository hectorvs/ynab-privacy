import { NgModule, Type } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
    MatSidenavModule,
    MatToolbarModule,
    MatListModule,
    MatTableModule,
    MatButtonModule,
    MatIconModule,
    MatCardModule,
    MatInputModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatNativeDateModule,
    MatSnackBarModule,
    MatDialogModule,
    MatGridListModule,
    MatTabsModule,
    MatProgressSpinnerModule,
    MatCheckboxModule,
    MatSelectModule,
    MatBadgeModule,
    MatStepperModule
} from '@angular/material';

const materialDesignComponents: ReadonlyArray<Type<any>> = [
    MatSidenavModule,
    MatToolbarModule,
    MatListModule,
    MatTableModule,
    MatButtonModule,
    MatIconModule,
    MatCardModule,
    MatInputModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatNativeDateModule,
    MatSnackBarModule,
    MatDialogModule,
    MatGridListModule,
    MatTabsModule,
    MatProgressSpinnerModule,
    MatCheckboxModule,
    MatSelectModule,
    MatBadgeModule,
    MatStepperModule
];


@NgModule({
    imports: [
        CommonModule,
        ...materialDesignComponents
    ],
    exports: [
        ...materialDesignComponents
    ]
})

export class AppMaterialModule { }