report 52130 "Populate BC GL Ledger"
{
    Caption = 'Populate BC GL Ledger';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "G/L Account No.";

            trigger OnAfterGetRecord()
            var
                BCGLLedger: Record "BC GL Ledger";
            begin
                if not BCGLLedger.Get("G/L Entry"."Entry No.", "G/L Entry"."Document No.") then begin
                    BCGLLedger.Init();
                    BCGLLedger."Entry No." := "G/L Entry"."Entry No.";
                    BCGLLedger."Document No." := "G/L Entry"."Document No.";
                end;

                BCGLLedger."Posting Date" := "G/L Entry"."Posting Date";
                BCGLLedger."Account No." := "G/L Entry"."G/L Account No.";
                BCGLLedger."Amount" := "G/L Entry".Amount;

                if BCGLLedger."Entry No." = 0 then
                    BCGLLedger.Insert()
                else
                    BCGLLedger.Modify();

                RecordsProcessed += 1;
            end;

            trigger OnPreDataItem()
            begin
                RecordsProcessed := 0;
            end;

            trigger OnPostDataItem()
            begin
                Message('Processing completed. %1 G/L Entry records have been processed to BC GL Ledger.', RecordsProcessed);
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
                        ToolTip = 'If enabled, all existing records in BC GL Ledger will be deleted before importing.';
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
        BCGLLedger: Record "BC GL Ledger";
    begin
        if ClearExisting then
            if Confirm('Are you sure you want to delete all existing records in BC GL Ledger?', false) then
                BCGLLedger.DeleteAll();
    end;

    var
        RecordsProcessed: Integer;
        ClearExisting: Boolean;
}