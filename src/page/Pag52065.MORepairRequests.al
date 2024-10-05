page 52065 "MO Repair Requests"
{
    PageType = List;
    SourceTable = "Repair Request";
    CardPageId = "Repair Request";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Facility No."; Rec."Facility No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facility No. field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Repair Description"; Rec."Repair Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Repair Description field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        Emp: Record "HRM-Employee C";
        MO: record "Maintenance Officer";
        Filters: Text;
    begin
        MO.Reset();
        MO.SetRange("Repair No.", Rec."No.");
        Mo.SetAutoCalcFields("User ID");
        if MO.FindSet() then begin
            repeat
                Filters += MO."Repair No." + '|';
            until mo.Next() = 0;
        end;
        Filters := DelChr(Filters, '>', '|');
        Rec.filtergroup(2);
        Rec.SetFilter("No.", Filters);
    end;
}
