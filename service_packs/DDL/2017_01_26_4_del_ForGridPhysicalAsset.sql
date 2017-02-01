
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.del_ForGridPhysicalAsset',N'P') IS NOT NULL
   DROP PROCEDURE dbo.del_ForGridPhysicalAsset;
GO

CREATE PROCEDURE [dbo].[del_ForGridPhysicalAsset]
	@ID int,
	@Description nvarchar(50),
	@FixedAssetID int,
	@PAClassID int = 1,	
	@PhysicalAssetClassID int
AS
BEGIN

delete from PhysicalAsset where PhysicalAsset.ID = @ID

end
