report 52178537 "Office Equipments Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Office Equipments.rdl';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            DataItemTableView = where("FA Class Code" = filter('TANGIBLE'), "FA Subclass Code" = filter('OFF EQU'));
            column(CompInfoName; CompInfo.Name)
            {

            }
            column(CompInfoPicture; CompInfo.Picture)
            {

            }
            column(CompInfoAddress; CompInfo.Address)
            {

            }
            column(CompInfoPhone; CompInfo."Phone No.")
            {

            }
            column(CompInfoEmail; CompInfo."E-Mail")
            {

            }
            column(CompInfoWebPage; CompInfo."Home Page")
            {

            }
            column(No_FixedAsset; "No.")
            {

            }
            column(FIxedAssetLocation_FixedAsset; "Current Location")
            {
            }
            column(Revaluation_FixedAsset; "No.")
            {
                // Field 'Revaluation' doesn't exist, using No. as placeholder
            }
            column(Description_FixedAsset; Description)
            {
            }
            column(Description2_FixedAsset; "Description 2")
            {
            }
            column(ModeofAcquisition_FixedAsset; "Source of Funds")
            {
                // Using Source of Funds instead of Mode of Acquisition
            }
            column(Category_FixedAsset; "FA Subclass Code")
            {
                // Using FA Subclass Code instead of Category
            }
            column(County_FixedAsset; "Global Dimension 1 Code")
            {
                // Using Global Dimension 1 Code instead of County
            }
            column(NearestTown_FixedAsset; "Current Location")
            {
                // Using Current Location instead of Nearest Town
            }
            column(LRNo_FixedAsset; "Serial No")
            {
                // Using Serial No instead of L.R No.
            }
            column(OwnershipStatus_FixedAsset; "FA Class Code")
            {
                // Using FA Class Code instead of Ownership Status
            }
            column(DocumentofOwnership_FixedAsset; "Payment Voucher No.")
            {
                // Using Payment Voucher No. instead of Document of Ownership
            }
            column(LandSize_FixedAsset; "Manufacturer")
            {
                // Using Manufacturer instead of Land Size
            }
            column(Remarks_FixedAsset; "Notes")
            {
                // Using Notes instead of Remarks
            }
            column(AnnualRentalIncome_FixedAsset; "Purchase Amount")
            {
                // Using Purchase Amount instead of Annual Rental Income
            }
            column(BuildingOwnership_FixedAsset; "Vendor")
            {
                // Using Vendor instead of Building Ownership
            }
            column(BuildingNo_FixedAsset; "Asset Code")
            {
                // Using Asset Code instead of Building No
            }
            column(SourceofFunds_FixedAsset; "Source of Funds")
            {
            }
            column(TypeofBuilding_FixedAsset; "Asset Description")
            {
                // Using Asset Description instead of Type of Building
            }
            column(DesignatedUse_FixedAsset; "Asset Condition")
            {
                // Using Asset Condition instead of Designated Use
            }
            column(EstimatedUsefulLife_FixedAsset; "Depreciation Rate")
            {
                // Using Depreciation Rate instead of Estimated Useful Life
            }
            column(NoofFloors_FixedAsset; "Asset Nos")
            {
                // Using Asset Nos instead of No of Floors
            }
            column(PlinthArea_FixedAsset; "Purchase Amount")
            {
                // Using Purchase Amount instead of Plinth Area
            }
            column(VehicleRegistrationNo_FixedAsset; "Registration No.")
            {
            }
            column(EngineNo_FixedAsset; "Barcode")
            {
                // Using Barcode instead of Engine No
            }
            column(ChasisNo_FixedAsset; "Serial No")
            {
                // Using Serial No instead of Chasis No
            }
            column(TagNo_FixedAsset; "Tag No")
            {
            }
            column(Model_FixedAsset; Model)
            {
            }
            column(YearofPurchase_FixedAsset; "Date of Delivery")
            {
                // Using Date of Delivery instead of Year of Purchase
            }
            column(RevaluationDate_FixedAsset; "Last Physical Check")
            {
                // Using Last Physical Check instead of Revaluation Date
            }
            column(PvNumber_FixedAsset; "Payment Voucher No.")
            {
            }
            column(OriginalLocation_FixedAsset; "Location Code")
            {
                // Note: Location Code has been modified with Caption = 'Original Location'
            }
            column(ReplacementDate_FixedAsset; "Replacement Date")
            {
            }
            column(LocationCode_FixedAsset; "Location Code")
            {
            }
            column(ResponsibleEmployee_FixedAsset; "Responsible Employee")
            {
            }
            column(Condition_FixedAsset; "Asset Condition")
            {
            }
            column(SerialNo_FixedAsset; "Serial No.")
            {
            }
            column(DeliveryDate_FixedAsset; "Date of Delivery")
            {
            }
            column(AcquiredFrom_FixedAsset; "Vendor")
            {
                // Using Vendor instead of Acquired From
            }
            column(DocumentName; DocumentName)
            {

            }
            column(InstitutionNo_FixedAsset; "Asset Nos")
            {
                // Using Asset Nos instead of Institution No
            }
            column(Notes_FixedAsset; Notes)
            {
            }
            column(Street_FixedAsset; "Current Location")
            {
                // Using Current Location instead of Street
            }
            column(EmpName; EmpName)
            {

            }
            column(seq; seq)
            {

            }
            dataitem(FADepreciationBook; "FA Depreciation Book")
            {
                DataItemLink = "FA No." = field("No.");
                column(AcquisitionCost_FADepreciationBook; "Acquisition Cost")
                {
                }
                column(AcquisitionDate_FADepreciationBook; "Acquisition Date")
                {
                }
                column(BookValue_FADepreciationBook; "Book Value")
                {
                }
                column(BookValueonDisposal_FADepreciationBook; "Book Value on Disposal")
                {
                }
                column(DepreciationEndingDate_FADepreciationBook; "Depreciation Ending Date")
                {
                }
                column(DisposalDate_FADepreciationBook; "Disposal Date")
                {
                }
                column(EndingBookValue_FADepreciationBook; "Ending Book Value")
                {
                }
                column(NoofDepreciationMonths_FADepreciationBook; "No. of Depreciation Months")
                {
                }
                column(NoofDepreciationYears_FADepreciationBook; "No. of Depreciation Years")
                {
                }
                column(ProjectedDisposalDate_FADepreciationBook; "Projected Disposal Date")
                {
                }
                column(SalvageValue_FADepreciationBook; "Salvage Value")
                {
                }
                column(StraightLine_FADepreciationBook; "Straight-Line %")
                {
                }
                column(DepreciationStartingDate_FADepreciationBook; "Depreciation Starting Date")
                {
                }
                column(DepreciationMethod_FADepreciationBook; "Depreciation Method")
                {
                }
                column(Depreciation_FADepreciationBook; Depreciation)
                {
                }
                column(DecliningBalance_FADepreciationBook; "Declining-Balance %")
                {
                }
                column(AccumDeprCustom1_FADepreciationBook; "Accum. Depr. % (Custom 1)")
                {
                }
                column(Description_FADepreciationBook; Description)
                {
                }
                column(FixedDeprAmount_FADepreciationBook; "Fixed Depr. Amount")
                {
                }
                column(LastAcquisitionCostDate_FADepreciationBook; "Last Acquisition Cost Date")
                {
                }
                column(LastDepreciationDate_FADepreciationBook; "Last Depreciation Date")
                {
                }
                column(LastMaintenanceDate_FADepreciationBook; "Last Maintenance Date")
                {
                }
                column(Maintenance_FADepreciationBook; Maintenance)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SetAutoCalcFields("Book Value", Depreciation, "Acquisition Cost", "Custom 1", "Custom 2", "Book Value on Disposal");
                end;
            }
            dataitem(FALedgerEntries; "FA Ledger Entry")
            {
                DataItemLink = "FA No." = field("No.");
                column(AmountLCY_FALedgerEntries; "Amount (LCY)")
                {
                }
                column(Amount_FALedgerEntries; Amount)
                {
                }
                column(DocumentType_FALedgerEntries; "Document Type")
                {
                }
                column(DocumentDate_FALedgerEntries; "Document Date")
                {
                }
                column(ExternalDocumentNo_FALedgerEntries; "External Document No.")
                {
                }
                column(FAPostingType_FALedgerEntries; "FA Posting Type")
                {
                }
                column(FixedDeprAmount_FALedgerEntries; "Fixed Depr. Amount")
                {
                }
            }
            trigger OnPreDataItem()
            begin
                FixedAsset.SetFilter("FA SubClass Code", '%1', SubClassCode);
                seq := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
                FaSubClass.Reset();
                FaSubClass.SetRange("FA Class Code", ClassCode);
                if FaSubClass.Find('-') then begin
                    DocumentName := FaSubClass.Name + ' Register';
                end;
                HrmEmp.Reset();
                HrmEmp.SetRange("No.", "Responsible Employee");
                if HrmEmp.Find('-') then
                    EmpName := HrmEmp."First Name" + ' ' + HrmEmp."Middle Name" + ' ' + HrmEmp."Last Name";
            end;
        }
    }

    trigger OnInitReport()
    begin
        ClassCode := 'TANGIBLE';
        SubClassCode := 'OFF EQU';
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;

    var
        seq: Integer;
        ClassCode: Code[50];
        SubClassCode: Code[50];
        FaSubClass: Record "FA Subclass";
        FaClass: Record "FA Class";
        DocumentName: Text;
        CompInfo: Record "Company Information";
        HrmEmp: Record "HRM-Employee C";
        EmpName: text;
}

