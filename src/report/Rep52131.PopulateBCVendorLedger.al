report 52131 "Populate BC Vendor Ledger"
{
    Caption = 'Populate BC Vendor Ledger';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "Vendor No.";

            trigger OnAfterGetRecord()
            var
                BCVendorLedger: Record "BC Vendor Ledger";
            begin
                if not BCVendorLedger.Get("Vendor Ledger Entry"."Entry No.", "Vendor Ledger Entry"."Document No.") then begin
                    BCVendorLedger.Init();
                    BCVendorLedger."Entry No." := "Vendor Ledger Entry"."Entry No.";
                    BCVendorLedger."Document No." := "Vendor Ledger Entry"."Document No.";
                end;

                BCVendorLedger."Posting Date" := "Vendor Ledger Entry"."Posting Date";
                BCVendorLedger."Vendor No." := "Vendor Ledger Entry"."Vendor No.";
                BCVendorLedger."Amount" := "Vendor Ledger Entry".Amount;

                if BCVendorLedger."Entry No." = 0 then
                    BCVendorLedger.Insert()
                else
                    BCVendorLedger.Modify();

                RecordsProcessed += 1;
            end;

            trigger OnPreDataItem()
            begin
                RecordsProcessed := 0;
            end;

            trigger OnPostDataItem()
            begin
                Message('Processing completed. %1 Vendor Ledger Entry records have been processed to BC Vendor Ledger.', RecordsProcessed);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ClearExisting; ClearExisting)
                    {
                        ApplicationArea = All;
                        Caption = 'Clear Existing Records';
                        ToolTip = 'If enabled, all existing records in BC Vendor Ledger will be deleted before importing.';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ClearExisting := false;
        end;
    }

    trigger OnPreReport()
    var
        BCVendorLedger: Record "BC Vendor Ledger";
    begin
        if ClearExisting then
            if Confirm('Are you sure you want to delete all existing records in BC Vendor Ledger?', false) then
                BCVendorLedger.DeleteAll();
    end;

    var
        RecordsProcessed: Integer;
        ClearExisting: Boolean;
}