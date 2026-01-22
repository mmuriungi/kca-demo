page 52178594 "Proc-Committee List"
{
    CardPageId = "Proc-Committee Card";
    Caption = 'Proc-Committee List';
    PageType = List;
    SourceTable = "Proc-Committee Appointment H";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Ref No"; Rec."Ref No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ref No field.';
                }
                field("Tender/Quote No"; Rec."Tender/Quote No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Quote No field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
