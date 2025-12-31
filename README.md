# 🔒 Terraform Lab 25: Remote Backend & State Locking

Este proyecto implementa una infraestructura segura de Terraform utilizando un **Backend Remoto en AWS S3** con **Bloqueo de Estado (State Locking)** mediante DynamoDB.

## 🎯 Objetivo
Migrar el estado local de Terraform (`terraform.tfstate`) a la nube para permitir:
1.  **Colaboración Segura:** Evitar conflictos cuando múltiples ingenieros trabajan simultáneamente.
2.  **Seguridad:** Encriptación del archivo de estado en reposo.
3.  **Recuperación ante Desastres (DR):** Versionado automático para recuperar estados previos en caso de corrupción o borrado accidental.

## 🏗️ Arquitectura
* **AWS S3 Bucket:** Almacenamiento persistente y versionado del archivo de estado.
* **AWS DynamoDB Table:** Control de concurrencia mediante `LockID` para prevenir condiciones de carrera (Race Conditions).
* **Terraform:** IaC para orquestar la infraestructura.

## 🛡️ Características de Seguridad Implementadas
* ✅ **State Locking:** Uso de DynamoDB para bloquear escrituras simultáneas.
* ✅ **Encryption:** El bucket S3 tiene encriptación activada.
* ✅ **Versioning:** Historial de cambios activado en S3 para revertir cambios destructivos.
* ✅ **Git Ignore:** El archivo `.tfstate` con datos sensibles está excluido del repositorio.

## 🚀 Cómo usar este proyecto

### Prerrequisitos
* Terraform instalado.
* AWS CLI configurado con credenciales adecuadas.

### Despliegue
1.  Inicializar el backend (migra el estado a S3):
    ```bash
    terraform init
    ```
2.  Verificar el plan de ejecución:
    ```bash
    terraform plan
    ```
3.  Aplicar cambios:
    ```bash
    terraform apply
    ```

## 🧪 Pruebas Realizadas
1.  **Simulación de Bloqueo:** Se verificó que `terraform plan` falla si otra sesión tiene un bloqueo activo en DynamoDB.
2.  **Recuperación de Estado:** Se simuló el borrado del archivo `.tfstate` en S3 y se recuperó exitosamente mediante el versionado del bucket.

---
*Lab realizado como parte del camino a Cloud Security Engineer.*
