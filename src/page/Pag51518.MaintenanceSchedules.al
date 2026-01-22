page 51518 "Maintenance Schedules"
{
    Caption = 'Maintenance Schedules';
    PageType = List;
    SourceTable = "Maintenance Schedule";
    CardPageId = "Maintence Schedule";

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
                field(Desciption; Rec.Desciption)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desciption field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Maintenance; Rec.Maintenance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance field.';
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
    begin
        if (Rec.Status <> Rec.Status::Open) then
            CurrPage.Editable := false;
    end;
}
