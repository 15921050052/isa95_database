﻿IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'ISA95_OPERATION_DEFINITION')
	EXEC sp_executesql N'CREATE SCHEMA ISA95_OPERATION_DEFINITION;';
go

ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.OperationsDefinition; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.OperationsMaterialBill; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.OperationsMaterialBillItem; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.OperationsSegment; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.MaterialSpecification; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.MaterialSpecificationProperty;
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.EquipmentSpecification; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.EquipmentSpecificationProperty; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.ParameterSpecification; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.PersonnelSpecification; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.PersonnelSpecificationProperty;
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.PhysicalAssetSpecification; 
ALTER SCHEMA [ISA95_OPERATION_DEFINITION] TRANSFER OBJECT::dbo.PhysicalAssetSpecificationProperty; 
go
