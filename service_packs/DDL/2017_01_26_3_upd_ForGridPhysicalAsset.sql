
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.upd_ForGridPhysicalAsset',N'P') IS NOT NULL
   DROP PROCEDURE dbo.upd_ForGridPhysicalAsset;
GO

CREATE PROCEDURE [dbo].[upd_ForGridPhysicalAsset]
	@ID int,
	@Description nvarchar(50),
	@FixedAssetID int,
	@PAClassID int = 1,	
	@PhysicalAssetClassID int
AS
BEGIN

IF @FixedAssetID < 1 
BEGIN
    set @FixedAssetID = null;
END

update PhysicalAsset set PhysicalAsset.Description = @Description, PhysicalAsset.FixedAssetID = @FixedAssetID,
PhysicalAsset.PhysicalAssetClassID = @PhysicalAssetClassID
where PhysicalAsset.ID = @ID

end