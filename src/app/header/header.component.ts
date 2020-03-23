import { Component } from '@angular/core';


@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
})
export class HeaderComponent {
  listaModulos: string[]=['Actualizar Datos','Asignación de Caja','Bloqueos','Creación de Usuarios','Creación de Cuentas', 'Depósitos y Retiros', 'Pagos de Planilla', 'Reportes',
   'Transferencia de Personal', 'Configuración'];
  title:string   = 'Banco de Chinautla S.A.';
  habilitar: boolean=true;

  setHabilitar(): void {
      this.habilitar=(this.habilitar==true)?false:true;
    };

}
