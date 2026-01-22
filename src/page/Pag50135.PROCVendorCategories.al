page 50135 "PROC-Vendor Categories"
{
    PageType = Worksheet;
    SourceTable = "PROC-Vendor Categories";
    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("Code"; Rec."Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}