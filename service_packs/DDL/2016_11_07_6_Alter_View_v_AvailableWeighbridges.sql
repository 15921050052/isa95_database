﻿SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.v_AvailableWeighbridges',N'V') IS NOT NULL
  DROP VIEW dbo.v_AvailableWeighbridges;
GO

SET ANSI_PADDING OFF
GO



CREATE VIEW [dbo].[v_AvailableWeighbridges]
AS

select distinct
	area.ID			as [ID],
	workshop.[Description]+'\'+area.[Description]	as [Description],
	ep1.Value		as [ScaleID]
from 
	dbo.Person p,
	dbo.PersonProperty pp,
	dbo.PersonnelClassProperty pcp,
	dbo.EquipmentProperty ep,
    dbo.EquipmentClassProperty ecp,
	dbo.Equipment workshop,
	dbo.Equipment area,
	dbo.EquipmentProperty ep1,
    dbo.EquipmentClassProperty ecp1

where	p.ID = dbo.get_CurrentPerson()
	and pp.PersonID = p.ID
	AND pcp.Value = 'WORK_WITH'
	AND pcp.ID = pp.ClassPropertyID
	AND ep.Value = pp.Value
	AND ep.ClassPropertyID = ecp.ID
	AND ecp.Value = 'WEIGHBRIDGES_ID'
	AND ep.EquipmentID = workshop.ID
	AND workshop.id=area.Equipment
	AND area.ID = ep1.EquipmentID
	AND ep1.ClassPropertyID = ecp1.ID
	AND ecp1.Value = 'SCALES_NO';


GO