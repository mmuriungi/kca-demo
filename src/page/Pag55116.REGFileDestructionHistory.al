page 55116 "REG-FileDestruction History"
{
    Caption = 'REG-FileDestruction History';
    PageType = List;
    SourceTable = "REG-Archives Register";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where("Destroyed Date" = filter(<> 0D));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;

                }
                field("Destroyed Date"; Rec."Destroyed Date")
                {
                    ToolTip = 'Specifies the value of the Destroyed Date field.';
                    ApplicationArea = All;
                }
                field("Destroyed By"; Rec."Destroyed By")
                {
                    ToolTip = 'Specifies the value of the Destroyed By field.';
                    ApplicationArea = All;
                }
                field("Version"; Rec."Version")
                {
                    ToolTip = 'Specifies the value of the Version field.';
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                    ApplicationArea = All;
                }
                field("Ref No."; Rec."Ref No.")
                {
                    ToolTip = 'Specifies the value of the Ref No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
