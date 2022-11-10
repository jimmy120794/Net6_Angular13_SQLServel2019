import { Component, OnInit, Inject } from '@angular/core';
import { Observable } from 'rxjs';
import { InspectionApiService } from 'src/app/inspection-api.service';

// Angular material
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';

export interface Inspection {
  status?: string;
  comments?: string;
  inspectionTypeId?: number;
}

export interface DialogData {
  isComplet: boolean;
  id: number;
  status: string;
  comments: string;
  inspectionTypeId: number;
  statusList$: Observable<any[]>;
  inspectionList$: Observable<any[]>;
  inspectionTypesList$: Observable<any[]>
}
@Component({
  selector: 'app-show-inspection',
  templateUrl: './show-inspection.component.html',
  styleUrls: ['./show-inspection.component.css']
})
export class ShowInspectionComponent implements OnInit {

  inspectionList$!:Observable<any[]>;
  inspectionTypesList$!:Observable<any[]>;
  inspectionTypesList:any=[];

  isComplet = false
  inspectionObj: Inspection = {}
  statusList$!: Observable<any[]>;

  // Map to display data associate with foreign keys
  inspectionTypesMap:Map<number, string> = new Map()

  constructor(private service:InspectionApiService, public dialog: MatDialog) { }


  ngOnInit(): void {
    this.inspectionList$ = this.service.getInspectionList();
    this.inspectionTypesList$ = this.service.getInspectionTypesList();
    this.refreshInspectionTypesMap();

    this.statusList$ = this.service.getStatusList();
  }

  // Variables (properties)
  modalTitle:string = '';
  activateAddEditInspectionComponent:boolean = false;
  inspection:any;

  modalEdit(item:any) {
    this.inspection = item;
    this.modalTitle = "Editar Inspección";
    this.activateAddEditInspectionComponent = true;
  }

  delete(item:any) {
    if(confirm(`Estas seguro que quieres eliminar la inspección ${item.id}`)) {
      this.service.deleteInspection(item.id).subscribe(res => {
        var closeModalBtn = document.getElementById('add-edit-modal-close');
      if(closeModalBtn) {
        closeModalBtn.click();
      }

      var showDeleteSuccess = document.getElementById('delete-success-alert');
      if(showDeleteSuccess) {
        showDeleteSuccess.style.display = "block";
      }
      setTimeout(function() {
        if(showDeleteSuccess) {
          showDeleteSuccess.style.display = "none"
        }
      }, 4000);
      this.inspectionList$ = this.service.getInspectionList();
      })
    }
  }

  modalClose() {
    this.activateAddEditInspectionComponent = false;
    this.inspectionList$ = this.service.getInspectionList();
  }

  refreshInspectionTypesMap() {
    this.service.getInspectionTypesList().subscribe(data => {
      this.inspectionTypesList = data;

      for(let i = 0; i < data.length; i++)
      {
        this.inspectionTypesMap.set(this.inspectionTypesList[i].id, this.inspectionTypesList[i].inspectionName);
      }
    })
  }

  openDialog2(): void {
    const dialogRef = this.dialog.open(DialogAddInspection, {
      width: '300px',
      data: {
        isComplet: this.isComplet, 
        statusList$: this.statusList$,
        inspectionList$: this.inspectionList$,
        inspectionTypesList$: this.inspectionTypesList$
      },
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed', result);
      this.isComplet = false;
      this.inspectionList$ = this.service.getInspectionList();
    });
  }

}

@Component({
  selector: 'dialog-add-inspection',
  templateUrl: './dialogAddInspection.html',
})
export class DialogAddInspection implements OnInit {

  isComplet: boolean = false
  inspectionObj: Inspection = {}

  id: number = 0;
  status: string = "";
  comments: string = "";
  inspectionTypeId!: number;

  inspectionTypesList$!: Observable<any[]>;
  statusList$!: Observable<any[]>;
  

  constructor(
    public dialogRef: MatDialogRef<DialogAddInspection>,
    private service:InspectionApiService,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
  ) {}

  ngOnInit(): void {

    this.isComplet =  this.data.isComplet
    this.statusList$  = this.data.statusList$
    this.inspectionTypesList$  = this.data.inspectionTypesList$
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  addInspection() {

      this.inspectionObj = {
        status:this.status,
        comments:this.comments,
        inspectionTypeId:this.inspectionTypeId
      }

      if (this.inspectionObj.status !== '' && this.inspectionObj.comments !== '' && this.inspectionObj.inspectionTypeId !== undefined ){
        this.service.addInspection(this.inspectionObj).subscribe(res => {
          
          this.dialogRef.close();
    
          var showAddSuccess = document.getElementById('add-success-alert');
          if(showAddSuccess) {
            showAddSuccess.style.display = "block";
          }
          setTimeout(function() {
            if(showAddSuccess) {
              showAddSuccess.style.display = "none"
            }
          }, 9000);
        })
      }else{
        this.isComplet = true;
        confirm(`[${this.isComplet}] Completar el formulario, por favor!`)
      }
      
    }
}
