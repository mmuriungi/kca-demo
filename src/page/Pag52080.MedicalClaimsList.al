page 52080 "Medical Claims List"
{
    ApplicationArea = All;
    Caption = 'Medical Claims List';
    PageType = List;
    CardPageId = "Medical Claims Card";
    SourceTable = "HRM-Medical Claims";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Claim No"; Rec."Claim No")
                {
                    ToolTip = 'Specifies the value of the Claim No field.', Comment = '%';
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ToolTip = 'Specifies the value of the Claim Type field.', Comment = '%';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Member Names"; Rec."Member Names")
                {
                    ToolTip = 'Specifies the value of the Member Names field.', Comment = '%';
                }
                field("Facility Attended"; Rec."Facility Attended")
                {
                    ToolTip = 'Specifies the value of the Facility Attended field.', Comment = '%';
                }
                field("Facility Name"; Rec."Facility Name")
                {
                    ToolTip = 'Specifies the value of the Facility Name field.', Comment = '%';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Scheme No"; Rec."Scheme No")
                {
                    ToolTip = 'Specifies the value of the Scheme No field.', Comment = '%';
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ToolTip = 'Specifies the value of the Date of Service field.', Comment = '%';
                }
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ToolTip = 'Specifies the value of the Claim Amount field.', Comment = '%';
                }
                field("Available Balance"; GetAvailableBalanceForClaimType())
                {
                    Caption = 'Available Balance';
                    ToolTip = 'Shows the available balance for this claim type';
                    Editable = false;
                    Style = Favorable;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetCurrentFiscalYearFilter();
        Rec.CalcFields("Employee Category", "Salary Grade");
    end;

    local procedure GetAvailableBalanceForClaimType(): Decimal
    begin
        exit(Rec.GetAvailableBalance(Rec."Claim Type"));
    end;
}
