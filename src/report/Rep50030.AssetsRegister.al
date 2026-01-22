report 50030 "Assets Register"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = rdlc;
    RDLCLayout = './Layouts/Rep50030.AssetsRegister.rdl';

    dataset
    {
        dataitem(assets; "Fixed Asset")
        {

            column(No_assets; "No.")
            {
            }
            column(Description_assets; Description)
            {
            }
            column(SearchDescription_assets; "Search Description")
            {
            }
            column(Description2_assets; "Description 2")
            {
            }
            column(FAClassCode_assets; "FA Class Code")
            {
            }
            column(FASubclassCode_assets; "FA Subclass Code")
            {
            }
            column(GlobalDimension1Code_assets; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_assets; "Global Dimension 2 Code")
            {
            }
            column(LocationCode_assets; "Location Code")
            {
            }
            column(VendorNo_assets; "Vendor No.")
            {
            }
            column(MainAssetComponent_assets; "Main Asset/Component")
            {
            }
            column(ComponentofMainAsset_assets; "Component of Main Asset")
            {
            }
            column(FALocationCode_assets; "FA Location Code")
            {
            }
            column(ResponsibleEmployee_assets; "Responsible Employee")
            {
            }
            column(SerialNo_assets; "Serial No.")
            {
            }
            column(MaintenanceVendorNo_assets; "Maintenance Vendor No.")
            {
            }
            column(UnderMaintenance_assets; "Under Maintenance")
            {
            }
            column(NextServiceDate_assets; "Next Service Date")
            {
            }
            column(RegistrationNo_assets; "Registration No.")
            {
            }
            column(TagNo_assets; "Tag No")
            {
            }
            column(AssetCode_assets; "Asset Code")
            {
            }
            column(AssetNos_assets; "Asset Nos")
            {
            }
            column(SourceofFunds_assets; "Source of Funds")
            {
            }
            column(MakeorModel_assets; "Make or Model")
            {
            }
            column(DateofDelivery_assets; "Date of Delivery")
            {
            }
            column(DatePlacedinUse_assets; "Date Placed in Use")
            {
            }
            column(ReplacementDate_assets; "Replacement Date")
            {
            }
            column(DepreciationRate_assets; "Depreciation Rate")
            {
            }
            column(DisposalDate_assets; "Disposal Date")
            {
            }
            column(DisposalAmount_assets; "Disposal Amount")
            {
            }
            column(Notes_assets; Notes)
            {
            }
            column(Vendor_assets; Vendor)
            {
            }
            column(PaymentVoucherNo_assets; "Payment Voucher No.")
            {
            }
            column(LastPhysicalCheck_assets; "Last Physical Check")
            {
            }
        }
    }


}